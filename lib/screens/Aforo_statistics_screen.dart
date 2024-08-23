import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/ticket.dart';
import 'package:woutickpass/services/dao/ticket_dao.dart';

class AforoStatisticsScreen extends StatefulWidget {
  final String sessionId;

  const AforoStatisticsScreen({Key? key, required this.sessionId})
      : super(key: key);

  @override
  _AforoStatisticsScreenState createState() => _AforoStatisticsScreenState();
}

class _AforoStatisticsScreenState extends State<AforoStatisticsScreen> {
  late Future<List<Ticket>> _ticketsFuture;

  @override
  void initState() {
    super.initState();
    _ticketsFuture = TicketDAO.instance.getTicketsBySessionId(widget.sessionId);
  }

  Map<String, int> _calculateStatistics(List<Ticket> tickets) {
    int sinLeer = 0;
    int dentro = 0;
    int fuera = 0;
    Map<String, int> tiposDeEntrada = {};

    for (var ticket in tickets) {
      switch (ticket.status) {
        case 'sin_leer':
          sinLeer++;
          break;
        case 'dentro':
          dentro++;
          break;
        case 'fuera':
          fuera++;
          break;
      }

      if (!tiposDeEntrada.containsKey(ticket.event)) {
        tiposDeEntrada[ticket.event] = 0;
      }
      tiposDeEntrada[ticket.event] = tiposDeEntrada[ticket.event]! + 1;
    }

    return {
      'sinLeer': sinLeer,
      'dentro': dentro,
      'fuera': fuera,
      ...tiposDeEntrada,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Aforo'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<List<Ticket>>(
        future: _ticketsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay entradas disponibles.'));
          } else {
            final tickets = snapshot.data!;
            final statistics = _calculateStatistics(tickets);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Título evento',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('01/10/2024 12:00h - Ubicación'),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Aforo',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('Sin leer: ${statistics['sinLeer']}'),
                        Text('Dentro: ${statistics['dentro']}'),
                        Text('Fuera: ${statistics['fuera']}'),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tipos de entrada',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        ...statistics.entries
                            .where((entry) =>
                                entry.key != 'sinLeer' &&
                                entry.key != 'dentro' &&
                                entry.key != 'fuera')
                            .map((entry) {
                          return Text(
                              '${entry.key}: ${entry.value}/${tickets.length}');
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
