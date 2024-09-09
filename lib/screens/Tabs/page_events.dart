import 'package:flutter/material.dart';
import 'package:woutickpass/models/drawers/drawer_code_event.dart';
import 'package:woutickpass/models/objects/ticket_details.dart';
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
  Map<String, List<TicketDetails>> cachedTickets =
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
      _showErrorSnackBar('Error loading events: ${e.toString()}');
    }
  }

  Future<void> _handleTickets(String sessionId,
      {bool forceRefresh = false}) async {
    if (loadingStatus[sessionId] == true) return;

    setState(() {
      loadingStatus[sessionId] = true;
    });

    try {
      if (!forceRefresh) {
        if (await _useCachedOrLocalTickets(sessionId)) return;
      }

      await _downloadAndStoreTickets(sessionId);
    } catch (e) {
      debugPrint('Error handling tickets for session $sessionId: $e');
      _showErrorSnackBar('Error handling tickets: ${e.toString()}');
    } finally {
      setState(() {
        loadingStatus[sessionId] = false;
      });
    }
  }

  Future<bool> _useCachedOrLocalTickets(String sessionId) async {
    if (cachedTickets.containsKey(sessionId)) {
      debugPrint('Using cached tickets for session $sessionId');
      setState(() {});
      return true;
    }

    List<TicketDetails> localTickets =
        await TicketDAO.instance.getTicketsBySessionId(sessionId);

    if (localTickets.isNotEmpty) {
      debugPrint('Tickets already stored for session $sessionId');
      cachedTickets[sessionId] = localTickets;

      _showSnackBar('Tickets already stored for session $sessionId.');

      setState(() {});
      return true;
    }

    return false;
  }

  Future<void> _downloadAndStoreTickets(String sessionId) async {
    try {
      final List<dynamic> ticketsJsonList =
          await TicketsAPI.getTicketsBySessionUuid(sessionId);

      if (ticketsJsonList.isNotEmpty) {
        List<TicketDetails> tickets = ticketsJsonList
            .map((json) => json is TicketDetails
                ? json
                : TicketDetails.fromJson(json as Map<String, dynamic>))
            .toList();

        for (var ticket in tickets) {
          await TicketDAO.instance.insert(ticket);
        }

        cachedTickets[sessionId] = tickets;

        debugPrint('Tickets downloaded and stored for session $sessionId');
        _showSnackBar('Tickets downloaded and stored for session $sessionId.');

        setState(() {});
      } else {
        throw Exception('No tickets found.');
      }
    } catch (e) {
      debugPrint('Error downloading tickets for session $sessionId: $e');
      _showErrorSnackBar('Error downloading tickets: ${e.toString()}');
    }
  }

  void _openIconButtonPressed(BuildContext context, String parameter) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: DrawerCodeEvent(someParameter: parameter),
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
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

                List<TicketDetails> tickets = cachedTickets[event.uuid] ?? [];

                return GestureDetector(
                  onTap: isLoading
                      ? null
                      : () async {
                          await _handleTickets(event.uuid);
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
                                '${event.publicStartAt.toString()} - Ubicación',
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
