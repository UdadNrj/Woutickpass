import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';

import 'package:woutickpass/screens/Tabs/main_nav.dart';
import 'package:woutickpass/services/Api/api_auth_sessions.dart';

import 'package:woutickpass/services/sessions_dao.dart';

class EventsScreen extends StatefulWidget {
  final String token;

  EventsScreen({required this.token});

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late Future<List<Session>> futureEvents;
  List<Session> events = [];
  Map<String, bool> checkedEvents = {};

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    futureEvents = EventService.getEvents(widget.token);

    try {
      final apiEvents = await futureEvents;
      events = apiEvents;

      await SessionsDao().storeSessions(events);

      final selectedEvents = await SessionsDao().getSelectedSessions();
      checkedEvents = {
        for (var event in events)
          event.uuid: selectedEvents.contains(event.uuid),
      };
      setState(() {});
    } catch (e) {
      events = await SessionsDao().retrieveSessions();
      checkedEvents = {
        for (var event in events) event.uuid: false,
      };
      print('Error al cargar eventos desde la API: $e');
    }
  }

  bool get isButtonActive {
    return checkedEvents.values.where((isChecked) => isChecked).length >= 1;
  }

  void handleCheckboxChange(String uuid, bool? value) {
    setState(() {
      checkedEvents[uuid] = value ?? false;
    });

    final selectedEvents = getSelectedEvents();
    SessionsDao()
        .updateSelectedSessions(selectedEvents.map((e) => e.uuid).toList());
  }

  List<Session> getSelectedEvents() {
    return events.where((event) => checkedEvents[event.uuid] == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('Eventos'),
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Session>>(
            future: futureEvents,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No se encontraron Eventos'));
              }

              events = snapshot.data!;
              for (var event in events) {
                if (!checkedEvents.containsKey(event.uuid)) {
                  checkedEvents[event.uuid] = false;
                }
              }

              return ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  Session event = events[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFFE4E7EC)),
                      ),
                      child: CheckboxListTile(
                        title: Text(event.name),
                        subtitle: Text(event.startAt.toString()),
                        value: checkedEvents[event.uuid],
                        onChanged: (bool? value) {
                          handleCheckboxChange(event.uuid, value);
                        },
                        activeColor: Colors.green,
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: isButtonActive
                  ? () {
                      List<Session> selectedEvents = getSelectedEvents();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(
                            token: widget.token,
                            currentIndex: 1,
                            selectedEvents: selectedEvents,
                          ),
                        ),
                      );
                    }
                  : null,
              child: Text(
                'DESCARGAR ENTRADAS',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                backgroundColor: Color(0xFF141C24),
                disabledBackgroundColor: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
