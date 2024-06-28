import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Tabs/main_nav.dart';
import 'package:woutickpass/services/Api/auth_events.dart';
import 'package:woutickpass/src/widgets/custom_Events.dart';

class EventsScreen extends StatefulWidget {
  final String token;

  EventsScreen({required this.token});

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  late Future<List<Event2>> futureEvents;
  List<Event2> events = [];
  Map<String, bool> checkedEvents = {};

  @override
  void initState() {
    super.initState();
    futureEvents = EventService.getEvents(widget.token);
  }

  bool get isButtonActive {
    return checkedEvents.values.where((isChecked) => isChecked).length >= 1;
  }

  void handleCheckboxChange(String uuid, bool? value) {
    setState(() {
      checkedEvents[uuid] = value ?? false;
    });
  }

  List<Event2> getSelectedEvents() {
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
          FutureBuilder<List<Event2>>(
            future: futureEvents,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No events found'));
              }

              events = snapshot.data!;
              for (var event in events) {
                if (!checkedEvents.containsKey(event.uuid)) {
                  checkedEvents[event.uuid] = false;
                }
              }

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 80.0),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  Event2 event = events[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(
                            currentIndex: 0,
                            selectedEvents: getSelectedEvents(),
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
