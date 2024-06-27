// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:woutickpass/services/controllers/Ss_Configuration.dart';
// import 'package:woutickpass/models/Custom_Session.dart';

// class PageEvents extends StatefulWidget {
//   final List<SessionOn> selectedSessions;

//   const PageEvents({super.key, required this.selectedSessions});

//   @override
//   State<PageEvents> createState() => _PageEventsState();
// }

// class _PageEventsState extends State<PageEvents> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[200],
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.selectedSessions.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Card(
//                   margin: const EdgeInsets.symmetric(
//                       vertical: 8.0, horizontal: 16.0),
//                   child: ListTile(
//                     title: Text(
//                       widget.selectedSessions[index].title,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: const Text(
//                         'DD/MM/YYYY HH:MM – Ubicación\n0/200 entradas validadas'),
//                     trailing: Icon(Icons.chevron_right),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => SessionConfigurationPage(
//                               session: widget.selectedSessions[index]),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 10.0),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: ElevatedButton.icon(
//               onPressed: () {
//                 // Acción para agregar nuevo evento
//               },
//               icon: SvgPicture.asset('assets/icons/Group.svg'),
//               label: const Text(
//                 'AGREGAR NUEVO EVENTO',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w700),
//               ),
//               style: ElevatedButton.styleFrom(
//                 padding: EdgeInsets.symmetric(vertical: 16.0),
//                 backgroundColor: Color(0xFF202B37),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(80),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:woutickpass/src/widgets/custom_Events.dart';

class PageEvents extends StatelessWidget {
  final List<Event2> selectedEvents;

  const PageEvents({
    Key? key,
    required this.selectedEvents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: selectedEvents.length,
      itemBuilder: (context, index) {
        Event2 event = selectedEvents[index];
        return ListTile(
          title: Text(event.name),
          subtitle: Text(event.startAt.toString()),
        );
      },
    );
  }
}
