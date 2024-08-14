import 'package:flutter/material.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/models/objects/ticket.dart';
import 'package:woutickpass/screens/Attendee_list_screen.dart';
import 'package:woutickpass/services/api/tickets_api.dart';
import 'package:woutickpass/models/drawers/drawer_code_event.dart';

class PageEvents extends StatefulWidget {
  final List<Session> selectedEvents;

  const PageEvents({Key? key, required this.selectedEvents}) : super(key: key);

  @override
  _PageEventsState createState() => _PageEventsState();
}

class _PageEventsState extends State<PageEvents> {
  Map<String, bool> loadingStatus = {};

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
        await _downloadTickets(session.uuid);
      }
    } catch (e) {
      debugPrint('Error loading selected events: $e');
    }
  }

  Future<void> _downloadTickets(String sessionId) async {
    setState(() {
      loadingStatus[sessionId] = true;
    });

    try {
      // Obtén la lista de tickets desde la API
      final List<dynamic> ticketsJsonList =
          await TicketsAPI.getTicketsBySessionUuid(sessionId);

      // Asegúrate de que ticketsJsonList sea una lista de mapas o instancias de Ticket
      if (ticketsJsonList.isNotEmpty) {
        List<Ticket> tickets = ticketsJsonList
            .map((json) {
              // Verifica si json ya es una instancia de Ticket
              if (json is Ticket) {
                debugPrint('Ticket instance: $json');
                return json;
              }
              // Si es un Map<String, dynamic>, conviértelo en Ticket
              else if (json is Map<String, dynamic>) {
                debugPrint('Ticket JSON: $json');
                return Ticket.fromJson(json);
              }
              // Si no es ninguno de los dos, es un formato inesperado
              else {
                debugPrint('Invalid ticket JSON format: $json');
                return null; // Ignora elementos inválidos
              }
            })
            .whereType<Ticket>()
            .toList(); // Filtra los valores nulos

        debugPrint('Tickets downloaded for session $sessionId');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tickets downloaded for session $sessionId.'),
          ),
        );

        // Navega a la pantalla de AttendeesListScreen con la lista de tickets
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AttendeesListScreen(event: sessionId, tickets: tickets),
          ),
        );
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
    } finally {
      setState(() {
        loadingStatus[sessionId] = false;
      });
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

                return GestureDetector(
                  onTap: isLoading
                      ? null
                      : () async {
                          setState(() {
                            loadingStatus[event.uuid] = true;
                          });

                          await _downloadTickets(event.uuid);

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
                              isLoading
                                  ? const Text(
                                      'Descargando entradas...',
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    )
                                  : const Text(
                                      'Entradas descargadas',
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        isLoading
                            ? const CircularProgressIndicator()
                            : const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                              ),
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
