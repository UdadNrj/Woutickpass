import 'package:flutter/material.dart';

class EntryConfigurationPage extends StatefulWidget {
  final String sessionId;

  const EntryConfigurationPage({
    Key? key,
    required this.sessionId,
  }) : super(key: key);

  @override
  _EntryConfigurationPageState createState() => _EntryConfigurationPageState();
}

class _EntryConfigurationPageState extends State<EntryConfigurationPage> {
  // Simulando datos con estados seleccionados
  final List<Map<String, dynamic>> entries = [
    {'status': 'Active', 'type': 'Standard', 'selected': true},
    {'status': 'Inactive', 'type': 'VIP', 'selected': false},
    {'status': 'Active', 'type': 'Premium', 'selected': false},
  ];

  // Acción para guardar la configuración
  void _saveConfiguration() {
    // Aquí puedes implementar la lógica para guardar la configuración
    print('Configuración guardada: $entries');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Configuración guardada exitosamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Configuración de Entradas'),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: CheckboxListTile(
                      activeColor: Colors.green,
                      title: Text('Tipo: ${entry['type']}'),
                      subtitle: Text('Estado: ${entry['status']}'),
                      value: entry['selected'],
                      onChanged: (bool? value) {
                        setState(() {
                          entry['selected'] = value!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveConfiguration,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 70.0),
                backgroundColor: Color.fromRGBO(20, 28, 36, 1),
              ),
              child: Text(
                'GUARDAR CONFIGURACIÓN',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
