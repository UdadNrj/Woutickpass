import 'package:flutter/material.dart';
import 'package:woutickpass/controllers/add_events.dart';
import 'package:woutickpass/controllers/details_events.dart';
import 'package:woutickpass/controllers/Events_sesion.dart';

class PageEvents extends StatefulWidget {
  const PageEvents({super.key});

  @override
  State<StatefulWidget> createState() => _PageEventsState();
}

class _PageEventsState extends State<PageEvents> {
  List<Evento> eventos = [
    Evento(
      id: '87654321',
      titulo: 'Velada IIII',
      fecha: DateTime.now(),
      ubicacion: 'Bernabeu',
      sesiones: [],
    ),
    Evento(
      id: '12345678',
      titulo: 'Concierto de Rock',
      fecha: DateTime.now(),
      ubicacion: 'Estadio Nacional',
      sesiones: [],
    ),
    Evento(
      id: '87654321',
      titulo: 'Feria de Libros',
      fecha: DateTime.now(),
      ubicacion: 'Centro de Convenciones',
      sesiones: [],
    ),
  ];

  void _openIconButtonPressed(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddEvents(onAddEvent: _addEvent),
        ),
      ),
    );
  }

  void _addEvent(Evento newEvent) {
    setState(() {
      eventos.add(newEvent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFdddddd),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: eventos.length,
              itemBuilder: (context, index) {
                return ListTileEvent(
                  evento: eventos[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsButton(evento: eventos[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
              backgroundColor: const Color(0xFF202B37),
            ),
            onPressed: () => _openIconButtonPressed(context),
            child: const Text(
              "INTRODUCIR CODIGO DE EVENTO",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListTileEvent extends StatelessWidget {
  final Evento evento;
  final VoidCallback onTap;

  const ListTileEvent({required this.evento, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(evento.titulo),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${evento.fecha.day}/${evento.fecha.month}/${evento.fecha.year} ${evento.fecha.hour}:${evento.fecha.minute} – ${evento.ubicacion}',
              ),
              Text('0/200 entradas validadas'), // Ejemplo de entradas validadas
            ],
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
      ),
    );
  }
}
