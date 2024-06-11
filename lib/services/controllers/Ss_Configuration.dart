import 'package:flutter/material.dart';
import 'package:woutickpass/models/Button_configuration.dart';
import 'package:woutickpass/models/Custom_Session.dart';
import 'package:woutickpass/models/custom_Ticket.dart';
import 'package:woutickpass/services/controllers/asistentes_page.dart';
import 'package:woutickpass/src/widgets/list_tile.dart';

class SessionConfigurationPage extends StatelessWidget {
  final SessionOn session;

  const SessionConfigurationPage({Key? key, required this.session})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(session.title),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  buildListTile(
                    leadingIcon: Icons.people,
                    title: 'Lista de asistentes',
                    subtitle:
                        'Revisa la lista de asistentes totales a tu evento y edita los estados de las entradas de forma manual.',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AsistentesPage()));
                    },
                  ),
                  const SizedBox(height: 16),
                  buildListTile(
                    leadingIcon: Icons.settings,
                    title: 'Configuración de entradas',
                    subtitle:
                        'Edita qué entradas quieres que se sincronicen con el escáner para esta sesión.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicketTypeConfigurationPage(),
                        ),
                      ).then((result) {
                        // Here you can handle the result returned by the input type configuration page if necessary
                        if (result != null && result is TicketType) {
                          // Do something with the saved input type, such as display it in the UI or save it to a list.
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  buildListTile(
                    leadingIcon: Icons.bar_chart,
                    title: 'Estadísticas de aforo',
                    subtitle:
                        'Accede a la información detallada y actualizada de los asistentes a esta sesión.',
                    onTap: () {
                      // Navigate to Estadísticas de aforo screen
                    },
                  ),
                  const SizedBox(height: 16),
                  buildListTile(
                    leadingIcon: Icons.upload,
                    title: 'Finalizar sesión',
                    subtitle:
                        'Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo.',
                    onTap: () {
                      // Navigate to Finalizar sesión screen
                    },
                  ),
                  const SizedBox(height: 16),
                  buildListTile(
                    leadingIcon: Icons.upload,
                    title: 'Vaciar Aforo ',
                    subtitle:
                        'Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo.',
                    onTap: () {
                      // Navigate to Finalizar sesión screen
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 16,
            child: ElevatedButton.icon(
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              label: const Text(
                'ESCANEAR ENTRADAS',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // Navigate to Escanear entradas screen
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                backgroundColor: Colors.pink, // Color of the button
              ),
            ),
          ),
        ],
      ),
    );
  }
}
