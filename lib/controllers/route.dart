import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Tabs/page_events.dart';
import 'package:woutickpass/screens/Tabs/page_multievents.dart';
import 'package:woutickpass/screens/Tabs/page_settings.dart';

class Routes extends StatelessWidget {
  final int index;
  const Routes({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      const PageMultievents(),
      const PageEvents(),
      const PageSetting(),
    ];
    return pages[index];
  }
}
