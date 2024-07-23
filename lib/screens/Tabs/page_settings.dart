import 'package:flutter/material.dart';
import 'package:woutickpass/screens/home_screen.dart';
import 'package:woutickpass/services/settings_dao.dart';

class PageSetting extends StatefulWidget {
  const PageSetting({Key? key}) : super(key: key);

  @override
  State<PageSetting> createState() => _PageSettingState();
}

class _PageSettingState extends State<PageSetting> {
  bool offlineMode = true;
  bool showAttendeesCounter = true;
  bool vibration = true;
  bool receiveNotification = true;
  bool readModeNotification = true;
  bool salida = true;
  bool additionalSetting1 = true;
  bool additionalSetting2 = true;
  bool additionalSetting3 = true;

  final SettingsDao _dbHelper = SettingsDao();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    offlineMode = await _dbHelper.loadSetting('offlineMode', true);
    showAttendeesCounter =
        await _dbHelper.loadSetting('showAttendeesCounter', true);
    vibration = await _dbHelper.loadSetting('vibration', true);
    receiveNotification =
        await _dbHelper.loadSetting('receiveNotification', true);
    readModeNotification =
        await _dbHelper.loadSetting('readModeNotification', true);
    salida = await _dbHelper.loadSetting('salida', true);
    additionalSetting1 =
        await _dbHelper.loadSetting('additionalSetting1', true);
    additionalSetting2 =
        await _dbHelper.loadSetting('additionalSetting2', true);
    additionalSetting3 =
        await _dbHelper.loadSetting('additionalSetting3', true);
    setState(() {});
  }

  Future<void> _saveSetting(String key, bool value) async {
    await _dbHelper.saveSetting(key, value);
  }

  Future<void> _logout(BuildContext context) async {
    await _saveSetting('offlineMode', offlineMode);
    await _saveSetting('showAttendeesCounter', showAttendeesCounter);
    await _saveSetting('vibration', vibration);
    await _saveSetting('receiveNotification', receiveNotification);
    await _saveSetting('readModeNotification', readModeNotification);
    await _saveSetting('salida', salida);
    await _saveSetting('additionalSetting1', additionalSetting1);
    await _saveSetting('additionalSetting2', additionalSetting2);
    await _saveSetting('additionalSetting3', additionalSetting3);

    await _dbHelper.logout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  Widget _buildSwitchListTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color backgroundColor,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: backgroundColor,
      child: SwitchListTile(
        activeColor: const Color(0xFFCC3366),
        value: value,
        title: Text(title),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          const Text(
            "CONTROL DE ACCESOS",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const SizedBox(height: 1),
          _buildSwitchListTile(
            title: "Activar modo offline",
            value: offlineMode,
            onChanged: (bool value) {
              setState(() {
                offlineMode = value;
              });
              _saveSetting('offlineMode', value);
            },
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 1),
          _buildSwitchListTile(
            title: "Mostrar contador de asistentes",
            value: showAttendeesCounter,
            onChanged: (bool value) {
              setState(() {
                showAttendeesCounter = value;
              });
              _saveSetting('showAttendeesCounter', value);
            },
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 1),
          _buildSwitchListTile(
            title: "Vibración",
            value: vibration,
            onChanged: (bool value) {
              setState(() {
                vibration = value;
              });
              _saveSetting('vibration', value);
            },
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 1),
          _buildSwitchListTile(
            title: "Sonido al Escaneo",
            value: receiveNotification,
            onChanged: (bool value) {
              setState(() {
                receiveNotification = value;
              });
              _saveSetting('receiveNotification', value);
            },
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 1),
          _buildSwitchListTile(
            title: "Utilizar escáner láser en lugar de cámara",
            value: additionalSetting1,
            onChanged: (bool value) {
              setState(() {
                additionalSetting1 = value;
              });
              _saveSetting('additionalSetting1', value);
            },
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 1),
          _buildSwitchListTile(
            title: "Utilizar escáner láser en lugar de cámara",
            value: additionalSetting2,
            onChanged: (bool value) {
              setState(() {
                additionalSetting2 = value;
              });
              _saveSetting('additionalSetting2', value);
            },
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 1),
          _buildSwitchListTile(
            title: "Priorizar cámara para escanear",
            value: additionalSetting3,
            onChanged: (bool value) {
              setState(() {
                additionalSetting3 = value;
              });
              _saveSetting('additionalSetting3', value);
            },
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 30),
          const Text(
            "MODO DE LECTURA",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 1),
          _buildSwitchListTile(
            title: "Entradas",
            value: readModeNotification,
            onChanged: (bool value) {
              setState(() {
                readModeNotification = value;
              });
              _saveSetting('readModeNotification', value);
            },
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 1),
          _buildSwitchListTile(
            title: "Salidas",
            value: salida,
            onChanged: (bool value) {
              setState(() {
                salida = value;
              });
              _saveSetting('salida', value);
            },
            backgroundColor: Colors.white,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _logout(context);
            },
            child: const Text("CERRAR SESION"),
          ),
        ],
      ),
    );
  }
}
