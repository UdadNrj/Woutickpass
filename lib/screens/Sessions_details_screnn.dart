import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/models/objects/attendee.dart';
import 'package:woutickpass/services/dao/ticket_dao.dart';
import 'package:woutickpass/services/dao/sessions_dao.dart';
import 'package:woutickpass/screens/Statistics_screnn.dart';
import 'package:woutickpass/screens/Attendee_list_screen.dart';
import 'package:woutickpass/screens/Tickets_Configuration_screen.dart';
import 'package:woutickpass/models/logic/scanner_page.dart';

class EventDetailsPage extends StatefulWidget {
  final String sessionId;

  const EventDetailsPage({
    Key? key,
    required this.sessionId,
  }) : super(key: key);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late Future<Session?> _eventFuture;
  late Future<List<Attendee>> _attendeesFuture;

  @override
  void initState() {
    super.initState();
    _eventFuture = _loadEvent();
    _attendeesFuture = _loadAttendees();
  }

  Future<Session?> _loadEvent() async {
    final dao = SessionsDAO();
    return await dao.getSessionById(widget.sessionId);
  }

  Future<List<Attendee>> _loadAttendees() async {
    final dao = TicketDAO.instance;
    final session = await _eventFuture;
    if (session != null) {
      final tickets = await dao.getTicketsByEvent(session.title);
      return tickets
          .map((ticket) => Attendee(
                name: ticket.name,
                ticketType: ticket.type,
                ticketCode: ticket.ticketCode,
                status: ticket.status,
              ))
          .toList();
    } else {
      return [];
    }
  }

  Future<void> _finalizeSession() async {
    final dao = TicketDAO.instance;
    final session = await _eventFuture;
    if (session != null) {
      await dao.deleteTicketsByEvent(session.title);
    }
  }

  void _showFinalizeConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Finalizar sesión'),
          content: const Text(
              '¿Estás seguro de que deseas finalizar la sesión? Esto enviará los datos al servidor y eliminará todas las entradas del dispositivo.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Aceptar'),
              onPressed: () async {
                Navigator.of(context).pop();
                await _finalizeSession();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('La sesión ha sido finalizada.')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: FutureBuilder<Session?>(
          future: _eventFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData && snapshot.data != null) {
              return Text(snapshot.data!.title);
            } else {
              return const Text('Evento no encontrado');
            }
          },
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          FutureBuilder<Session?>(
            future: _eventFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child:
                        Text('Error al cargar el evento: ${snapshot.error}'));
              } else if (snapshot.hasData && snapshot.data != null) {
                final session = snapshot.data!;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 24.0),
                            title: Text('Lista de asistentes'),
                            subtitle: Text(
                                'Revisa la lista de asistentes totales a tu evento y edita los estados de las entradas de forma manual.'),
                            trailing: Icon(Icons.people,
                                size: 32, color: Colors.black),
                            onTap: () async {
                              try {
                                final tickets = await TicketDAO.instance
                                    .getTicketsByEvent(session.title);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AttendeesListScreen(
                                      event: session,
                                      tickets: tickets,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Error al cargar los tickets: $e')));
                              }
                            },
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 24.0),
                            title: Text('Configuración de entradas'),
                            subtitle: Text(
                                'Edita qué entradas quieres que se sincronicen con el escáner para esta sesión.'),
                            trailing: Icon(Icons.settings,
                                size: 32, color: Colors.black),
                            onTap: () async {
                              try {
                                final ticketTypes =
                                    await TicketDAO.instance.getTicketTypes();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TicketConfigurationScreen(
                                      event: session,
                                      ticketTypes: ticketTypes,
                                    ),
                                  ),
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        'Error al cargar los tipos de entradas: $e')));
                              }
                            },
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 24.0),
                            title: Text('Estadísticas de aforo'),
                            subtitle: Text(
                                'Accede a la información detallada y actualizada de los asistentes a esta sesión.'),
                            trailing: Icon(Icons.show_chart,
                                size: 32, color: Colors.black),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      StatisticsScreen(event: session.title),
                                ),
                              );
                            },
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 24.0),
                            title: Text('Finalizar sesión'),
                            subtitle: Text(
                                'Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo.'),
                            trailing: Icon(Icons.exit_to_app,
                                size: 32, color: Colors.black),
                            onTap: _showFinalizeConfirmationDialog,
                          ),
                        ),
                        Divider(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: ListTile(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 24.0),
                            title: Text('Vaciar Aforo'),
                            subtitle: Text(
                                'Reiniciar la lista de entradas validadas para esta sesión'),
                            trailing: Icon(Icons.restore,
                                size: 32, color: Colors.black),
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Center(child: Text('Evento no encontrado'));
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
                  backgroundColor: const Color(0xFFCC3364),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScannerPage(),
                    ),
                  );
                },
                child: const Text('ESCANEAR ENTRADAS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
