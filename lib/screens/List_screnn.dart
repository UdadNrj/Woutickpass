import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Tabs/main_nav.dart';
import 'package:woutickpass/src/widgets/Custom_Session.dart';

class EventSessionsPage extends StatefulWidget {
  @override
  _EventSessionsPageState createState() => _EventSessionsPageState();
}

class _EventSessionsPageState extends State<EventSessionsPage> {
  List<SessionOn> sessions = [
    SessionOn(
      title: 'Título session 1',
      dateTime: '01/10/2024 12:00h',
      location: 'Ubicación 1',
      isSelected: false,
    ),
    SessionOn(
      title: 'Título  session 2',
      dateTime: '02/10/2024 13:00h',
      location: 'Ubicación 2',
      isSelected: false,
    ),
    SessionOn(
      title: 'Título session 3',
      dateTime: '03/10/2024 14:00h',
      location: 'Ubicación 3',
      isSelected: false,
    ),
    SessionOn(
      title: 'Título session 4',
      dateTime: '04/10/2024 15:00h',
      location: 'Ubicación 4',
      isSelected: false,
    ),
    SessionOn(
      title: 'Título session 5',
      dateTime: '05/10/2024 16:00h',
      location: 'Ubicación 5',
      isSelected: false,
    ),
    SessionOn(
      title: 'Título session 6',
      dateTime: '06/10/2024 17:00h',
      location: 'Ubicación 6',
      isSelected: false,
    ),
    SessionOn(
      title: 'Título session 7',
      dateTime: '07/10/2024 18:00h',
      location: 'Ubicación 7',
      isSelected: false,
    ),
    SessionOn(
      title: 'Título session 8',
      dateTime: '08/10/2024 19:00h',
      location: 'Ubicación 8',
      isSelected: false,
    ),
    SessionOn(
      title: 'Título session 9',
      dateTime: '09/10/2024 20:00h',
      location: 'Ubicación 9',
      isSelected: false,
    ),
  ];

  ValueNotifier<bool> isAnySelected = ValueNotifier<bool>(false);

  void updateSelection() {
    bool anySelected = sessions.any((session) => session.isSelected);
    isAnySelected.value = anySelected;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Lista de Sesiones'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Lista Name Evento:',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: ListView.builder(
                itemCount: sessions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                      child: ListTile(
                        title: Text(
                          sessions[index].title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                          '${sessions[index].dateTime} – ${sessions[index].location}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: Checkbox(
                          value: sessions[index].isSelected,
                          activeColor: Colors.green,
                          onChanged: (bool? value) {
                            setState(() {
                              sessions[index].isSelected = value!;
                              updateSelection();
                            });
                          },
                        ),
                        onTap: () {
                          setState(() {
                            sessions[index].isSelected =
                                !sessions[index].isSelected;
                            updateSelection();
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20.0),
            ValueListenableBuilder<bool>(
              valueListenable: isAnySelected,
              builder: (context, value, child) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    backgroundColor:
                        value ? Color(0XFF202B37) : Color(0X202B37),
                  ),
                  onPressed: value
                      ? () async {
                          List<SessionOn> selectedSessions = sessions
                              .where((session) => session.isSelected)
                              .toList();
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
                              updateSelection();
                            });
                          }
                        }
                      : null,
                  child: const Text(
                    'DESCARGAR ENTRADAS',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
