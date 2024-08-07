import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Home_screen.dart';
import 'package:woutickpass/services/database.dart';
import 'package:woutickpass/services/dao/settings_dao.dart';

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

  late SettingDAO _settingDao;

  @override
  void initState() {
    super.initState();
    _settingDao = SettingDAO(DatabaseHelper());
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    offlineMode = await _settingDao.loadSetting('offlineMode', true);
    showAttendeesCounter =
        await _settingDao.loadSetting('showAttendeesCounter', true);
    vibration = await _settingDao.loadSetting('vibration', true);
    receiveNotification =
        await _settingDao.loadSetting('receiveNotification', true);
    readModeNotification =
        await _settingDao.loadSetting('readModeNotification', true);
    salida = await _settingDao.loadSetting('salida', true);
    additionalSetting1 =
        await _settingDao.loadSetting('additionalSetting1', true);
    additionalSetting2 =
        await _settingDao.loadSetting('additionalSetting2', true);
    additionalSetting3 =
        await _settingDao.loadSetting('additionalSetting3', true);
    setState(() {});
  }

  Future<void> _saveSetting(String key, bool value) async {
    await _settingDao.saveSetting(key, value);
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
          const SizedBox(height: 10),
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
          _buildSwitchListTile(
            title:
                "Utilizar escáner láser en lugar de cámara (opción repetida)",
            value: additionalSetting2,
            onChanged: (bool value) {
              setState(() {
                additionalSetting2 = value;
              });
              _saveSetting('additionalSetting2', value);
            },
            backgroundColor: Colors.white,
          ),
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
            child: const Text("CERRAR SESIÓN"),
          ),
        ],
      ),
    );
  }
}
