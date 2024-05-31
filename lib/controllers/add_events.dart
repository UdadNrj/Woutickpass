import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woutickpass/controllers/Events_sesion.dart';

class AddEvents extends StatefulWidget {
  final Function(Evento) onAddEvent;

  AddEvents({required this.onAddEvent});

  @override
  _AddEventsState createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  final _formKey = GlobalKey<FormState>();
  final _idController = TextEditingController();
  final _tituloController = TextEditingController();
  final _fechaController = TextEditingController();
  final _ubicacionController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final id = _idController.text;
      final titulo = _tituloController.text;
      final fecha = DateFormat('dd/MM/yyyy HH:mm').parse(_fechaController.text);
      final ubicacion = _ubicacionController.text;

      final newEvent = Evento(
        id: id,
        titulo: titulo,
        fecha: fecha,
        ubicacion: ubicacion,
        sesiones: [],
      );

      widget.onAddEvent(newEvent);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'ID del Evento'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce un ID';
                }
                if (value.length != 8) {
                  return 'El ID debe tener 8 dígitos';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _tituloController,
              decoration: InputDecoration(labelText: 'Título del Evento'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce un título';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _fechaController,
              decoration: InputDecoration(
                  labelText: 'Fecha del Evento (DD/MM/YYYY HH:MM)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce una fecha';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _ubicacionController,
              decoration: InputDecoration(labelText: 'Ubicación del Evento'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, introduce una ubicación';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Agregar Evento'),
            ),
          ],
        ),
      ),
    );
  }
}
