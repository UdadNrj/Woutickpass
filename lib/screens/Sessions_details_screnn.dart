// import 'package:flutter/material.dart';
// import 'package:woutickpass/models/objects/session.dart';
// import 'package:woutickpass/models/objects/ticket.dart';
// import 'package:woutickpass/screens/Statistics_screnn.dart';
// import 'package:woutickpass/services/api/session_api.dart';
// import 'package:woutickpass/models/logic/scanner_page.dart';
// import 'package:woutickpass/services/api/tickets_api.dart';

// class EventDetailsPage extends StatefulWidget {
//   final String sessionId;

//   const EventDetailsPage({
//     Key? key,
//     required this.sessionId,
//   }) : super(key: key);

//   @override
//   _EventDetailsPageState createState() => _EventDetailsPageState();
// }

// class _EventDetailsPageState extends State<EventDetailsPage> {
//   late Future<Session?> _eventFuture;
//   late Future<List<Ticket>> _ticketsFuture;

//   @override
//   void initState() {
//     super.initState();
//     _eventFuture = _loadEvent();
//     _ticketsFuture = _loadTickets();
//   }

//   Future<Session?> _loadEvent() async {
//     try {
//       return await SessionAPI.getSessionById(widget.sessionId);
//     } catch (e) {
//       print('Error al cargar el evento: $e');
//       return null;
//     }
//   }

//   Future<void> _refreshTickets() async {
//     setState(() {
//       _ticketsFuture = _loadTickets();
//     });
//   }

//   Future<List<Ticket>> _loadTickets() async {
//     final session = await _eventFuture;
//     if (session != null) {
//       try {
//         return await TicketAPI.getTicketsByEvent(session.title);
//       } catch (e) {
//         print('Error al cargar tickets: $e');
//         return [];
//       }
//     } else {
//       return [];
//     }
//   }

//   Future<void> _finalizeSession() async {
//     final session = await _eventFuture;
//     if (session != null) {
//       try {
//         await TicketAPI.deleteTicketsByEvent(session.title);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('La sesión ha sido finalizada.')),
//         );
//       } catch (e) {
//         print('Error al finalizar la sesión: $e');
//       }
//     }
//   }

//   Future<void> _emptyAforo() async {
//     final session = await _eventFuture;
//     if (session != null) {
//       try {
//         await TicketAPI.deleteTicketsByEvent(session.title);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('El aforo ha sido vaciado.')),
//         );
//       } catch (e) {
//         print('Error al vaciar el aforo: $e');
//       }
//     }
//   }

//   void _showFinalizeConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: const Text('Finalizar sesión'),
//           content: const Text(
//               '¿Estás seguro de que deseas finalizar la sesión? Esto enviará los datos al servidor y eliminará todas las entradas del dispositivo.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancelar'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Aceptar'),
//               onPressed: () async {
//                 Navigator.of(context).pop();
//                 await _finalizeSession();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showEmptyAforoConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           title: const Text('Vaciar Aforo'),
//           content: const Text(
//               '¿Estás seguro de que deseas vaciar el aforo? Esto eliminará todas las entradas validadas para esta sesión.'),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancelar'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: const Text('Aceptar'),
//               onPressed: () async {
//                 Navigator.of(context).pop();
//                 await _emptyAforo();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: true,
//         title: FutureBuilder<Session?>(
//           future: _eventFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return const Text('Error');
//             } else if (snapshot.hasData && snapshot.data != null) {
//               return Text(snapshot.data!.title);
//             } else {
//               return const Text('Evento no encontrado');
//             }
//           },
//         ),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black,
//       ),
//       body: Stack(
//         children: [
//           FutureBuilder<Session?>(
//             future: _eventFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(
//                     child:
//                         Text('Error al cargar el evento: ${snapshot.error}'));
//               } else if (snapshot.hasData && snapshot.data != null) {
//                 final session = snapshot.data!;
//                 return SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 12.0),
//                           child: ListTile(
//                             contentPadding:
//                                 EdgeInsets.symmetric(horizontal: 24.0),
//                             title: Text('Lista de entradas'),
//                             subtitle: Text(
//                                 'Revisa la lista de entradas totales a tu evento y edita los estados de las entradas de forma manual.'),
//                             trailing: Icon(Icons.people,
//                                 size: 32, color: Colors.black),
//                             onTap: () async {
//                               try {
//                                 final tickets =
//                                     await TicketAPI.getTicketsByEvent(
//                                         session.title);
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => TicketsListScreen(
//                                       event: session,
//                                       tickets: tickets,
//                                     ),
//                                   ),
//                                 );
//                               } catch (e) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                         content: Text(
//                                             'Error al cargar los tickets: $e')));
//                               }
//                             },
//                           ),
//                         ),
//                         Divider(),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 12.0),
//                           child: ListTile(
//                             contentPadding:
//                                 EdgeInsets.symmetric(horizontal: 24.0),
//                             title: Text('Configuración de entradas'),
//                             subtitle: Text(
//                                 'Edita qué entradas quieres que se sincronicen con el escáner para esta sesión.'),
//                             trailing: Icon(Icons.settings,
//                                 size: 32, color: Colors.black),
//                             onTap: () async {
//                               try {
//                                 final ticketTypes =
//                                     await TicketsAPI.getTicketTypes();
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         TicketConfigurationScreen(
//                                       event: session,
//                                       ticketTypes: ticketTypes,
//                                     ),
//                                   ),
//                                 );
//                               } catch (e) {
//                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                     content: Text(
//                                         'Error al cargar los tipos de entradas: $e')));
//                               }
//                             },
//                           ),
//                         ),
//                         Divider(),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 12.0),
//                           child: ListTile(
//                             contentPadding:
//                                 EdgeInsets.symmetric(horizontal: 24.0),
//                             title: Text('Estadísticas de aforo'),
//                             subtitle: Text(
//                                 'Accede a la información detallada y actualizada de los asistentes a esta sesión.'),
//                             trailing: Icon(Icons.show_chart,
//                                 size: 32, color: Colors.black),
//                             onTap: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) =>
//                                       StatisticsScreen(event: session.title),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         Divider(),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 12.0),
//                           child: ListTile(
//                             contentPadding:
//                                 EdgeInsets.symmetric(horizontal: 24.0),
//                             title: Text('Finalizar sesión'),
//                             subtitle: Text(
//                                 'Subir la información al servidor y borrar todas las entradas descargadas en el dispositivo.'),
//                             trailing: Icon(Icons.exit_to_app,
//                                 size: 32, color: Colors.black),
//                             onTap: _showFinalizeConfirmationDialog,
//                           ),
//                         ),
//                         Divider(),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 12.0),
//                           child: ListTile(
//                             contentPadding:
//                                 EdgeInsets.symmetric(horizontal: 24.0),
//                             title: Text('Vaciar Aforo'),
//                             subtitle: Text(
//                                 'Reiniciar la lista de entradas validadas para esta sesión'),
//                             trailing: Icon(Icons.restore,
//                                 size: 32, color: Colors.black),
//                             onTap: _showEmptyAforoConfirmationDialog,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               } else {
//                 return Center(child: Text('Evento no encontrado'));
//               }
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 120, vertical: 20),
//                   backgroundColor: const Color(0xFFCC3364),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => ScannerPage(),
//                     ),
//                   );
//                 },
//                 child: const Text('ESCANEAR ENTRADAS',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 13,
//                       fontWeight: FontWeight.w700,
//                     )),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
