import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/ticket_details.dart';
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
  late Future<List<TicketDetails>> _ticketsFuture;
  List<TicketDetails> _filteredTickets = [];
  List<TicketDetails> _allTickets = [];

  @override
  void initState() {
    super.initState();
    _loadTickets(); // Llamada a _loadTickets() cuando se inicializa el widget
  }

  // Método para cargar los tickets de la base de datos
  void _loadTickets() {
    setState(() {
      print("Cargando tickets para sessionId: ${widget.sessionId}");
      _ticketsFuture =
          TicketDAO.instance.getTicketsBySessionId(widget.sessionId);

      _ticketsFuture.then((tickets) {
        print("Tickets cargados: ${tickets.length}");
        setState(() {
          _allTickets = tickets;
          _filteredTickets = tickets;
        });
      }).catchError((error) {
        print("Error al cargar los tickets: $error");
      });
    });
  }

  void _filterTickets(String query) {
    if (_allTickets.isNotEmpty) {
      setState(() {
        _filteredTickets = _allTickets.where((ticket) {
          final ticketName = ticket.name.toLowerCase();
          final ticketCode = ticket.ticketCode.toLowerCase();
          final event = ticket.event.toLowerCase();
          final searchQuery = query.toLowerCase();

          return ticketName.contains(searchQuery) ||
              ticketCode.contains(searchQuery) ||
              event.contains(searchQuery);
        }).toList();
        print("Tickets filtrados: ${_filteredTickets.length}");
      });
    }
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
            icon: Icon(Icons.refresh), // Botón de refresco
            onPressed: _loadTickets, // Recarga los tickets
          ),
          IconButton(
            icon: Icon(Icons.search), // Icono de búsqueda
            onPressed: () {
              // Implementar búsqueda aquí
            },
          ),
        ],
      ),
      body: FutureBuilder<List<TicketDetails>>(
        future: _ticketsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error al cargar tickets.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay entradas disponibles.'));
          } else {
            final tickets = snapshot.data!;

            return ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(
                      ticket.name.isNotEmpty ? ticket.name : 'Sin nombre',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Estado: ${ticket.status}'),
                        Text(
                            'Correo: ${ticket.email.isNotEmpty ? ticket.email : 'No disponible'}'),
                        Text('Código: ${ticket.ticketCode}'),
                        Text('Evento: ${ticket.event}'),
                        Text('Sesión: ${ticket.sessionUuid}'),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
