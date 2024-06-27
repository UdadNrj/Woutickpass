import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Tabs/page_multievents.dart';
import 'package:woutickpass/screens/Tabs/page_events.dart';
import 'package:woutickpass/screens/Tabs/page_settings.dart';
import 'package:woutickpass/src/widgets/custom_Events.dart';

class Routes extends StatelessWidget {
  final int index;
  final List<Event2> selectedEvents;

  const Routes({
    Key? key,
    required this.index,
    required this.selectedEvents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      PageMultiEvents(
        selectedSessions: [],
      ),
      PageEvents(selectedEvents: selectedEvents),
      const PageSetting(),
    ];
    return pages[index];
  }
}
