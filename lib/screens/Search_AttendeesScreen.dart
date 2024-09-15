import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/ticket_details.dart';
import 'package:flutter/scheduler.dart'; // Para programar acciones después del ciclo de construcción

class TicketSearchDelegate extends SearchDelegate {
  final Future<List<TicketDetails>> ticketsFuture;
  final Function(String) filterTickets;

  TicketSearchDelegate(
      {required this.ticketsFuture, required this.filterTickets});

  // Sobrescribir el tema del buscador para poner el fondo blanco y un borde alrededor del campo de búsqueda
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      // Color de fondo blanco para la AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black), // Iconos en negro
      ),
      // Color de texto de búsqueda
      textTheme: TextTheme(
        headlineSmall: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ), // Color del texto de la búsqueda
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: Colors.grey[600],
        ), // Estilo del texto del placeholder
        border: OutlineInputBorder(
          // Aplicar borde al campo de búsqueda
          borderSide: BorderSide(
            color: Colors.black, // Color del borde
            width: 2, // Grosor del borde
          ),
          borderRadius:
              BorderRadius.all(Radius.circular(8.0)), // Bordes redondeados
        ),
      ),
      scaffoldBackgroundColor: Colors.white, // Fondo blanco
    );
  }

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

  // Mostramos la página inicial y los resultados según la búsqueda
  @override
  Widget buildResults(BuildContext context) {
    // Aseguramos que la función de filtrado se llame después del ciclo de construcción
    SchedulerBinding.instance.addPostFrameCallback((_) {
      filterTickets(query);
    });

    return FutureBuilder<List<TicketDetails>>(
      future: ticketsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Diseño cuando no hay resultados
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 80,
                    color: Colors.grey[700],
                  ),
                  SizedBox(height: 24),
                  Text(
                    'No hemos encontrado resultados',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Lo siento, no se encontraron resultados para tu búsqueda. '
                    'Por favor, intenta con diferentes criterios o verifica la ortografía. ¡Gracias por tu paciencia!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        } else {
          final tickets = snapshot.data!;
          return ListView.builder(
            itemCount: tickets.length,
            itemBuilder: (context, index) {
              final ticket = tickets[index];
              return Card(
                color: Colors.white,
                elevation: 2,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text(
                    ticket.name.isNotEmpty ? ticket.name : 'Sin nombre',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Estado: ${ticket.status}',
                          style: TextStyle(color: Colors.grey[600])),
                      Text(
                          'Correo: ${ticket.email.isNotEmpty ? ticket.email : 'No disponible'}',
                          style: TextStyle(color: Colors.grey[600])),
                      Text('Código: ${ticket.ticketCode}',
                          style: TextStyle(color: Colors.grey[600])),
                      Text('Evento: ${ticket.event}',
                          style: TextStyle(color: Colors.grey[600])),
                      Text('Sesión: ${ticket.sessionUuid}',
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        }
      },
    );
  }

  // Mostramos una vista inicial cuando el usuario aún no ha buscado nada
  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 80,
              color: Colors.grey[700],
            ),
            SizedBox(height: 24),
            Text(
              'Busca entradas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Ingresa el nombre, código o correo electrónico para encontrar las entradas.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
