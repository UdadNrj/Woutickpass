import 'package:flutter/material.dart';

class BNavigator extends StatefulWidget {
  final Function currentIndex;
  const BNavigator({super.key, required this.currentIndex});

  @override
  State<StatefulWidget> createState() => _BNavigatorState();
}

class _BNavigatorState extends State<BNavigator> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: index,
        onTap: (int i) {
          setState(() {
            index = i;
            widget.currentIndex(i);
          });
        },
        selectedItemColor: Colors.pink,
        iconSize: 25.0,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.event), label: 'Multi-Eventos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.event_available_outlined), label: 'Eventos'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settigs')
        ]);
  }
}
