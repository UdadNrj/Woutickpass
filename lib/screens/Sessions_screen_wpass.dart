import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/services/api/session_api.dart';

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
    futureSessions = SessionAPI.getSessionsListByWpass(widget.wpassCode);

    try {
      final apiSessions = await futureSessions;
      print('Sesiones obtenidas de la API: $apiSessions');
      sessions = apiSessions;

      // Inicializa checkedSessions solo con los datos de la API
      checkedSessions = {
        for (var session in sessions) session.uuid: false,
      };
      setState(() {});
    } catch (e) {
      // En caso de error, maneja la excepción de manera adecuada
      print('Error al cargar sesiones desde la API: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar sesiones.')),
      );
    }
  }

  bool get isButtonActive {
    return checkedSessions.values.where((isChecked) => isChecked).length >= 1;
  }

  void handleCheckboxChange(String uuid, bool? value) {
    setState(() {
      checkedSessions[uuid] = value ?? false;
    });
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
                      // Aquí puedes manejar las sesiones seleccionadas,
                      // como navegar a otra página o realizar una acción
                      // Ejemplo:
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MainPage(
                      //       wpassCode: widget.wpassCode,
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
