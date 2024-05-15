import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woutickpass/controllers/filter.dart';
import 'package:woutickpass/view/BNavigator/button_nav.dart';
import 'package:woutickpass/controllers/route.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void _openIconButtonPressed(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: addFilter(),
        ),
      ),
    );
  }

  int index = 1;
  String token = "";
  BNavigator? bottomRoute;

  @override
  void initState() {
    super.initState();
    bottomRoute = BNavigator(currentIndex: (route) {
      setState(() {
        index = route;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: SvgPicture.asset("assets/icons/Logo-Div-black.svg"),
          actions: <Widget>[
            IconButton(
              icon: SvgPicture.asset("assets/icons/Filter.svg"),
              onPressed: () => _openIconButtonPressed(context),
            ),
          ],
        ),
        bottomNavigationBar: bottomRoute,
        body: Container(
          color: Color(0xFFdddddd),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Container(),
              Expanded(
                child: Routes(index: index),
              ),
            ],
          ),
        ));
  }
}
