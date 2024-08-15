import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/ticket.dart';
import 'package:woutickpass/screens/Search_AttendeesScreen.dart';
import 'package:woutickpass/services/dao/ticket_dao.dart';

class AttendeeListScreen extends StatefulWidget {
  final String sessionId;

  const AttendeeListScreen({
    Key? key,
    required this.sessionId,
  }) : super(key: key);

  @override
  _AttendeeListScreenState createState() => _AttendeeListScreenState();
}

class _AttendeeListScreenState extends State<AttendeeListScreen> {
  late Future<List<Ticket>> _ticketsFuture;
  List<Ticket> _filteredTickets = [];

  @override
  void initState() {
    super.initState();
    _ticketsFuture = TicketDAO.instance.getTicketsBySessionId(widget.sessionId);
  }

  void _filterTickets(String query) {
    _ticketsFuture.then((tickets) {
      setState(() {
        _filteredTickets = tickets.where((ticket) {
          final ticketName = ticket.name.toLowerCase();
          final ticketCode = ticket.ticketCode.toLowerCase();
          final ticketType = ticket.event.toLowerCase();
          final searchQuery = query.toLowerCase();

          return ticketName.contains(searchQuery) ||
              ticketCode.contains(searchQuery) ||
              ticketType.contains(searchQuery);
        }).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Asistentes'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: TicketSearchDelegate(
                  ticketsFuture: _ticketsFuture,
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Ticket>>(
        future: _ticketsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay entradas disponibles.'));
          } else {
            final tickets =
                _filteredTickets.isNotEmpty ? _filteredTickets : snapshot.data!;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Entradas para el Evento ID: ${widget.sessionId}',
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];
                      return Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.0),
                          title: Text(ticket.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Estado: ${ticket.status}'),
                              Text('Correo: ${ticket.email}'),
                              Text('Código: ${ticket.ticketCode}'),
                              Text('Evento: ${ticket.event}'),
                              Text('Sesión: ${ticket.session}'),
                            ],
                          ),
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
