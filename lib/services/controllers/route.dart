import 'package:flutter/material.dart';
import 'package:woutickpass/models/events_objeto..dart';
import 'package:woutickpass/screens/Tabs/page_events.dart';
import 'package:woutickpass/screens/Tabs/page_multievents.dart';
import 'package:woutickpass/screens/Tabs/page_settings.dart';

class Routes extends StatelessWidget {
  final int index;
  final List<Event> selectedEvents;

  const Routes({
    Key? key,
    required this.index,
    required this.selectedEvents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return PageMultiEvents(); 
      case 1:
        return PageEvents(selectedEvents: selectedEvents);
      case 2:
        return PageSetting(); 
      default:
        return Center(child: Text('Pantalla Desconocida'));
    }
  }
}
