import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Home_screen.dart';
import 'package:woutickpass/services/dao/settings_dao.dart';
import 'package:woutickpass/services/database.dart';

class PageSetting extends StatefulWidget {
  const PageSetting({Key? key}) : super(key: key);

  @override
  State<PageSetting> createState() => _PageSettingState();
}

class _PageSettingState extends State<PageSetting> {
  late SettingDAO _settingDAO; // Corregido

  // Variables de configuración
  bool offlineMode = true;
  bool showAttendeesCounter = true;
  bool vibration = true;
  bool receiveNotification = true;
  bool readModeNotification = true;
  bool salida = true;
  bool additionalSetting1 = true;
  bool additionalSetting2 = true;
  bool additionalSetting3 = true;

  @override
  void initState() {
    super.initState();
    _settingDAO = SettingDAO(DatabaseHelper());
    _loadSettings();
  }

  /// Carga las configuraciones desde la base de datos
  void _loadSettings() async {
    offlineMode = await _settingDAO.loadSetting('offlineMode', offlineMode);
    showAttendeesCounter = await _settingDAO.loadSetting(
        'showAttendeesCounter', showAttendeesCounter);
    vibration = await _settingDAO.loadSetting('vibration', vibration);
    receiveNotification = await _settingDAO.loadSetting(
        'receiveNotification', receiveNotification);
    readModeNotification = await _settingDAO.loadSetting(
        'readModeNotification', readModeNotification);
    salida = await _settingDAO.loadSetting('salida', salida);
    additionalSetting1 =
        await _settingDAO.loadSetting('additionalSetting1', additionalSetting1);
    additionalSetting2 =
        await _settingDAO.loadSetting('additionalSetting2', additionalSetting2);
    additionalSetting3 =
        await _settingDAO.loadSetting('additionalSetting3', additionalSetting3);

    setState(() {}); // Actualiza la UI después de cargar los datos
  }

  /// Guarda una configuración en la base de datos
  void _saveSetting(String key, bool value) async {
    await _settingDAO.saveSetting(key, value);
  }

  void _logout(BuildContext context) {
    _saveSetting('offlineMode', offlineMode);
    _saveSetting('showAttendeesCounter', showAttendeesCounter);
    _saveSetting('vibration', vibration);
    _saveSetting('receiveNotification', receiveNotification);
    _saveSetting('readModeNotification', readModeNotification);
    _saveSetting('salida', salida);
    _saveSetting('additionalSetting1', additionalSetting1);
    _saveSetting('additionalSetting2', additionalSetting2);
    _saveSetting('additionalSetting3', additionalSetting3);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
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
                _saveSetting('offlineMode', value);
              });
            },
            backgroundColor: Colors.white,
          ),
          _buildSwitchListTile(
            title: "Mostrar contador de asistentes",
            value: showAttendeesCounter,
            onChanged: (bool value) {
              setState(() {
                showAttendeesCounter = value;
                _saveSetting('showAttendeesCounter', value);
              });
            },
            backgroundColor: Colors.white,
          ),
          _buildSwitchListTile(
            title: "Vibración",
            value: vibration,
            onChanged: (bool value) {
              setState(() {
                vibration = value;
                _saveSetting('vibration', value);
              });
            },
            backgroundColor: Colors.white,
          ),
          _buildSwitchListTile(
            title: "Sonido al Escaneo",
            value: receiveNotification,
            onChanged: (bool value) {
              setState(() {
                receiveNotification = value;
                _saveSetting('receiveNotification', value);
              });
            },
            backgroundColor: Colors.white,
          ),
          _buildSwitchListTile(
            title: "Utilizar escáner láser en lugar de cámara",
            value: additionalSetting1,
            onChanged: (bool value) {
              setState(() {
                additionalSetting1 = value;
                _saveSetting('additionalSetting1', value);
              });
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
                _saveSetting('additionalSetting2', value);
              });
            },
            backgroundColor: Colors.white,
          ),
          _buildSwitchListTile(
            title: "Priorizar cámara para escanear",
            value: additionalSetting3,
            onChanged: (bool value) {
              setState(() {
                additionalSetting3 = value;
                _saveSetting('additionalSetting3', value);
              });
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
                _saveSetting('readModeNotification', value);
              });
            },
            backgroundColor: Colors.white,
          ),
          _buildSwitchListTile(
            title: "Salidas",
            value: salida,
            onChanged: (bool value) {
              setState(() {
                salida = value;
                _saveSetting('salida', value);
              });
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
