import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/services/Api/api_auth_wpass.dart';
import 'package:woutickpass/services/sessions_dao.dart';

class SessionsScreenWpass extends StatefulWidget {
  final String wpassCode;

  SessionsScreenWpass({required this.wpassCode});

  @override
  _SessionsScreenState createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreenWpass> {
  late Future<List<Session>> futureSessions;
  List<Session> sessions = [];
  Map<String, bool> checkedSessions = {};

  @override
  void initState() {
    super.initState();
    _loadSessions();
  }

  Future<void> _loadSessions() async {
    futureSessions = ApiAuthWpass.getEvents(widget.wpassCode);

    try {
      final apiSessions = await futureSessions;
      print('Sesiones obtenidas de la API: $apiSessions');
      sessions = apiSessions;

      await SessionsDao().storeSessions(sessions);

      final selectedSessions = await SessionsDao().getSelectedSessions();
      checkedSessions = {
        for (var session in sessions)
          session.uuid: selectedSessions.contains(session.uuid),
      };
      setState(() {});
    } catch (e) {
      sessions = await SessionsDao().retrieveSessions();
      checkedSessions = {
        for (var session in sessions) session.uuid: false,
      };
      print('Error al cargar sesiones desde la API: $e');
    }
  }

  bool get isButtonActive {
    return checkedSessions.values.where((isChecked) => isChecked).length >= 1;
  }

  void handleCheckboxChange(String uuid, bool? value) {
    setState(() {
      checkedSessions[uuid] = value ?? false;
    });

    final selectedSessions = getSelectedSessions();
    SessionsDao()
        .updateSelectedSessions(selectedSessions.map((s) => s.uuid).toList());
  }

  List<Session> getSelectedSessions() {
    return sessions
        .where((session) => checkedSessions[session.uuid] == true)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('Sesiones'),
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Session>>(
            future: futureSessions,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No se encontraron Sesiones'));
              }

              sessions = snapshot.data!;
              for (var session in sessions) {
                if (!checkedSessions.containsKey(session.uuid)) {
                  checkedSessions[session.uuid] = false;
                }
              }

              return ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (context, index) {
                  Session session = sessions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFFE4E7EC)),
                      ),
                      child: CheckboxListTile(
                        title: Text(session.title ?? 'Sin nombre'),
                        subtitle:
                            Text(session.startAt?.toString() ?? 'Sin fecha'),
                        value: checkedSessions[session.uuid],
                        onChanged: (bool? value) {
                          handleCheckboxChange(session.uuid, value);
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: isButtonActive
                  ? () {
                      List<Session> selectedSessions = getSelectedSessions();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MainPage(
                      //       token: widget.wpassCode,
                      //       currentIndex: 1,
                      //       selectedSessions: selectedSessions,
                      //     ),
                      //   ),
                      // );
                    }
                  : null,
              child: Text(
                'DESCARGAR ENTRADAS',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                backgroundColor: Color(0xFF141C24),
                disabledBackgroundColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
