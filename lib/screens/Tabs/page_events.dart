import 'package:flutter/material.dart';
import 'package:woutickpass/controllers/add_events.dart';
import 'package:woutickpass/controllers/details_events.dart';

class PageEvents extends StatefulWidget {
  const PageEvents({super.key});

  @override
  State<StatefulWidget> createState() => _PageEventsState();
}

class _PageEventsState extends State<PageEvents> {
  void _openIconButtonPressed(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: addEvents(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const ListTileEvent(),
        const SizedBox(height: 300),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 16),
              backgroundColor: const Color(0xFF202B37)),
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
    );
  }
}

class ListTileEvent extends StatelessWidget {
  const ListTileEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            color: Colors.white,
            child: ListTile(
              title: const Text("Título Evento"),
              subtitle: const Text("DD/MM/YYYY HH:MM – Ubicación"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DetailsButton()));
              },
              onLongPress: () {},
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            color: Colors.white,
            child: ListTile(
              title: const Text("Título Evento"),
              subtitle: const Text("DD/MM/YYYY HH:MM – Ubicación"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DetailsButton()));
              },
              onLongPress: () {},
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            color: Colors.white,
            child: ListTile(
              title: const Text("Título Evento"),
              subtitle: const Text("DD/MM/YYYY HH:MM – Ubicación"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {},
              onLongPress: () {},
            ),
          ),
        ],
      ),
    );
  }
}
