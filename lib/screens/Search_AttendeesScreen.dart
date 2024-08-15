import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/ticket.dart';

class TicketSearchDelegate extends SearchDelegate {
  final Future<List<Ticket>> ticketsFuture;

  TicketSearchDelegate({required this.ticketsFuture});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.black54),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black54),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<List<Ticket>>(
        future: ticketsFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('No hay resultados.',
                    style: TextStyle(color: Colors.black54)));
          }

          final tickets = snapshot.data!;
          final filteredTickets = tickets.where((ticket) {
            final ticketName = ticket.name.toLowerCase();
            final ticketCode = ticket.ticketCode.toLowerCase();
            final ticketType = ticket.event.toLowerCase();
            final searchQuery = query.toLowerCase();

            return ticketName.contains(searchQuery) ||
                ticketCode.contains(searchQuery) ||
                ticketType.contains(searchQuery);
          }).toList();

          if (filteredTickets.isEmpty) {
            return Center(
                child: Text('No se encontraron resultados para "$query".',
                    style: TextStyle(color: Colors.black54)));
          }

          return ListView.builder(
            itemCount: filteredTickets.length,
            itemBuilder: (context, index) {
              final ticket = filteredTickets[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Card(
                  color: Colors.white,
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text(ticket.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black)),
                    subtitle: Text(ticket.ticketCode,
                        style: TextStyle(color: Colors.black54)),
                    onTap: () {
                      close(context, ticket);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'Busca por nombre, código o tipo de entrada',
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }
}
