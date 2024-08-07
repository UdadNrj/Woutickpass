import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/screens/Tabs/main_nav.dart';
import 'package:woutickpass/screens/Tabs/page_events.dart';
import 'package:woutickpass/services/api/tickets_api.dart';
import 'package:woutickpass/services/dao/sessions_dao.dart';
import 'package:woutickpass/services/api/auth_session_api.dart';

class SessionsScreen extends StatefulWidget {
  final String token;

  SessionsScreen({required this.token});

  @override
  _SessionsScreenState createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  late Future<List<Session>> futureSessions;
  Map<String, bool> checkedSessions = {};

  @override
  void initState() {
    super.initState();
    futureSessions = _loadSession();
  }

  Future<List<Session>> _loadSession() async {
    try {
      final apiSessions = await AuthSessionAPI.getSession(widget.token);
      print('Sesiones obtenidas de la API: $apiSessions');
      await SessionsDAO().storeSessions(apiSessions);

      final selectedSessions = await SessionsDAO().getSelectedSessions();
      checkedSessions = {
        for (var session in apiSessions)
          session.uuid: selectedSessions.contains(session.uuid),
      };

      return apiSessions;
    } catch (e) {
      print('Error al cargar sesiones desde la API: $e');
      final storedSessions = await SessionsDAO().retrieveSessions();
      final selectedSessions = await SessionsDAO().getSelectedSessions();
      checkedSessions = {
        for (var session in storedSessions)
          session.uuid: selectedSessions.contains(session.uuid),
      };

      return storedSessions;
    }
  }

  bool get isButtonActive {
    return checkedSessions.values.where((isChecked) => isChecked).length >= 1;
  }

  void handleCheckboxChange(String uuid, bool? value) {
    setState(() {
      checkedSessions[uuid] = value ?? false;
    });

    print('Sesión UUID: $uuid, Seleccionada: ${checkedSessions[uuid]}');

    final selectedSessions = getSelectedSessions();
    SessionsDAO()
        .updateSelectedSessions(selectedSessions.map((e) => e.uuid).toList());
  }

  List<Session> getSelectedSessions() {
    return checkedSessions.entries
        .where((entry) => entry.value)
        .map((entry) => Session(
              uuid: entry.key,
              title: '',
              subtitle: "",
              wpassCode: "",
              eventStartAt: "",
              startAt: DateTime.now(),
            ))
        .toList();
  }

  Future<void> _downloadSelectedSessions() async {
    final selectedSessions = getSelectedSessions();

    if (selectedSessions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('No hay sesiones seleccionadas para descargar.')),
      );
      return;
    }

    // Progreso en la descarga
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Descargando tickets...')),
    );

    for (var session in selectedSessions) {
      try {
        // Descargar tickets para cada sesión
        await TicketsAPI.getTicketsBySessionId(session.uuid);
        print('Tickets descargados para la sesión ${session.uuid}');
      } catch (e) {
        print('Error al descargar tickets para la sesión ${session.uuid}: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Error al descargar tickets para la sesión ${session.uuid}')),
        );
      }
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(
          token: 'tu_token_aqui',
          currentIndex: 1,
          selectedEvents: [],
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tickets descargados exitosamente.')),
    );
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
      body: FutureBuilder<List<Session>>(
        future: futureSessions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No se encontraron sesiones'));
          }

          final sessions = snapshot.data!;
          for (var session in sessions) {
            if (!checkedSessions.containsKey(session.uuid)) {
              checkedSessions[session.uuid] = false;
            }
          }

          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFFE4E7EC)),
                  ),
                  child: CheckboxListTile(
                    title: Text(session.title ?? 'Sin nombre'),
                    subtitle: Text(session.startAt?.toString() ?? 'Sin fecha'),
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
      floatingActionButton: Positioned(
        bottom: 16.0,
        left: 16.0,
        right: 16.0,
        child: ElevatedButton(
          onPressed: isButtonActive ? _downloadSelectedSessions : null,
          child: Text(
            'DESCARGAR ENTRADAS',
            style: TextStyle(color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 110, vertical: 16),
            backgroundColor: Color(0xFF141C24),
            disabledBackgroundColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
