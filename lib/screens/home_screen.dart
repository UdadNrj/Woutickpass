import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:woutickpass/models/drawers/drawer_code_event.dart';
import 'package:woutickpass/screens/login_screen.dart';
import 'package:woutickpass/providers/token_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tokenProvider = context.watch<TokenProvider>();
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/img-login.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: constraints.maxWidth * 0.1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TitleUpWidget(),
                        SizedBox(height: screenSize.height * 0.02),
                        TitleFeaturedWidget(),
                        SizedBox(height: screenSize.height * 0.05),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width * 0.15,
                                vertical: screenSize.height * 0.02),
                            backgroundColor: const Color(0xFFCC3364),
                          ),
                          onPressed: () => _openIconButtonPressed(
                              context, "defaultParameter"),
                          child: const FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "INTRODUCIR CODIGO DE EVENTO",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: screenSize.height * 0.02),
                        ButtonHeader(),
                        if (tokenProvider.token.isEmpty)
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                _createRoute(const LoginScreen()),
                              );
                            },
                            child: const Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                color: Color(0xFFCC3364),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        else
                          Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  tokenProvider.clearToken();
                                },
                                child: const Text('Cerrar Sesión'),
                              ),
                              SizedBox(height: screenSize.height * 0.02),
                            ],
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _openIconButtonPressed(BuildContext context, String parameter) {
  showModalBottomSheet(
    backgroundColor: Colors.white,
    isScrollControlled: true,
    context: context,
    builder: (ctx) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: DrawerCodeEvent(someParameter: parameter),
      ),
    ),
  );
}

Route _createRoute(Widget child) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOutCirc;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

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
          height: MediaQuery.of(context).size.height * 0.4,
          color: Colors.transparent,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.02,
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
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "CONTROL DE ACCESOS.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "SIMPLIFICADO.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      "¿Tienes cuenta en management.woutick?",
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
