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
  late Future<List<EventS>> futureEvents;
  List<EventS> events = [];

  @override
  void initState() {
    super.initState();
    futureEvents = EventService.getEvents(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: FutureBuilder<List<EventS>>(
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

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              EventS event = events[index];
              return CheckboxListTile(
                title: Text(event.name),
                subtitle: Text(event.publicStartAt.toString()),
                value: event.isSelected,
                onChanged: (bool? value) {
                  setState(() {
                    event.isSelected = value ?? false;
                  });
                },
                secondary: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (event.isSelected) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EventDetailsScreen(event: event),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Please select the event first.')),
                      );
                    }
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
