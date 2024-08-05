import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/attendee.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/screens/Attendee_list_screen.dart';
import 'package:woutickpass/screens/Statistics_screnn.dart';
import 'package:woutickpass/screens/Tickets_Configuration_screen.dart';
import 'package:woutickpass/services/tickets_dao.dart';

class EventDetailsPage extends StatefulWidget {
  final Session event;

  const EventDetailsPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late Future<List<Attendee>> _attendeesFuture;

  @override
  void initState() {
    super.initState();
    _attendeesFuture = _loadAttendees();
  }

  Future<List<Attendee>> _loadAttendees() async {
    final dao = TicketsDao.instance;
    final tickets = await dao.getTicketsByEvent(widget.event.title);
    return tickets
        .map((ticket) => Attendee(
              name: ticket.name,
              ticketType: ticket.type,
              ticketCode: ticket.ticketCode,
              status: ticket.status,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.event.title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                  title: Text('Lista de asistentes'),
                  subtitle: Text(
                      'Revisa la lista de asistentes totales a tu evento y edita los estados de las entradas de forma manual.'),
                  trailing: Icon(
                    Icons.people,
                    size: 32,
                    color: Colors.black,
                  ),
                  onTap: () async {
                    final attendees = await _attendeesFuture;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendeesListScreen(
                          event: widget.event,
                          attendees: attendees,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                  title: Text('Configuración de entradas'),
                  subtitle: Text(
                      'Edita qué entradas quieres que se sincronicen con el escáner para esta sesión.'),
                  trailing: Icon(
                    Icons.settings,
                    size: 32,
                    color: Colors.black,
                  ),
                  onTap: () async {
                    final ticketTypes =
                        await TicketsDao.instance.getTicketTypes();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TicketConfigurationScreen(
                          event: widget.event,
                          ticketTypes: ticketTypes,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                  title: Text('Estadísticas de aforo'),
                  subtitle: Text(
                      'Accede a la información detallada y actualizada de los asistentes a esta sesión.'),
                  trailing: Icon(
                    Icons.show_chart,
                    size: 32,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            StatisticsScreen(event: widget.event.title),
                      ),
                    );
                  },
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                  title: Text('Finalizar sesión'),
                  subtitle: Text(
                      'Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo.'),
                  trailing: Icon(
                    Icons.exit_to_app,
                    size: 32,
                    color: Colors.black,
                  ),
                  onTap: () {},
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 24.0),
                  title: Text('Vaciar Aforo'),
                  subtitle: Text(
                      'Reiniciar la lista de entradas validadas para esta sesión'),
                  trailing: Icon(
                    Icons.restore,
                    size: 32,
                    color: Colors.black,
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
