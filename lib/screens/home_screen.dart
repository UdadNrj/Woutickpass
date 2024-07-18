import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woutickpass/models/Button_code_events.dart';
import 'package:woutickpass/providers/token_provider.dart';
import 'package:woutickpass/screens/login_screen.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tokenProvider = context.watch<TokenProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleUpWidget(),
                const SizedBox(height: 20),
                TitleFeaturedWidget(),
                const SizedBox(height: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 16),
                    backgroundColor: Color(0xFFCC3364),
                  ),
                  onPressed: () => _openIconButtonPressed(context),
                  child: const Text(
                    "INTRODUCIR CODIGO DE EVENTO",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ButtonHeader(),
                if (tokenProvider.token.isEmpty)
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        _createRoute(LoginPage()),
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
                      const SizedBox(height: 20),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
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
    return const Column(
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
    return const Text(
      "¿Tienes cuenta en management.woutick?",
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var tokenProvider = context.watch<TokenProvider>();

//     // Obtén el tamaño de la pantalla y la altura del teclado
//     final screenSize = MediaQuery.of(context).size;
//     final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('assets/images/img-login.jpg'),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 TitleUpWidget(),
//                 const SizedBox(height: 20),
//                 TitleFeaturedWidget(),
//                 const SizedBox(height: 50),
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: screenSize.width *
//                           0.1), // Ajusta el padding basado en el ancho de pantalla
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(
//                           vertical: screenSize.height *
//                               0.02), // Ajusta el padding vertical basado en el alto de pantalla
//                       backgroundColor: const Color(0xFFCC3364),
//                     ),
//                     onPressed: () => _openIconButtonPressed(context),
//                     child: const Text(
//                       "INTRODUCIR CODIGO DE EVENTO",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize:
//                             16, // Ajustar el tamaño del texto para mejor legibilidad
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 ButtonHeader(),
//                 if (tokenProvider.token.isEmpty)
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         _createRoute(LoginPage()),
//                       );
//                     },
//                     child: const Text(
//                       'Iniciar Sesión',
//                       style: TextStyle(
//                         color: Color(0xFFCC3364),
//                         fontSize: 16, // Tamaño del texto ajustado
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   )
//                 else
//                   Column(
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           tokenProvider.clearToken();
//                         },
//                         child: const Text('Cerrar Sesión'),
//                       ),
//                       const SizedBox(height: 20),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// void _openIconButtonPressed(BuildContext context) {
//   showModalBottomSheet(
//     backgroundColor: Colors.white,
//     isScrollControlled: true,
//     context: context,
//     builder: (ctx) => SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom,
//         ),
//         child: CodePage(),
//       ),
//     ),
//   );
// }

// Route _createRoute(Widget child) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => child,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(0.0, 1.0);
//       const end = Offset.zero;
//       const curve = Curves.easeInOutCirc;

//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//       return SlideTransition(
//         position: animation.drive(tween),
//         child: child,
//       );
//     },
//   );
// }

// class TitleUpWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Container(
//       margin: EdgeInsets.symmetric(
//           horizontal: screenWidth * 0.1), // Ajustar el margen horizontal
//       child: Stack(
//         alignment: Alignment.center,
//         children: [
//           SvgPicture.asset(
//             "assets/icons/Logo-Div.svg",
//             width: screenWidth *
//                 0.6, // Escalar el tamaño del SVG basado en el ancho de pantalla
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TitleFeaturedWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment:
//           CrossAxisAlignment.center, // Asegura que los textos estén centrados
//       children: const [
//         Text(
//           "CONTROL DE ACCESOS.",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize:
//                 28, // Tamaño del texto ajustado para ser más legible en pantallas grandes
//             fontWeight: FontWeight.w900,
//           ),
//         ),
//         Text(
//           "SIMPLIFICADO.",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize:
//                 28, // Tamaño del texto ajustado para ser más legible en pantallas grandes
//             fontWeight: FontWeight.w900,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class ButtonHeader extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return const Text(
//       "¿Tienes cuenta en management.woutick?",
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: 14, // Tamaño del texto ajustado para ser legible
//         fontWeight: FontWeight.w600,
//       ),
//     );
//   }
// }
