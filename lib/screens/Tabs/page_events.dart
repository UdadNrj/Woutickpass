import 'package:flutter/material.dart';
import 'package:woutickpass/services/sessions_dao.dart';
import 'package:woutickpass/models/objects/session.dart';
import 'package:woutickpass/services/api/api_ticket.dart';
import 'package:woutickpass/models/drawers/drawer_code_event.dart';
import 'package:woutickpass/screens/Sessions_details_screnn.dart';

class PageEvents extends StatefulWidget {
  const PageEvents({Key? key}) : super(key: key);

  @override
  _PageEventsState createState() => _PageEventsState();
}

class _PageEventsState extends State<PageEvents> {
  List<Session> selectedEvents = [];
  Map<String, bool> loadingStatus = {};

  @override
  void initState() {
    super.initState();
    _loadSelectedEvents();
  }

  Future<void> _loadSelectedEvents() async {
    setState(() {
      loadingStatus.clear();
    });

    try {
      final sessions = await SessionsDao().getSelectedSessions();
      setState(() {
        selectedEvents = sessions;
      });

      for (var session in sessions) {
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
      await ApiTickets.getSessionsBYTickets(sessionId);
      debugPrint('Tickets downloaded and stored for session $sessionId');
    } catch (e) {
      debugPrint('Error downloading tickets for session $sessionId: $e');
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
              itemCount: selectedEvents.length,
              itemBuilder: (context, index) {
                Session event = selectedEvents[index];
                bool isLoading = loadingStatus[event.uuid] ?? true;

                return GestureDetector(
                  onTap: isLoading
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EventDetailsPage(event: event),
                            ),
                          );
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
                                '${event.startAt} - Ubicación',
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
