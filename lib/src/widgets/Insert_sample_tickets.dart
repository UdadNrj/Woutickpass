import 'package:woutickpass/models/objects/ticket_details.dart';
import 'package:woutickpass/services/dao/ticket_dao.dart';

Future<void> insertSampleTickets() async {
  final ticketDAO = TicketDAO.instance;

  TicketDetails ticket = TicketDetails(
    uuid: "unique-uuid",
    sessionUuid:
        "4bbaa50e-ec47-45cd-ab34-413c4baa60a6", // Asegúrate de que este sea el valor correcto
    event: "Event A",
    status: "Usada",
    ticketCode: "VIP123456",
    ticketName: "VIP Ticket",
    type: "VIP",
    pricePublic: 100,
    commissionPublic: 0,
    name: "John Doe",
    dni: "DNI123456",
    postalCode: "12345",
    email: "john.doe@example.com",
    phone: "1234567890",
    gender: "Male",
    question1Text: "Question 1",
    question1Answer: "Answer 1",
    question2Text: "Question 2",
    question2Answer: "Answer 2",
    question3Text: "Question 3",
    question3Answer: "Answer 3",
    refererUserFullName: "John Doe",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  await ticketDAO.insert(ticket);

  // Verifica si el ticket ha sido insertado correctamente
  await ticketDAO.printAllTickets();
}
