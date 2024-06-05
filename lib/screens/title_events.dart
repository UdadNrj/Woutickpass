import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Tabs/page_events.dart';
import 'package:woutickpass/src/widgets/Custom_Session.dart';

class EventSessionsPage extends StatefulWidget {
  @override
  _EventSessionsPageState createState() => _EventSessionsPageState();
}

class _EventSessionsPageState extends State<EventSessionsPage> {
  List<SessionOn> sessions = [
    SessionOn(title: 'Session 1', isSelected: false),
    SessionOn(title: 'Session 2', isSelected: false),
    SessionOn(title: 'Session 3', isSelected: false),
    SessionOn(title: 'Session 4', isSelected: false),
    SessionOn(title: 'Session 5', isSelected: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Lista de Sesiones'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Lista Name Evento:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    title: Text(sessions[index].title),
                    value: sessions[index].isSelected,
                    activeColor: Colors.green,
                    onChanged: (bool? value) {
                      setState(() {
                        sessions[index].isSelected = value!;
                      });
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                List<SessionOn> selectedSessions = sessions
                    .where((SessionOn) => SessionOn.isSelected)
                    .toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PageEvents(selectedSessions: selectedSessions),
                  ),
                );
              },
              child: const Text('Show Selected Sessions'),
            ),
          ],
        ),
      ),
    );
  }
}

class DownloadEvents extends StatelessWidget {
  final bool isButtonEnabled;
  final void Function(BuildContext) navigateToNextPage;

  const DownloadEvents({
    required this.isButtonEnabled,
    required this.navigateToNextPage,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        backgroundColor:
            isButtonEnabled ? const Color(0xFF202B37) : Colors.grey,
      ),
      onPressed: isButtonEnabled ? () => navigateToNextPage(context) : null,
      child: const Text(
        "DESCARGAR ENTRADAS",
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
