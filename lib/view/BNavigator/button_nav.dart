import 'package:flutter/material.dart';

class BNavigator extends StatefulWidget {
  final int currentIndex;
  final Function(int) onIndexChanged;

  const BNavigator({
    Key? key,
    required this.currentIndex,
    required this.onIndexChanged,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BNavigatorState();
}

class _BNavigatorState extends State<BNavigator> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: _index,
      onTap: (int i) {
        setState(() {
          _index = i;
          widget.onIndexChanged(i);
        });
      },
      selectedItemColor: Colors.pink,
      iconSize: 25.0,
      selectedFontSize: 14.0,
      unselectedFontSize: 12.0,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.event),
          label: 'Multi-Eventos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.event_available_outlined),
          label: 'Eventos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
