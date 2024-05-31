class Event {
  int code;
  String name;
  String venue;
  DateTime date;
  String session;
  List<Session> sessions;

  Event({
    required this.code,
    required this.name,
    required this.venue,
    required this.date,
    required this.session,
    required this.sessions,
  });
}

class Session {
  String title;
  DateTime date;
  String venue;

  Session({
    required this.title,
    required this.date,
    required this.venue,
  });
}

void main() {
  List<Event> events = [];

  for (int i = 1; i <= 10; i++) {
    List<Session> sessions = [];
    for (int j = 1; j <= 5; j++) {
      sessions.add(Session(
        title: "Session $j",
        date: DateTime.now(),
        venue: "Venue $j",
      ));
    }

    events.add(Event(
      code: i + 7,
      name: "Event $i",
      venue: "Venue $i",
      date: DateTime.now(),
      session: "Session for Event $i",
      sessions: sessions,
    ));
  }

  // Printing the events array
  events.forEach((event) {
    print("Event ${event.code}: ${event.name}");
    print("Venue: ${event.venue}");
    print("Date: ${event.date}");
    print("Session: ${event.session}");
    print("Sessions:");
    event.sessions.forEach((session) {
      print("- ${session.title}");
      print("  Date: ${session.date}");
      print("  Venue: ${session.venue}");
    });
    print("------------------------------");
  });
}
