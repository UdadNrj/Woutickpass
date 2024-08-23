import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Aforo_statistics_screen.dart';
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
                    // Primer grupo de ListTiles con estilo aplicado
                    _buildListTile(
                      context,
                      'Lista de asistentes',
                      'Revisa la lista de asistentes totales a tu evento y edita los estados de las entradas de forma manual.',
                      Icons.people,
                      () {
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
                    _buildListTile(
                      context,
                      'Configuración de entradas',
                      'Edita qué entradas quieres que se sincronicen con el escáner para esta sesión.',
                      Icons.settings,
                      () {
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
                    _buildListTile(
                      context,
                      'Estadísticas de aforo',
                      'Accede a la información detallada y actualizada de los asistentes a esta sesión.',
                      Icons.bar_chart,
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AforoStatisticsScreen(sessionId: sessionId),
                          ),
                        );
                      },
                    ),
                    _buildListTile(
                      context,
                      'Finalizar sesión',
                      'Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo.',
                      Icons.check_circle,
                      () {
                        _showConfirmationDialog(context, sessionId);
                      },
                    ),
                    _buildListTile(
                      context,
                      'Vaciar aforo',
                      'Reiniciar la lista de entradas validadas para esta sesión',
                      Icons.delete,
                      () {
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.qr_code_scanner, color: Colors.white),
                  SizedBox(width: 8.0), // Espacio entre el ícono y el texto
                  Text(
                    'ESCANEAR ENTRADAS',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Container(
        padding: EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE4E7EC),
              width: 2.0,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color:
                  Color(0x1C1C1C).withOpacity(0.08), // rgba(28, 39, 49, 0.08)
              offset: Offset(0, 2),
              blurRadius: 6,
            ),
          ],
        ),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: Color(0xFF141C24), // Neutrals-Grey900
              fontFamily: 'Poppins',
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              height: 1.4,
              fontFeatures: [FontFeature.stylisticSet(2)],
            ),
          ),
          subtitle: Text(subtitle),
          trailing: Icon(icon),
          onTap: onTap,
        ),
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String sessionId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('¿Estás seguro de esta acción?'),
          content: Text(
            'Toda la información sobre las entradas de esta sesión se subirá al servidor y se eliminará del dispositivo.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Sesión finalizada con éxito.'),
                  ),
                );
              },
              child: Text(
                'Confirmar',
              ),
            ),
          ],
        );
      },
    );
  }
}
