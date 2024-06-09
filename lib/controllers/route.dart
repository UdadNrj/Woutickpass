import 'package:flutter/material.dart';
import 'package:woutickpass/prueba.dart';
import 'package:woutickpass/screens/Tabs/page_multievents.dart';
import 'package:woutickpass/screens/Tabs/page_events.dart';
import 'package:woutickpass/screens/Tabs/page_settings.dart';
import 'package:woutickpass/src/widgets/Custom_Session.dart';

class Routes extends StatelessWidget {
  final int index;
  final List<SessionOn> selectedSessions;

  const Routes(
      {super.key, required this.index, required this.selectedSessions});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const PageMultiEvents(
        selectedSessions: [],
      ),
      PageEvents(selectedSessions: selectedSessions),
      const PageSetting(),
    ];
    return pages[index];
  }
}
