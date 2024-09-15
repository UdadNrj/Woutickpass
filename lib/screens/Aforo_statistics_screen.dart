import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/ticket_details.dart';
import 'package:woutickpass/models/objects/comercials.dart';
import 'package:woutickpass/services/dao/ticket_dao.dart';
import 'package:woutickpass/services/dao/comercial_dao.dart';

class AforoStatisticsScreen extends StatefulWidget {
  final String sessionId;

  const AforoStatisticsScreen({Key? key, required this.sessionId})
      : super(key: key);

  @override
  _AforoStatisticsScreenState createState() => _AforoStatisticsScreenState();
}

class _AforoStatisticsScreenState extends State<AforoStatisticsScreen> {
  late Future<List<TicketDetails>> _ticketsFuture;
  late Future<List<Commercial>> _commercialsFuture;

  @override
  void initState() {
    super.initState();
    _ticketsFuture = TicketDAO.instance.getTicketsBySessionId(widget.sessionId);
    _commercialsFuture =
        CommercialsDAO().getCommercialsBySession(widget.sessionId);

    // Debugging
    _ticketsFuture.then((tickets) {
      print("Tickets obtenidos: ${tickets.length}");
    }).catchError((error) {
      print("Error al obtener tickets: $error");
    });

    _commercialsFuture.then((commercials) {
      print("Comerciales obtenidos: ${commercials.length}");
    }).catchError((error) {
      print("Error al obtener comerciales: $error");
    });
  }

  Map<String, int> _calculateTicketStatistics(List<TicketDetails> tickets) {
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

  Map<String, int> _calculateCommercialStatistics(
      List<Commercial> commercials) {
    Map<String, int> commercialStats = {};

    for (var commercial in commercials) {
      if (!commercialStats.containsKey(commercial.name)) {
        commercialStats[commercial.name] = 0;
      }
      commercialStats[commercial.name] = commercialStats[commercial.name]! + 1;
    }

    return commercialStats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Aforo y Comerciales'),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<List<TicketDetails>>(
        future: _ticketsFuture,
        builder: (context, ticketSnapshot) {
          return FutureBuilder<List<Commercial>>(
            future: _commercialsFuture,
            builder: (context, commercialSnapshot) {
              if (ticketSnapshot.connectionState == ConnectionState.waiting ||
                  commercialSnapshot.connectionState ==
                      ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (ticketSnapshot.hasError ||
                  commercialSnapshot.hasError) {
                return Center(
                    child: Text(
                        'Error: ${ticketSnapshot.error ?? commercialSnapshot.error}'));
              } else if (!ticketSnapshot.hasData ||
                  ticketSnapshot.data!.isEmpty) {
                print("No hay datos de tickets");
                return Center(child: Text('No hay entradas disponibles.'));
              } else if (!commercialSnapshot.hasData ||
                  commercialSnapshot.data!.isEmpty) {
                print("No hay datos de comerciales");
                return Center(child: Text('No hay comerciales disponibles.'));
              } else {
                final tickets = ticketSnapshot.data!;
                final commercials = commercialSnapshot.data!;

                print(
                    "Mostrando ${tickets.length} tickets y ${commercials.length} comerciales");

                final ticketStatistics = _calculateTicketStatistics(tickets);
                final commercialStatistics =
                    _calculateCommercialStatistics(commercials);

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sección de Aforo
                        _buildSectionTitle('Estadísticas de Aforo'),
                        _buildTicketStatistics(ticketStatistics, tickets),
                        SizedBox(height: 16),

                        // Sección de Comerciales
                        _buildSectionTitle('Estadísticas de Comerciales'),
                        _buildCommercialStatistics(commercialStatistics),
                      ],
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  // Construir la sección de estadísticas de tickets
  Widget _buildTicketStatistics(
      Map<String, int> ticketStatistics, List<TicketDetails> tickets) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Aforo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Sin leer: ${ticketStatistics['sinLeer']}'),
            Text('Dentro: ${ticketStatistics['dentro']}'),
            Text('Fuera: ${ticketStatistics['fuera']}'),
            Divider(),
            Text('Tipos de entrada',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ...ticketStatistics.entries
                .where((entry) =>
                    entry.key != 'sinLeer' &&
                    entry.key != 'dentro' &&
                    entry.key != 'fuera')
                .map((entry) {
              return Text('${entry.key}: ${entry.value}/${tickets.length}');
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Construir la sección de estadísticas de comerciales
  Widget _buildCommercialStatistics(Map<String, int> commercialStatistics) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Comerciales',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ...commercialStatistics.entries.map((entry) {
              return Text('${entry.key}: ${entry.value}');
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Método para construir el título de las secciones
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
