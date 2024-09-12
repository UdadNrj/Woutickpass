import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/models/objects/session_details.dart';
import 'package:woutickpass/screens/Tabs/main_nav.dart';
import 'package:woutickpass/services/api/tickets_api.dart';
import 'package:woutickpass/services/dao/sessions_dao.dart';
import 'package:woutickpass/services/api/auth_session_api.dart';
import 'package:woutickpass/services/api/session_api.dart';

class SessionsScreen extends StatefulWidget {
  final String token;

  SessionsScreen({required this.token});

  @override
  _SessionsScreenState createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  late Future<List<Session>> futureSessions; // Lista de sesiones futura
  Map<String, bool> checkedSessions = {}; // Estado de los checkboxes

  @override
  void initState() {
    super.initState();
    futureSessions = _loadSessions(); // Cargar las sesiones al iniciar
  }

  // Método para cargar las sesiones básicas desde la API o la base de datos local
  Future<List<Session>> _loadSessions() async {
    try {
      // Obtiene las sesiones básicas desde la API usando el token
      final List<Session> apiSessions =
          await AuthSessionAPI.getSession(widget.token);

      // Muestra las sesiones inmediatamente en la UI
      setState(() {
        checkedSessions = {
          for (var session in apiSessions) session.uuid: false,
        };
      });

      return apiSessions; // Retorna las sesiones para mostrarlas en la UI
    } catch (e) {
      print('Error loading sessions: $e');

      // Si ocurre un error, recuperar las sesiones almacenadas localmente
      final storedSessions = await SessionsDAO().retrieveSessions();
      final selectedSessions = await SessionsDAO().getSelectedSessions();

      // Actualiza la UI mostrando las sesiones almacenadas localmente
      setState(() {
        checkedSessions = {
          for (var session in storedSessions)
            session.uuid: selectedSessions.contains(session.uuid),
        };
      });

      return storedSessions; // Retornar las sesiones almacenadas localmente
    }
  }

  // Verifica si al menos una sesión está seleccionada
  bool get isButtonActive =>
      checkedSessions.values.any((isChecked) => isChecked);

  // Maneja los cambios en los checkboxes
  void handleCheckboxChange(String uuid, bool? value) {
    setState(() {
      checkedSessions[uuid] = value ?? false;
    });
    _updateSelectedSessions(); // Actualiza las sesiones seleccionadas en la base de datos
  }

  // Actualiza las sesiones seleccionadas en la base de datos local
  Future<void> _updateSelectedSessions() async {
    final selectedSessions = checkedSessions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    await SessionsDAO().updateSelectedSessions(
        selectedSessions); // Guarda las sesiones seleccionadas
  }

  // Descargar tickets y detalles para las sesiones seleccionadas
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

    // Mostrar mensaje de que la descarga está en proceso
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloading session details and tickets...')),
    );

    bool allDownloadsSuccessful = true;
    List<SessionDetails> selectedSessionDetails =
        []; // Lista para almacenar los detalles

    for (var uuid in selectedSessions) {
      try {
        // 1. Descargar los detalles de la sesión
        final sessionDetails = await SessionAPI.getSessionByUuid(uuid);
        await SessionsDAO()
            .storeSessions([sessionDetails]); // Guardar los detalles localmente

        // 2. Descargar los tickets asociados a esa sesión
        final tickets = await TicketsAPI.getTicketsBySessionUuid(uuid);
        if (tickets.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No tickets available for session $uuid.')),
          );
        } else {
          print('Tickets downloaded for session $uuid');
        }

        // 3. Añadir los detalles de la sesión descargada a la lista
        selectedSessionDetails.add(sessionDetails);
      } catch (e) {
        print('Error downloading session $uuid: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error downloading session $uuid')),
        );
        allDownloadsSuccessful =
            false; // Marcar como no exitoso si hay un error
      }
    }

    // Redirigir a la página principal con las sesiones seleccionadas
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(
          token: widget.token,
          currentIndex: 1,
          selectedEvents:
              selectedSessionDetails, // Pasar las sesiones seleccionadas
        ),
      ),
    );

    // Mostrar si todas las descargas fueron exitosas o no
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          allDownloadsSuccessful
              ? 'Tickets and session details downloaded successfully.'
              : 'Some downloads failed.',
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
        future: futureSessions, // Lista futura de sesiones
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No sessions found'));
          }

          final sessions = snapshot.data!;
          for (var session in sessions) {
            if (!checkedSessions.containsKey(session.uuid)) {
              checkedSessions[session.uuid] =
                  false; // Inicializa el checkbox si no existe
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
                    title: Text(session.title.isNotEmpty
                        ? session.title
                        : 'Unnamed Session'),
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
