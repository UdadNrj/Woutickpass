import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Events_details_screnn.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Eventos'),
      ),
      body: FutureBuilder<List<Event2>>(
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
            itemCount: events.length,
            itemBuilder: (context, index) {
              Event2 event = events[index];
              return CheckboxListTile(
                title: Text(event.name),
                subtitle: Text(event.startAt.toString()),
                value: checkedEvents[event.uuid],
                onChanged: (bool? value) {
                  setState(() {
                    checkedEvents[event.uuid] = value ?? false;
                  });
                },
                secondary: IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetailsScreen(event: event),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
