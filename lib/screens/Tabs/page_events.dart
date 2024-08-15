import 'package:flutter/material.dart';
import 'package:woutickpass/models/drawers/drawer_code_event.dart';
import 'package:woutickpass/models/objects/ticket.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/screens/Sessions_details_screnn.dart';
import 'package:woutickpass/services/api/tickets_api.dart';
import 'package:woutickpass/services/dao/ticket_dao.dart';

class PageEvents extends StatefulWidget {
  final List<Session> selectedEvents;

  const PageEvents({Key? key, required this.selectedEvents}) : super(key: key);

  @override
  _PageEventsState createState() => _PageEventsState();
}

class _PageEventsState extends State<PageEvents> {
  Map<String, bool> loadingStatus = {};
  Map<String, List<Ticket>> cachedTickets =
      {}; // Map para almacenar los tickets descargados

  @override
  void initState() {
    super.initState();
    _loadPageState();
  }

  Future<void> _loadPageState() async {
    await _loadSelectedEvents();
  }

  Future<void> _loadSelectedEvents() async {
    setState(() {
      loadingStatus.clear();
    });

    try {
      for (var session in widget.selectedEvents) {
        await _handleTickets(session.uuid);
      }
    } catch (e) {
      debugPrint('Error loading selected events: $e');
    }
  }

  Future<void> _handleTickets(String sessionId) async {
    setState(() {
      loadingStatus[sessionId] = true;
    });

    try {
      // Primero verifica si los tickets ya están en cache
      if (cachedTickets.containsKey(sessionId)) {
        debugPrint('Using cached tickets for session $sessionId');
        // Actualiza la interfaz con los tickets almacenados en caché
        setState(() {});
        return;
      }

      // Verifica si los tickets ya están almacenados en la base de datos local
      List<Ticket> localTickets =
          await TicketDAO.instance.getTicketsBySessionId(sessionId);

      if (localTickets.isNotEmpty) {
        // Si ya existen tickets en la base de datos, los usa y los almacena en cache
        debugPrint('Tickets already stored for session $sessionId');
        cachedTickets[sessionId] = localTickets;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tickets already stored for session $sessionId.'),
          ),
        );

        // Actualiza la interfaz con los tickets almacenados
        setState(() {});
      } else {
        // Si no existen, descarga los tickets desde la API
        await _downloadAndStoreTickets(sessionId);
      }
    } catch (e) {
      debugPrint('Error handling tickets for session $sessionId: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error handling tickets: ${e.toString()}'),
        ),
      );
    } finally {
      setState(() {
        loadingStatus[sessionId] = false;
      });
    }
  }

  Future<void> _downloadAndStoreTickets(String sessionId) async {
    try {
      // Obtén la lista de tickets desde la API
      final List<dynamic> ticketsJsonList =
          await TicketsAPI.getTicketsBySessionUuid(sessionId);

      if (ticketsJsonList.isNotEmpty) {
        List<Ticket> tickets = ticketsJsonList
            .map((json) {
              if (json is Ticket) {
                return json;
              } else if (json is Map<String, dynamic>) {
                return Ticket.fromJson(json);
              } else {
                return null;
              }
            })
            .whereType<Ticket>()
            .toList();

        // Almacena los tickets en la base de datos local
        for (var ticket in tickets) {
          await TicketDAO.instance.insert(ticket);
        }

        // Almacena los tickets en cache
        cachedTickets[sessionId] = tickets;

        debugPrint('Tickets downloaded and stored for session $sessionId');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Tickets downloaded and stored for session $sessionId.'),
          ),
        );

        // Actualiza la interfaz con los tickets recién descargados
        setState(() {});
      } else {
        throw Exception('No tickets found.');
      }
    } catch (e) {
      debugPrint('Error downloading tickets for session $sessionId: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading tickets: ${e.toString()}'),
        ),
      );
    }
  }

  void _openIconButtonPressed(BuildContext context, String parameter) {
    showModalBottomSheet(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DrawerCodeEvent(
            someParameter: parameter,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 50),
            child: ListView.builder(
              itemCount: widget.selectedEvents.length,
              itemBuilder: (context, index) {
                Session event = widget.selectedEvents[index];
                bool isLoading = loadingStatus[event.uuid] ?? false;

                // Obtén los tickets almacenados en caché para el evento actual
                List<Ticket> tickets = cachedTickets[event.uuid] ?? [];

                return GestureDetector(
                  onTap: isLoading
                      ? null
                      : () async {
                          setState(() {
                            loadingStatus[event.uuid] = true;
                          });

                          await _handleTickets(event.uuid);

                          setState(() {
                            loadingStatus[event.uuid] = false;
                          });
                        },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isLoading ? Colors.grey.shade300 : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${event.eventStartAt} - Ubicación',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              if (isLoading)
                                const Text(
                                  'Descargando entradas...',
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                )
                              else if (tickets.isNotEmpty)
                                const Text(
                                  'Entradas listas',
                                  style: TextStyle(
                                    color: Colors.green,
                                  ),
                                )
                              else
                                const Text(
                                  'No hay entradas disponibles',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (tickets.isNotEmpty && !isLoading)
                          IconButton(
                            icon: const Icon(Icons.arrow_forward_ios,
                                color: Colors.grey),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SessionDetailsPage(
                                    sessionId: event.uuid,
                                    sessionName: event.title,
                                  ),
                                ),
                              );
                            },
                          )
                        else if (isLoading)
                          const CircularProgressIndicator()
                        // Si no hay tickets y no está cargando, no se muestra ningún ícono adicional
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                  backgroundColor: const Color(0xFF202B37),
                ),
                onPressed: () =>
                    _openIconButtonPressed(context, "defaultParameter"),
                child: const Text(
                  "AGREGAR NUEVO EVENTO",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
