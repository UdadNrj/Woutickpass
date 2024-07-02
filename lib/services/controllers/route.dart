import 'package:flutter/material.dart';
import 'package:woutickpass/models/events_objeto..dart';
import 'package:woutickpass/screens/Tabs/page_multievents.dart';
import 'package:woutickpass/screens/Tabs/page_events.dart';
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
    List<Widget> pages = [
      PageMultiEvents(),
      PageEvents(selectedEvents: selectedEvents),
      const PageSetting(),
    ];

    assert(index >= 0 && index < pages.length);

    return pages[index];
  }
}
