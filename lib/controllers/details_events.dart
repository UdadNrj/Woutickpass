import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woutickpass/controllers/Input%20configuration.dart';
import 'package:woutickpass/controllers/aforo.dart';
import 'package:woutickpass/controllers/assistants.dart';
import 'package:woutickpass/controllers/vaciar_aforo.dart';
import 'package:woutickpass/models/qr_scanner.dart';
import 'package:woutickpass/view/BNavigator/page_events.dart';
import 'package:woutickpass/view/BNavigator/page_multievents.dart';

class DetailsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Titulo evento',
          style: TextStyle(
              color: Color.fromRGBO(20, 26, 36, 1),
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
      ),
      body: Container(
        color: Color(0xFFdddddd),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  color: Colors.white,
                  child: ListTile(
                    title: const Text("Lista de asistentes"),
                    subtitle: const Text(
                        "Revisa la lista de asistentes totales a tu evento y edita los estados de las entradas de forma manual."),
                    trailing: SvgPicture.asset(
                      "assets/icons/Assit.svg",
                      width: 40,
                      height: 40,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const assistantsButton()));
                    },
                    onLongPress: () {},
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  color: Colors.white,
                  child: ListTile(
                    title: const Text("Configuración de entradas"),
                    subtitle: const Text(
                        "Edita qué entradas quieres que se sincronicen con el escáner para esta sesión."),
                    trailing: SvgPicture.asset(
                      "assets/icons/Tickets.svg",
                      width: 40,
                      height: 40,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const InputButton()));
                    },
                    onLongPress: () {},
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  color: Colors.white,
                  child: ListTile(
                    title: const Text("Estadísticas de aforo"),
                    subtitle: const Text(
                        "Accede a la información detallada y acutalizada de los asistentes a esta sesión."),
                    trailing: SvgPicture.asset(
                      "assets/icons/Aforo.svg",
                      width: 40,
                      height: 40,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const aforoButton()));
                    },
                    onLongPress: () {},
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  color: Colors.white,
                  child: ListTile(
                    title: const Text("Finalizar sesión"),
                    subtitle: const Text(
                        "Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo."),
                    trailing: SvgPicture.asset(
                      "assets/icons/Sesion.svg",
                      width: 40,
                      height: 40,
                    ),
                    onTap: () {},
                    onLongPress: () {},
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  color: Colors.white,
                  child: ListTile(
                    title: const Text("Vaciar aforo"),
                    subtitle: const Text(
                        "Reiniciar la lista de entradas validadas para esta sesion"),
                    trailing: SvgPicture.asset(
                      "assets/icons/Aforo1.svg",
                      width: 40,
                      height: 40,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VaciaraforoButton()));
                    },
                    onLongPress: () {},
                  ),
                ),
              ],
            ),
            Positioned(
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                    backgroundColor: Color(0xFFCC3366)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const PageQR()));
                },
                child: const Text(
                  'ESCANEAR ENTRADAS',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PageEvents()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PageMultievents()),
            );
          }
        },
      ),
    );
  }
}

// class ListTileEvent extends StatelessWidget {
//   const ListTileEvent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//             color: Colors.white,
//             child: ListTile(
//               title: const Text("Lista de asistentes"),
//               subtitle: const Text(
//                   "Revisa la lista de asistentes totales a tu evento y edita los estados de las entradas de forma manual."),
//               trailing: SvgPicture.asset(
//                 "assets/icons/Assit.svg",
//                 width: 40,
//                 height: 40,
//               ),
//               onTap: () {},
//               onLongPress: () {},
//             ),
//           ),
//           const SizedBox(height: 20),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//             color: Colors.white,
//             child: ListTile(
//               title: Text("Configuración de entradas"),
//               subtitle: Text(
//                   "Edita qué entradas quieres que se sincronicen con el escáner para esta sesión."),
//               trailing: SvgPicture.asset(
//                 "assets/icons/Tickets.svg",
//                 width: 40,
//                 height: 40,
//               ),
//               onTap: () {},
//               onLongPress: () {},
//             ),
//           ),
//           const SizedBox(height: 20),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//             color: Colors.white,
//             child: ListTile(
//               title: Text("Estadísticas de aforo"),
//               subtitle: Text(
//                   "Accede a la información detallada y acutalizada de los asistentes a esta sesión."),
//               trailing: SvgPicture.asset(
//                 "assets/icons/Aforo.svg",
//                 width: 40,
//                 height: 40,
//               ),
//               onTap: () {},
//               onLongPress: () {},
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//             color: Colors.white,
//             child: ListTile(
//               title: Text("Finalizar sesión"),
//               subtitle: Text(
//                   "Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo."),
//               trailing: SvgPicture.asset(
//                 "assets/icons/Sesion.svg",
//                 width: 40,
//                 height: 40,
//               ),
//               onTap: () {},
//               onLongPress: () {},
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//             color: Colors.white,
//             child: ListTile(
//               title: const Text("Vaciar aforo"),
//               subtitle: const Text(
//                   "Reiniciar la lista de entradas validadas para esta sesion"),
//               trailing: SvgPicture.asset(
//                 "assets/icons/Aforo1.svg",
//                 width: 40,
//                 height: 40,
//               ),
//               onTap: () {},
//               onLongPress: () {},
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//  Container(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//             color: Colors.white,
//             child: ListTile(
//               title: Text("Vaciar Aforo"),
//               subtitle: Text(
//                   "Reiniciar la lista de entradas validadas para esta sesion."),
//               trailing: SvgPicture.asset(
//                 "assets/icons/Sesion.svg",
//                 width: 40,
//                 height: 40,
//               ),
//               onTap: () {},
//               onLongPress: () {},
//             ),
//           ),