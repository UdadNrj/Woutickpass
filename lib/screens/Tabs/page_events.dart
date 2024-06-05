import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woutickpass/controllers/add_events.dart';
import 'package:woutickpass/src/widgets/Custom_Session.dart';

class PageEvents extends StatefulWidget {
  final List<SessionOn> selectedSessions;

  const PageEvents({super.key, required this.selectedSessions});

  @override
  State<PageEvents> createState() => _PageEventsState();
}

class _PageEventsState extends State<PageEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:
            Center(child: SvgPicture.asset("assets/icons/Logo-Div-black.svg")),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // Acción del filtro
            },
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(80),
              ),
            ),
            child: const Text('Modo online'),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedSessions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        widget.selectedSessions[index].title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                          'DD/MM/YYYY HH:MM – Ubicación\n0/200 entradas validadas'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SessionConfigurationPage(
                              session: widget.selectedSessions[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10.0),
            // CustomIconButton(
            //     padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            //     text: "AGREGAR NUEVO EVENTO",
            //     textStyle: TextStyle(
            //         color: Colors.white,
            //         fontSize: 14,
            //         fontWeight: FontWeight.w700),
            //     onPressed: () {})
            ElevatedButton.icon(
              onPressed: () {
                // Acción para agregar nuevo evento
              },
              icon: SvgPicture.asset('assets/icons/Group.svg'),
              label: const Text(
                'AGREGAR NUEVO EVENTO',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Color(0xFF202B37),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Multi-Evento',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Eventos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ajustes',
          ),
        ],
        currentIndex: 1,
        onTap: (index) {
          // Handle bottom navigation bar tap
        },
      ),
    );
  }
}
