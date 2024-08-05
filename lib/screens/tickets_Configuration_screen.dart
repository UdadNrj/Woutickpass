import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';

class TicketConfigurationScreen extends StatefulWidget {
  final Session event;
  final List<String> ticketTypes;

  const TicketConfigurationScreen({
    Key? key,
    required this.event,
    required this.ticketTypes,
  }) : super(key: key);

  @override
  _TicketConfigurationScreenState createState() =>
      _TicketConfigurationScreenState();
}

class _TicketConfigurationScreenState extends State<TicketConfigurationScreen> {
  late List<String> _selectedTicketTypes;

  @override
  void initState() {
    super.initState();
    _selectedTicketTypes = List.from(widget.ticketTypes);
  }

  void _toggleSelection(String type) {
    setState(() {
      if (_selectedTicketTypes.contains(type)) {
        _selectedTicketTypes.remove(type);
      } else {
        _selectedTicketTypes.add(type);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Configuración de entradas'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.event.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Selecciona los tipos de entradas que quieres sincronizar con el escáner:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: widget.ticketTypes.length,
                itemBuilder: (context, index) {
                  final type = widget.ticketTypes[index];
                  return CheckboxListTile(
                    title: Text(type),
                    value: _selectedTicketTypes.contains(type),
                    activeColor: Colors.green,
                    onChanged: (bool? value) {
                      if (value != null) {
                        _toggleSelection(type);
                      }
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  backgroundColor: const Color(0xFF202B37),
                ),
                onPressed: () {
                  _saveConfiguration();
                  Navigator.pop(context);
                },
                child: Text(
                  'GUARDAR CONFIGURACION',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveConfiguration() {}
}
