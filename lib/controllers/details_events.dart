import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woutickpass/controllers/Input%20configuration.dart';
import 'package:woutickpass/controllers/aforo.dart';
import 'package:woutickpass/controllers/assistants.dart';
import 'package:woutickpass/controllers/filter.dart';
import 'package:woutickpass/controllers/vaciar_aforo.dart';
import 'package:woutickpass/view/BNavigator/button_nav.dart';
import 'package:woutickpass/view/BNavigator/page_multievents.dart';
import 'package:woutickpass/view/BNavigator/page_settings.dart';

class DetailsButton extends StatefulWidget {
  const DetailsButton({Key? key}) : super(key: key);

  @override
  _DetailsButtonState createState() => _DetailsButtonState();
}

class _DetailsButtonState extends State<DetailsButton> {
  int _currentIndex = 1;

  void _updateIndex(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: BNavigator(
        currentIndex: _currentIndex,
        onIndexChanged: _updateIndex,
      ),
      body: Container(
        color: const Color(0xFFdddddd),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Container(),
            Expanded(
              child: _buildBody(_currentIndex),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        'Título evento',
        style: TextStyle(
          color: Color.fromRGBO(20, 26, 36, 1),
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      // actions: const [
      //   IconButton(
      //     icon: Icon(Icons.filter_list),
      //     onPressed: _DetailsButtonState.new,
      //   ),
      // ],
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const PageMultievents();
      case 1:
        return _buildDetailsList();
      case 2:
        return const PageSetting();
      default:
        return Container();
    }
  }

  Widget _buildDetailsList() {
    return ListView(
      children: [
        _buildListTile(
          context,
          'Lista de asistentes',
          'Revisa la lista de asistentes totales a tu evento y edita los estados de las entradas de forma manual.',
          'assets/icons/Assit.svg',
          () => const assistantsButton(),
        ),
        const SizedBox(height: 20),
        _buildListTile(
          context,
          'Configuración de entradas',
          'Edita qué entradas quieres que se sincronicen con el escáner para esta sesión.',
          'assets/icons/Tickets.svg',
          () => const InputButton(),
        ),
        const SizedBox(height: 20),
        _buildListTile(
          context,
          'Estadísticas de aforo',
          'Accede a la información detallada y actualizada de los asistentes a esta sesión.',
          'assets/icons/Aforo.svg',
          () => const aforoButton(),
        ),
        const SizedBox(height: 20),
        _buildListTile(
          context,
          'Finalizar sesión',
          'Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo.',
          'assets/icons/Sesion.svg',
          () {},
        ),
        const SizedBox(height: 20),
        _buildListTile(
          context,
          'Vaciar aforo',
          'Reiniciar la lista de entradas validadas para esta sesión',
          'assets/icons/Aforo1.svg',
          () => const VaciaraforoButton(),
        ),
      ],
    );
  }

  ListTile _buildListTile(
    BuildContext context,
    String title,
    String subtitle,
    String iconPath,
    Function() onTap,
  ) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: SvgPicture.asset(
        iconPath,
        width: 40,
        height: 40,
      ),
      onTap: onTap,
      onLongPress: () {},
    );
  }

  void _openFilter() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: const addFilter(),
        ),
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