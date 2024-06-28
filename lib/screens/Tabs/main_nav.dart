import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woutickpass/services/controllers/filter.dart';
import 'package:woutickpass/services/controllers/route.dart';
import 'package:woutickpass/screens/Tabs/button_nav.dart';
import 'package:woutickpass/src/widgets/custom_events.dart';

class MainPage extends StatefulWidget {
  final String token;
  final int currentIndex;
  final List<Event2> selectedEvents;

  const MainPage({
    Key? key,
    required this.token,
    required this.currentIndex,
    required this.selectedEvents,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _currentIndex;
  late List<Event2> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _selectedEvents = widget.selectedEvents;
  }

  void _openFilterSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.all(16),
          child: addFilter(),
        ),
      ),
    );
  }

  Widget _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return Text('Multi-Eventos');
      case 1:
        return SvgPicture.asset('assets/icons/Logo-Div-black.svg');
      case 2:
        return Text('Settings');
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: _getAppBarTitle(_currentIndex),
        leading: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            "assets/icons/Modo_online.svg",
          ),
        ),
        actions: <Widget>[
          if (_currentIndex == 1)
            IconButton(
              icon: SvgPicture.asset("assets/icons/Filter.svg"),
              onPressed: () => _openFilterSheet(context),
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
      body: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Expanded(
              child: Routes(
                index: _currentIndex,
                selectedEvents: _selectedEvents,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
