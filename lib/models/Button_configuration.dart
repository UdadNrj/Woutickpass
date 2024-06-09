import 'package:flutter/material.dart';
import 'package:woutickpass/src/widgets/custom_Ticket.dart';

class TicketTypeConfigurationPage extends StatefulWidget {
  @override
  _TicketTypeConfigurationPageState createState() =>
      _TicketTypeConfigurationPageState();
}

class _TicketTypeConfigurationPageState
    extends State<TicketTypeConfigurationPage> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración de Tipo de Entrada'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration:
                  InputDecoration(labelText: 'Nombre del Tipo de Entrada'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveTicketType();
              },
              child: Text('GUARDAR CONFIGURACION'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveTicketType() {
    final name = _nameController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;

    if (name.isNotEmpty && price > 0) {
      // Aquí puedes guardar el tipo de entrada o realizar cualquier otra lógica necesaria
      final ticketType = TicketType(name: name, price: price);
      // Puedes hacer algo con el ticketType, como pasarlo a otra pantalla o guardarlo en una lista, por ejemplo.
      Navigator.pop(context,
          ticketType); // Esto cierra la página y devuelve el ticketType
    } else {
      // Manejar caso de entrada inválida
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Por favor, ingresa un nombre y un precio válidos.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
