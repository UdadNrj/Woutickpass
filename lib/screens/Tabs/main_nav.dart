import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woutickpass/models/objects/session_details.dart';
import 'package:woutickpass/screens/Tabs/button_nav.dart';
import 'package:woutickpass/services/controllers/route.dart';

class MainPage extends StatefulWidget {
  final String token;
  final int currentIndex;
  final List<SessionDetails> selectedEvents;

  const MainPage({
    Key? key,
    required this.token,
    required this.currentIndex,
    required this.selectedEvents,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SvgPicture.asset('assets/icons/Logo-Div-black.svg'),
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset("assets/icons/Modo_online.svg"),
        ),
        actions: <Widget>[
          if (_currentIndex == 1)
            IconButton(
              icon: SvgPicture.asset("assets/icons/Filter.svg"),
              onPressed: () {},
            ),
        ],
      ),
      bottomNavigationBar: BNavigator(
        currentIndex: _currentIndex,
        onIndexChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: Routes(index: _currentIndex, selectedEvents: []),
    );
  }
}
