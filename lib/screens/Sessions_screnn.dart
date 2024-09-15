import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/models/objects/session_details.dart';
import 'package:woutickpass/models/objects/ticket_details.dart';
import 'package:woutickpass/screens/Tabs/main_nav.dart';
import 'package:woutickpass/services/api/tickets_api.dart';
import 'package:woutickpass/services/dao/comercial_dao.dart';
import 'package:woutickpass/services/dao/sessions_dao.dart';
import 'package:woutickpass/services/api/auth_session_api.dart';
import 'package:woutickpass/services/api/session_api.dart';
import 'package:woutickpass/services/dao/ticket_dao.dart';
import 'package:woutickpass/services/database.dart';

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
    final selectedSessionUUIDs = checkedSessions.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    if (selectedSessionUUIDs.isEmpty) {
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
    List<SessionDetails> selectedSessionDetails = [];
    List<Session> selectedSessions = [];

    try {
      // Obtén todas las sesiones desde la API usando el token del usuario
      List<Session> allSessions = await AuthSessionAPI.getSession(widget.token);

      // Filtra las sesiones seleccionadas usando los UUIDs seleccionados
      selectedSessions = allSessions
          .where((session) => selectedSessionUUIDs.contains(session.uuid))
          .toList();

      // Descargar detalles adicionales y tickets para cada sesión seleccionada
      for (var session in selectedSessions) {
        try {
          // Verifica si los detalles de la sesión ya están almacenados localmente
          if (!await _isSessionDetailsStored(session.uuid)) {
            final sessionDetails =
                await SessionAPI.getSessionByUuid(session.uuid);

            // Almacena los detalles de la sesión
            await _storeSessionDetails(sessionDetails);

            // Descargar y almacenar los tickets específicos de la sesión
            final tickets =
                await TicketsAPI.getTicketsBySessionUuid(session.uuid);
            if (tickets.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        'No tickets available for session ${session.uuid}.')),
              );
            } else {
              // Almacenar los tickets usando TicketDAO
              for (var ticket in tickets) {
                // Usar copyWith para asignar el sessionUuid correcto
                ticket = ticket.copyWith(sessionUuid: session.uuid);

                // Almacenar el ticket
                await TicketDAO.instance.insert(ticket);
              }

              print(
                  'Tickets downloaded and stored for session ${session.uuid}');
            }

            selectedSessionDetails.add(sessionDetails);
          } else {
            print(
                'Session details for session ${session.uuid} are already stored locally.');
          }
        } catch (e) {
          print('Error downloading session ${session.uuid}: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Error downloading session ${session.uuid}')),
          );
          allDownloadsSuccessful = false;
        }
      }
    } catch (e) {
      print('Error retrieving sessions: $e');
      allDownloadsSuccessful = false;
    }

    // Redirigir a la página principal con las sesiones seleccionadas
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage(
          token: widget.token,
          currentIndex: 1,
          selectedEvents: selectedSessions,
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

// Método que verifica si los detalles de la sesión ya están almacenados
  Future<bool> _isSessionDetailsStored(String sessionId) async {
    // Aquí llamas al DAO para verificar si los detalles de la sesión ya están almacenados
    final storedSessionDetails = await SessionsDAO().getSessionById(sessionId);
    return storedSessionDetails != null;
  }

  Future<void> _storeSessionDetails(SessionDetails sessionDetails) async {
    final db = await DatabaseHelper().database;
    try {
      await db.transaction((txn) async {
        // Almacena los detalles de la sesión dentro de la transacción
        await SessionsDAO().storeSessions([sessionDetails], txn);

        // Almacena los comerciales relacionados dentro de la misma transacción
        for (var commercial in sessionDetails.commercials) {
          await CommercialsDAO().storeCommercial(
              commercial, txn); // Asegúrate de pasar la transacción
        }
      });

      print(
          'Session details and commercials stored for session ${sessionDetails.uuid}');
    } catch (e) {
      print('Error storing session details: $e');
    }
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
