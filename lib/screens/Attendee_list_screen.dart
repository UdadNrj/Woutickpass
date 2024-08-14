// import 'package:flutter/material.dart';
// import 'package:woutickpass/models/objects/session.dart';
// import 'package:woutickpass/models/objects/attendee.dart';
// import 'package:woutickpass/models/objects/ticket.dart';
// import 'package:woutickpass/screens/Search_AttendeesScreen.dart';

// class AttendeesListScreen extends StatelessWidget {
//   final Session event;
//   final List<Ticket> tickets;

//   const AttendeesListScreen({
//     Key? key,
//     required this.event,
//     required this.tickets,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Attendee> attendees = convertTicketsToAttendees(tickets);
//     print('Asistentes convertidos: $attendees');

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('${event.title} - Asistentes'),
//         backgroundColor: Colors.white,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search, color: Colors.black),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       SearchAttendeesScreen(attendees: attendees),
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               event.title,
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(
//               '${event.startAt} - ${event.startAt}',
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//             ),
//             SizedBox(height: 16),
//             Expanded(
//               child: attendees.isEmpty
//                   ? Center(
//                       child: Text(
//                         'No hay asistentes para este evento.',
//                         style: TextStyle(fontSize: 18, color: Colors.grey),
//                       ),
//                     )
//                   : ListView.builder(
//                       itemCount: attendees.length,
//                       itemBuilder: (context, index) {
//                         final attendee = attendees[index];
//                         return Card(
//                           margin: const EdgeInsets.symmetric(vertical: 8.0),
//                           child: ListTile(
//                             leading: _getStatusIcon(attendee.status),
//                             title: Text(attendee.name),
//                             subtitle: Text(
//                                 '${attendee.ticketType} (${attendee.ticketCode})'),
//                             trailing: Icon(Icons.arrow_forward),
//                             onTap: () {},
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<Attendee> convertTicketsToAttendees(List<Ticket> tickets) {
//     print('Convirtiendo tickets a asistentes: $tickets');
//     return tickets.map((ticket) {
//       return Attendee(
//         name: ticket.name,
//         ticketType: ticket.type,
//         ticketCode: ticket.ticketCode,
//         status: ticket.status,
//       );
//     }).toList();
//   }

//   Widget _getStatusIcon(String status) {
//     switch (status) {
//       case 'DENTRO':
//         return Icon(Icons.check_circle, color: Colors.green);
//       case 'SIN REGISTRO':
//         return Icon(Icons.help, color: Colors.grey);
//       case 'FUERA':
//         return Icon(Icons.exit_to_app, color: Colors.blue);
//       case 'DEVUELTA':
//         return Icon(Icons.undo, color: Colors.red);
//       case 'ACCESO BLOQUEADO':
//         return Icon(Icons.block, color: Colors.red);
//       default:
//         return Icon(Icons.help, color: Colors.grey);
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/ticket.dart';

class AttendeesListScreen extends StatelessWidget {
  final String event;
  final List<Ticket> tickets;

  const AttendeesListScreen({
    Key? key,
    required this.event,
    required this.tickets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Tickets for Event $event'),
      ),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            elevation: 4.0,
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              leading:
                  Icon(Icons.confirmation_number, size: 40, color: Colors.blue),
              title: Text(
                ticket.ticketCode,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.0),
                  Text('Status: ${ticket.status}',
                      style: TextStyle(color: Colors.grey[700])),
                  SizedBox(height: 4.0),
                  Text('Postal Code: ${ticket.postalCode}',
                      style: TextStyle(color: Colors.grey[700])),
                  SizedBox(height: 4.0),
                  Text('Email: ${ticket.email}',
                      style: TextStyle(color: Colors.grey[700])),
                  SizedBox(height: 4.0),
                  Text('Phone: ${ticket.phone}',
                      style: TextStyle(color: Colors.grey[700])),
                  SizedBox(height: 4.0),
                  Text('Name: ${ticket.name}',
                      style: TextStyle(color: Colors.grey[700])),
                ],
              ),
              isThreeLine: true,
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              // OnTap callback if you want to navigate to a detailed view
              onTap: () {
                // You can navigate to a detailed view or perform other actions here
                // Navigator.push(context, MaterialPageRoute(builder: (context) => TicketDetailScreen(ticket: ticket)));
              },
            ),
          );
        },
      ),
    );
  }
}
