import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Attendee_list_screen.dart';
import 'package:woutickpass/screens/Tickets_Configuration_screen.dart';

class SessionDetailsPage extends StatelessWidget {
  final String sessionId;
  final String sessionName;

  const SessionDetailsPage({
    Key? key,
    required this.sessionId,
    required this.sessionName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(sessionName),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Detalles del Evento ID: $sessionId',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(
                      bottom: 80.0), // Espacio inferior para el botón
                  children: [
                    // Primer grupo de ListTiles
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 8.0,
                      ),
                      child: ListTile(
                        title: Text('Lista de asistentes'),
                        subtitle: Text(
                            'Revisa la lista de asistentes totales a tu evento y edita los estados de las entradas de forma manual.'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttendeeListScreen(
                                sessionId: sessionId,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 8.0,
                      ),
                      child: ListTile(
                        title: Text('Configuración de entradas'),
                        subtitle: Text(
                            'Edita qué entradas quieres que se sincronicen con el escáner para esta sesión.'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EntryConfigurationPage(
                                sessionId: sessionId,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 8.0,
                      ),
                      child: ListTile(
                        title: Text('Estadísticas de aforo'),
                        subtitle: Text(
                            'Accede a la información detallada y actualizada de los asistentes a esta sesión.'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttendeeListScreen(
                                sessionId: sessionId,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Segundo grupo de ListTiles
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 8.0,
                      ),
                      child: ListTile(
                        title: Text('Finalizar sesión'),
                        subtitle: Text(
                            'Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo.'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttendeeListScreen(
                                sessionId: sessionId,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 8.0,
                      ),
                      child: ListTile(
                        title: Text('Vaciar aforo'),
                        subtitle: Text(
                            'Reiniciar la lista de entradas validadas para esta sesión'),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AttendeeListScreen(
                                sessionId: sessionId,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: () {
                // Acción del botón
                print('Botón presionado');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Color(0xFFCC3364),
              ),
              child: Text(
                'ESCANEAR ENTRADAS',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
