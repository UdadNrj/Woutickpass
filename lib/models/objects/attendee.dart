import 'package:woutickpass/models/objects/ticket.dart';

class Attendee {
  final String name;
  final String ticketType;
  final String ticketCode;
  final String status;

  Attendee({
    required this.name,
    required this.ticketType,
    required this.ticketCode,
    required this.status,
  });
}

List<Attendee> convertTicketsToAttendees(List<Ticket> tickets) {
  return tickets.map((ticket) {
    return Attendee(
      name: ticket.name,
      ticketType: ticket.type,
      ticketCode: ticket.ticketCode,
      status: ticket.status,
    );
  }).toList();
}
