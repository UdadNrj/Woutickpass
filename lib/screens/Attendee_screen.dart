import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/models/objects/attendee.dart';

class AttendeesListScreen extends StatelessWidget {
  final Session event;
  final List<Attendee> attendees;

  const AttendeesListScreen({
    Key? key,
    required this.event,
    required this.attendees,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Asistentes'),
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
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${event.startAt} - ${event.startAt}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: attendees.isEmpty
                  ? Center(
                      child: Text(
                        'No hay asistentes para este evento.',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: attendees.length,
                      itemBuilder: (context, index) {
                        final attendee = attendees[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          child: ListTile(
                            leading: _getStatusIcon(attendee.status),
                            title: Text(attendee.name),
                            subtitle: Text(
                                '${attendee.ticketType} (${attendee.ticketCode})'),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {
                              // Acción al hacer tap en un asistente
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getStatusIcon(String status) {
    switch (status) {
      case 'DENTRO':
        return Icon(Icons.check_circle, color: Colors.green);
      case 'SIN REGISTRO':
        return Icon(Icons.help, color: Colors.grey);
      case 'FUERA':
        return Icon(Icons.exit_to_app, color: Colors.blue);
      case 'DEVUELTA':
        return Icon(Icons.undo, color: Colors.red);
      case 'ACCESO BLOQUEADO':
        return Icon(Icons.block, color: Colors.red);
      default:
        return Icon(Icons.help, color: Colors.grey);
    }
  }
}
