import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/ticket_details.dart';

class TicketSearchDelegate extends SearchDelegate {
  final Future<List<TicketDetails>> ticketsFuture;
  final Function(String) filterTickets;

  TicketSearchDelegate(
      {required this.ticketsFuture, required this.filterTickets});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Limpia la búsqueda
          filterTickets(''); // Resetea el filtro
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Cierra el buscador
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    filterTickets(query); // Filtra los resultados según el texto ingresado
    return FutureBuilder<List<TicketDetails>>(
      future: ticketsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No se encontraron resultados.'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final ticket = snapshot.data![index];
              return ListTile(
                title:
                    Text(ticket.name.isNotEmpty ? ticket.name : 'Sin nombre'),
                subtitle: Text(ticket.ticketCode),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    filterTickets(query); // Filtra los resultados de sugerencias
    return Container(); // Se puede agregar sugerencias si lo deseas
  }
}
