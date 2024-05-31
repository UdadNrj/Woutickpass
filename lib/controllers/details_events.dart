import 'package:flutter/material.dart';
import 'package:woutickpass/controllers/Events_sesion.dart';
import 'package:woutickpass/controllers/List_assitens.dart';
import 'package:woutickpass/controllers/Logout.dart';
import 'package:woutickpass/controllers/Statistics_capacity.dart';
import 'package:woutickpass/controllers/settings_tickets.dart';
import 'package:woutickpass/src/widgets/custom_Details_events.dart';

class DetailsButton extends StatelessWidget {
  final Evento evento;

  DetailsButton({required this.evento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(evento.titulo),
      ),
      body: ListView(
        children: [
          // OptionCard(
          //   icon: Icons.people,
          //   title: 'Lista de asistentes',
          //   description:
          //       'Revisa la lista de asistentes totales a tu evento y edita los estados de las entradas de forma manual.',
          //   onTap: () {
          //     // Navegar a la pantalla de lista de asistentes
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => ListaAsistentesScreen()),
          //     );
          //   },
          // ),
          // OptionCard(
          //   icon: Icons.settings,
          //   title: 'Configuración de entradas',
          //   description:
          //       'Edita qué entradas quieres que se sincronicen con el escáner para esta sesión.',
          //   onTap: () {
          //     // Navegar a la pantalla de configuración de entradas
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => ConfiguracionEntradasScreen()),
          //     );
          //   },
          // ),
          // OptionCard(
          //   icon: Icons.bar_chart,
          //   title: 'Estadísticas de aforo',
          //   description:
          //       'Accede a la información detallada y actualizada de los asistentes a esta sesión.',
          //   onTap: () {
          //     // Navegar a la pantalla de estadísticas de aforo
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => EstadisticasAforoScreen()),
          //     );
          //   },
          // ),
          // OptionCard(
          //   icon: Icons.exit_to_app,
          //   title: 'Finalizar sesión',
          //   description:
          //       'Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo.',
          //   onTap: () {
          //     // Navegar a la pantalla de finalizar sesión
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => FinalizarSesionScreen()),
          //     );
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: Icon(Icons.qr_code_scanner, color: Colors.white),
              label: Text('ESCANEAR ENTRADAS',
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                // Acción para escanear entradas
              },
            ),
          ),
        ],
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