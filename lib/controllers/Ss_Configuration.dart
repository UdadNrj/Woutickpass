import 'package:flutter/material.dart';
import 'package:woutickpass/src/widgets/Custom_Session.dart';

class SessionConfigurationPage extends StatelessWidget {
  final SessionOn session;

  const SessionConfigurationPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(session.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.people),
                title: Text('Lista de asistentes'),
                subtitle: Text(
                    'Revisa la lista de asistentes totales a tu evento y edita los estados de las entradas de forma manual.'),
                onTap: () {
                  // Navigate to Lista de asistentes screen
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Configuración de entradas'),
                subtitle: Text(
                    'Edita qué entradas quieres que se sincronicen con el escáner para esta sesión.'),
                onTap: () {
                  // Navigate to Configuración de entradas screen
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.bar_chart),
                title: Text('Estadísticas de aforo'),
                subtitle: Text(
                    'Accede a la información detallada y actualizada de los asistentes a esta sesión.'),
                onTap: () {
                  // Navigate to Estadísticas de aforo screen
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.upload),
                title: Text('Finalizar sesión'),
                subtitle: Text(
                    'Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo.'),
                onTap: () {
                  // Navigate to Finalizar sesión screen
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.upload),
                title: Text('Vaciar Aforo '),
                subtitle: Text(
                    'Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo.'),
                onTap: () {
                  // Navigate to Finalizar sesión screen
                },
              ),
              Divider(),
              SizedBox(height: 200),
              ElevatedButton.icon(
                icon: Icon(Icons.camera_alt),
                label: Text('ESCANEAR ENTRADAS'),
                onPressed: () {
                  // Navigate to Escanear entradas screen
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  backgroundColor: Colors.pink, // Color of the button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
