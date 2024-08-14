import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Home_screen.dart';

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

  @override
  void initState() {
    super.initState();
    // Inicializa los valores de configuración aquí si es necesario
    _loadSettings();
  }

  void _loadSettings() {
    // Aquí puedes cargar configuraciones predeterminadas o inicializar los valores
    // Por ahora, los valores están predeterminados en el estado
  }

  void _saveSetting(String key, bool value) {
    // Implementa aquí el guardado de configuraciones si es necesario
    // Actualmente, las configuraciones solo se mantienen en memoria
  }

  void _logout(BuildContext context) {
    // Guardar configuraciones en memoria solo si se ha implementado el almacenamiento persistente
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
