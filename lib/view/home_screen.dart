import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woutickpass/models/Button_code.dart';

import 'package:woutickpass/view/login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

void _openIconButtonPressed(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: CodePage(),
            ),
          ));
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/img-login.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleUpWidget(),
                SizedBox(height: 10),
                TitleFeaturedWidget(),
                SizedBox(height: 40),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                      backgroundColor: Color(0xFFCC3364),
                    ),
                    onPressed: () => _openIconButtonPressed(context),
                    child: const Text(
                      "INTRODUCIR CODIGO DE EVENTO",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w700),
                    )),
                SizedBox(height: 20),
                ButtonHeader(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        _createRoute(
                          LoginPage(),
                        ));
                  },
                  child: const Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                        color: Color(0xFFCC3364),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Route _createRoute(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const Curve = Curves.easeInOutCirc;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class TitleUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500,
          color: Colors.transparent,
        ),
        Positioned(
          top: 20,
          child: SvgPicture.asset("assets/icons/Logo-Div.svg"),
        ),
      ],
    );
  }
}

class TitleFeaturedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "CONTROL DE ACCESOS.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          "SIMPLIFICADO.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class ButtonHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "¿Tienes cuenta en management.woutick?",
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
