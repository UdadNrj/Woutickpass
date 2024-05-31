import 'package:flutter/material.dart';
import 'package:woutickpass/controllers/Events_sesion.dart';

class DetailsButton extends StatelessWidget {
  final Evento evento;

  DetailsButton({required this.evento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Evento ${evento.id}'),
      ),
      body: ListView.builder(
        itemCount: evento.sesiones.length,
        itemBuilder: (context, index) {
          final sesion = evento.sesiones[index];
          return ListTile(
            title: Text(sesion.nombre),
            subtitle: Text('${sesion.ubicacion} - ${sesion.fecha}'),
          );
        },
      ),
    );
  }
}
