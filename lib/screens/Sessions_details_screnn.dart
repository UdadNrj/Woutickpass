import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:woutickpass/models/objects/session.dart';
=======
import 'package:woutickpass/models/Sessions_objeto..dart';
import 'package:woutickpass/models/attendee.objeto.dart';
import 'package:woutickpass/screens/Attendee_screen.dart';
>>>>>>> parent of dc54c47 (Cambios grandes !)

class EventDetailsPage extends StatelessWidget {
  final Session event;

  const EventDetailsPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Attendee> attendees = [
      Attendee(
        name: "Nombre Apellido Apellido",
        ticketType: "Tipo Entrada",
        ticketCode: "DNG72YB1",
        status: "DENTRO",
      ),
      Attendee(
        name: "Nombre Apellido Apellido",
        ticketType: "Tipo Entrada",
        ticketCode: "DNG72YB2",
        status: "SIN REGISTRO",
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(event.name),
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
            SizedBox(height: 32),
            ListTile(
              title: Text('Lista de asistentes'),
              subtitle: Text(
                  'Revisa la lista de asistentes totales a tu evento y edita los estados de las entradas de forma manual.'),
              leading: Icon(Icons.people),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendeesListScreen(
                      event: event,
                      attendees: attendees,
                    ),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text('Configuración de entradas'),
              subtitle: Text(
                  'Edita qué entradas quieres que se sincronicen con el escáner para esta sesión.'),
              leading: Icon(Icons.settings),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text('Estadísticas de aforo'),
              subtitle: Text(
                  'Accede a la información detallada y actualizada de los asistentes a esta sesión.'),
              leading: Icon(Icons.show_chart),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text('Finalizar sesión'),
              subtitle: Text(
                  'Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo.'),
              leading: Icon(Icons.exit_to_app),
              onTap: () {},
            ),
            Divider(),
            ListTile(
              title: Text('Vaciar Aforo'),
              subtitle: Text(
                  'Reiniciar la lista de entrads validadas para esta sesion'),
              leading: Icon(Icons.restore),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
