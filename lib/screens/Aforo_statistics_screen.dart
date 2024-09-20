import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session_details.dart';
import 'package:woutickpass/models/objects/ticket_details.dart';
import 'package:woutickpass/models/objects/comercials.dart';
import 'package:woutickpass/services/dao/sessions_dao.dart';
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
  late Future<SessionDetails?> _sessionDetailsFuture;

  @override
  void initState() {
    super.initState();
    _loadTicketsAndCommercials();
    _loadSessionDetails();
  }

  // Método para cargar los detalles de la sesión usando el SessionsDAO
  void _loadSessionDetails() {
    setState(() {
      _sessionDetailsFuture = SessionsDAO().getSessionById(widget.sessionId);
    });
  }

  // Método para cargar los tickets y comerciales
  void _loadTicketsAndCommercials() {
    setState(() {
      _ticketsFuture =
          TicketDAO.instance.getTicketsBySessionId(widget.sessionId);
      _commercialsFuture =
          CommercialsDAO().getCommercialsBySession(widget.sessionId);
    });
  }

  // Calcular estadísticas de tickets
  Map<String, int> _calculateTicketStatistics(List<TicketDetails> tickets) {
    int sinLeer = tickets
        .length; // Todos los tickets descargados inicialmente están "sin leer"
    int dentro = 0;
    int fuera = 0;
    Map<String, int> tiposDeEntrada = {};

    for (var ticket in tickets) {
      switch (ticket.status) {
        case 'dentro':
          dentro++;
          sinLeer--; // Si están "dentro", restamos de "sin leer"
          break;
        case 'fuera':
          fuera++;
          sinLeer--; // Si están "fuera", restamos de "sin leer"
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

  // Calcular estadísticas de comerciales
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
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _loadTicketsAndCommercials();
              _loadSessionDetails();
            }, // Botón de refresco manual
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tarjeta para mostrar los detalles de la sesión
              FutureBuilder<SessionDetails?>(
                future: _sessionDetailsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Error al cargar los detalles de la sesión: ${snapshot.error}'),
                          ElevatedButton(
                            onPressed: _loadSessionDetails, // Intentar recargar
                            child: Text('Reintentar'),
                          ),
                        ],
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return Center(
                        child:
                            Text('No hay detalles de la sesión disponibles.'));
                  }

                  final sessionDetails = snapshot.data!;
                  return _buildSessionDetailsCard(sessionDetails);
                },
              ),
              SizedBox(height: 16),

              // Tarjeta para mostrar las estadísticas de tickets
              FutureBuilder<List<TicketDetails>>(
                future: _ticketsFuture,
                builder: (context, ticketSnapshot) {
                  if (ticketSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (ticketSnapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Error al cargar entradas: ${ticketSnapshot.error}'),
                          ElevatedButton(
                            onPressed:
                                _loadTicketsAndCommercials, // Intentar recargar los datos
                            child: Text('Reintentar'),
                          ),
                        ],
                      ),
                    );
                  } else if (!ticketSnapshot.hasData ||
                      ticketSnapshot.data!.isEmpty) {
                    return Center(child: Text('No hay entradas disponibles.'));
                  }

                  // Datos de tickets disponibles
                  final tickets = ticketSnapshot.data!;
                  final ticketStatistics = _calculateTicketStatistics(tickets);

                  return _buildTicketStatistics(ticketStatistics, tickets);
                },
              ),
              SizedBox(height: 16),

              // Mostrar sección de comerciales independientemente de los tickets
              FutureBuilder<List<Commercial>>(
                future: _commercialsFuture,
                builder: (context, commercialSnapshot) {
                  if (commercialSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (commercialSnapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'Error al cargar comerciales: ${commercialSnapshot.error}'),
                          ElevatedButton(
                            onPressed:
                                _loadTicketsAndCommercials, // Intentar recargar comerciales
                            child: Text('Reintentar'),
                          ),
                        ],
                      ),
                    );
                  } else if (!commercialSnapshot.hasData ||
                      commercialSnapshot.data!.isEmpty) {
                    return Center(
                        child: Text('No hay comerciales disponibles.'));
                  }

                  final commercials = commercialSnapshot.data!;
                  final commercialStatistics =
                      _calculateCommercialStatistics(commercials);
                  return _buildCommercialStatistics(commercialStatistics);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

// Método para construir la tarjeta con los detalles completos de la sesión
  Widget _buildSessionDetailsCard(SessionDetails sessionDetails) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Detalles completos del evento',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),

          // Título del evento
          Text(
            'Título del evento: ${sessionDetails.title}',
            style: TextStyle(fontSize: 16),
          ),

          // Subtítulo del evento
          if (sessionDetails
              .subtitle.isNotEmpty) // Mostrar solo si hay subtítulo
            Text(
              'Subtítulo: ${sessionDetails.subtitle}',
              style: TextStyle(fontSize: 16),
            ),

          // Código opcional de wpass
          if (sessionDetails.wpassCode !=
              null) // Mostrar solo si existe wpassCode
            Text(
              'Código WPass: ${sessionDetails.wpassCode}',
              style: TextStyle(fontSize: 16),
            ),

          SizedBox(height: 16),

          // Lista de tickets asociados sin mostrar el estado
        ]),
      ),
    );
  }

  // Construir la sección de estadísticas de tickets
  Widget _buildTicketStatistics(
      Map<String, int> ticketStatistics, List<TicketDetails> tickets) {
    return Card(
      color: Colors.white,
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
            Text('Sin leer: ${ticketStatistics['sinLeer'] ?? 0}'),
            Text('Dentro: ${ticketStatistics['dentro'] ?? 0}'),
            Text('Fuera: ${ticketStatistics['fuera'] ?? 0}'),
            Divider(),
            Text('Tipos de entrada',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            if (ticketStatistics.isNotEmpty)
              ...ticketStatistics.entries
                  .where((entry) =>
                      entry.key != 'sinLeer' &&
                      entry.key != 'dentro' &&
                      entry.key != 'fuera')
                  .map((entry) {
                return Text('${entry.key}: ${entry.value}/${tickets.length}');
              }).toList()
            else
              Text('No hay tipos de entrada disponibles'),
          ],
        ),
      ),
    );
  }

  // Construir la sección de estadísticas de comerciales
  Widget _buildCommercialStatistics(Map<String, int> commercialStatistics) {
    return Card(
      color: Colors.white,
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
            if (commercialStatistics.isNotEmpty)
              ...commercialStatistics.entries.map((entry) {
                return Text('${entry.key}: ${entry.value}');
              }).toList()
            else
              Text('No hay comerciales disponibles'),
          ],
        ),
      ),
    );
  }
}
