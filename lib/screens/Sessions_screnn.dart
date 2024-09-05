import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/comercials.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/models/objects/tickets.dart';
import 'package:woutickpass/screens/Tabs/main_nav.dart';
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
    futureSessions = _loadSessions();
  }

  Future<List<Session>> _loadSessions() async {
    try {
      // Obtiene las sesiones desde la API
      final apiSessions = await AuthSessionAPI.getSession(widget.token);

      // Almacena las sesiones obtenidas en la base de datos
      await SessionsDAO().storeSessions(apiSessions);

      // Obtiene las sesiones seleccionadas desde la base de datos
      final selectedSessions = await SessionsDAO().getSelectedSessions();

      // Actualiza el estado de las sesiones seleccionadas
      setState(() {
        checkedSessions = {
          for (var session in apiSessions)
            session.uuid: selectedSessions.contains(session.uuid),
        };
      });

      return apiSessions;
    } catch (e) {
      // Maneja los errores y recupera las sesiones desde la base de datos
      print('Error loading sessions: $e');

      final storedSessions = await SessionsDAO().retrieveSessions();
      final selectedSessions = await SessionsDAO().getSelectedSessions();

      setState(() {
        checkedSessions = {
          for (var session in storedSessions)
            session.uuid: selectedSessions.contains(session.uuid),
        };
      });

      return storedSessions;
    }
  }

  bool get isButtonActive =>
      checkedSessions.values.any((isChecked) => isChecked);

  void handleCheckboxChange(String uuid, bool? value) {
    setState(() {
      checkedSessions[uuid] = value ?? false;
    });
    _updateSelectedSessions();
  }

  Future<void> _updateSelectedSessions() async {
    final selectedSessions = checkedSessions.entries
        .where((entry) => entry.value)
        .map((entry) => Session(
              uuid: entry.key,
              title:
                  'Título predeterminado', // Ajusta el título según sea necesario
              subtitle:
                  'Subtítulo predeterminado', // Ajusta el subtítulo según sea necesario
              wpassCode:
                  'Código de pase', // Coloca un código de pase si es necesario
              commercials: [
                Commercial(uuid: 'comercial-uuid-1', name: 'Comercial 1'),
                Commercial(uuid: 'comercial-uuid-2', name: 'Comercial 2'),
              ], // Lista de objetos 'Commercial'
              tickets: [
                Tickets(uuid: 'ticket-uuid-1', name: 'Ticket 1'),
                Tickets(uuid: 'ticket-uuid-2', name: 'Ticket 2')
              ], // Lista de objetos 'Ticket'
              publicStartAt: DateTime.now(), // Asigna una fecha válida
              publicEndAt: DateTime.now().add(Duration(
                  hours: 2)), // Asigna una fecha válida para la finalización
            ))
        .toList();

    await SessionsDAO()
        .updateSelectedSessions(selectedSessions.map((e) => e.uuid).toList());
  }

  Future<void> _downloadSelectedSessions() async {
    final selectedSessions = checkedSessions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (selectedSessions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No sessions selected for download.')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading tickets...')),
    );

    final completeSessions = await SessionsDAO().retrieveSessions();
    final selectedSessionDetails = completeSessions
        .where((session) => selectedSessions.contains(session.uuid))
        .toList();

    bool allDownloadsSuccessful = true;

    for (var uuid in selectedSessions) {
      try {
        final tickets = await TicketsAPI.getTicketsBySessionUuid(uuid);
        if (tickets.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No tickets available for session $uuid.'),
            ),
          );
        } else {
          print('Tickets downloaded for session $uuid');
        }
      } catch (e) {
        print('Error downloading tickets for session $uuid: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error downloading tickets for session $uuid')),
        );
        allDownloadsSuccessful = false;
      }
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(
          token: widget.token,
          currentIndex: 1,
          selectedEvents: selectedSessionDetails,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          allDownloadsSuccessful
              ? 'Tickets downloaded successfully.'
              : 'Some tickets failed to download.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('Sessions'),
      ),
      body: FutureBuilder<List<Session>>(
        future: futureSessions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No sessions found'));
          }

          final sessions = snapshot.data!;
          // Asegúrate de inicializar el estado de los checkboxes para las sesiones nuevas
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
                    title: Text(
                        session.title.isNotEmpty ? session.title : 'Unnamed'),
                    subtitle:
                        Text(session.publicStartAt?.toString() ?? 'No date'),
                    value: checkedSessions[session.uuid] ?? false,
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: isButtonActive ? _downloadSelectedSessions : null,
          child: Text(
            'DOWNLOAD TICKETS',
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
