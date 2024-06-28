import 'package:flutter/material.dart';
import 'package:woutickpass/screens/Tabs/page_multievents.dart';
import 'package:woutickpass/screens/Tabs/page_events.dart';
import 'package:woutickpass/screens/Tabs/page_settings.dart';
import 'package:woutickpass/src/widgets/custom_events.dart'; // Asegúrate de importar tus widgets personalizados si es necesario

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
      PageMultiEvents(selectedSessions: []), // Página 0, ejemplo
      PageEvents(
          selectedEvents:
              selectedEvents), // Página 1, pasando los eventos seleccionados
      const PageSetting(), // Página 2, ejemplo
    ];

    assert(index >= 0 && index < pages.length);

    return pages[index];
  }
}
