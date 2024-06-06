import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Tabs/main_nav.dart';
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
              onPressed: () async {
                List<SessionOn> selectedSessions =
                    sessions.where((session) => session.isSelected).toList();
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(
                      currentIndex: 1,
                      selectedSessions: selectedSessions,
                    ),
                  ),
                );
                // Update sessions if necessary
                if (result != null && result is List<SessionOn>) {
                  setState(() {
                    sessions = result;
                  });
                }
              },
              child: const Text('Show Selected Sessions'),
            ),
          ],
        ),
      ),
    );
  }
}
