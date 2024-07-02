import 'package:flutter/material.dart';
import 'package:woutickpass/services/database.dart';

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

  final DatabaseHelper _dbHelper = DatabaseHelper();

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
    setState(() {});
  }

  Future<void> _saveSetting(String key, bool value) async {
    await _dbHelper.saveSetting(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            const Text(
              "CONTROL DE ACCESOS",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              color: Colors.white,
              child: SwitchListTile(
                activeColor: const Color(0xFFCC3366),
                value: offlineMode,
                title: const Text("Activar modo offline"),
                onChanged: (bool value) {
                  setState(() {
                    offlineMode = value;
                  });
                  _saveSetting('offlineMode', value);
                },
              ),
            ),
            SwitchListTile(
              activeColor: const Color(0xFFCC3366),
              value: showAttendeesCounter,
              title: const Text("Mostrar contador de asistentes"),
              onChanged: (bool value) {
                setState(() {
                  showAttendeesCounter = value;
                });
                _saveSetting('showAttendeesCounter', value);
              },
            ),
            SwitchListTile(
              activeColor: const Color(0xFFCC3366),
              value: vibration,
              title: const Text("Vibración"),
              onChanged: (bool value) {
                setState(() {
                  vibration = value;
                });
                _saveSetting('vibration', value);
              },
            ),
            SwitchListTile(
              activeColor: const Color(0xFFCC3366),
              value: receiveNotification,
              title: const Text("Recibir notificaciones"),
              onChanged: (bool value) {
                setState(() {
                  receiveNotification = value;
                });
                _saveSetting('receiveNotification', value);
              },
            ),
            const Text(
              "MODO DE LECTURA",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            SwitchListTile(
              activeColor: const Color(0xFFCC3366),
              value: readModeNotification,
              title: const Text("Recibir notificaciones"),
              onChanged: (bool value) {
                setState(() {
                  readModeNotification = value;
                });
                _saveSetting('readModeNotification', value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
