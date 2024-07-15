import 'package:flutter/material.dart';
import 'package:woutickpass/models/events_objeto..dart';


class EventDetailsPage extends StatelessWidget {
  final Event event;

  const EventDetailsPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Detalles del Evento'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Fecha: ${event.startAt}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Código de Acceso: ${event.wpassCode ?? 'N/A'}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            // Agrega más detalles según sea necesario
          ],
        ),
      ),
    );
  }
}
