import 'package:flutter/material.dart';
import 'package:woutickpass/src/widgets/custom_Events.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event2 event;

  EventDetailsScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              event.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Start at: ${event.startAt.toString()}'),
            // Agrega aquí más detalles del evento según sea necesario
          ],
        ),
      ),
    );
  }
}
