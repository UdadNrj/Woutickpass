import 'package:flutter/material.dart';
import 'package:woutickpass/src/widgets/custom_Events.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventS event;

  EventDetailsScreen({required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
            SizedBox(height: 16),
            Text('Start Date: ${event.publicStartAt}'),
            // Agrega más detalles del evento aquí
          ],
        ),
      ),
    );
  }
}
