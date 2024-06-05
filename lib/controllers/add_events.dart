import 'package:flutter/material.dart';
import 'package:woutickpass/src/widgets/Custom_Session.dart';

class SessionConfigurationPage extends StatelessWidget {
  final SessionOn session;

  const SessionConfigurationPage({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController surnameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Configurar Sesión'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Configuración para: ${session.title}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: surnameController,
              decoration: InputDecoration(
                labelText: 'Apellido',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Acción para guardar los cambios
                String name = nameController.text;
                String surname = surnameController.text;
                // Lógica para guardar el nombre y apellido
                // Aquí puedes realizar las acciones necesarias para guardar los cambios
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cambios guardados: $name $surname')),
                );
              },
              child: Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
    );
  }
}
