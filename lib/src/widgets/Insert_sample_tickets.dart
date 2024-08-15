import 'package:woutickpass/models/objects/ticket.dart';
import 'package:woutickpass/services/dao/ticket_dao.dart';

Future<void> insertSampleTickets() async {
  final ticketDAO = TicketDAO.instance;

  // Crear tickets de ejemplo
  Ticket ticket1 = Ticket(
    refererUserFullName: "John Doe",
    question3Answer: "Answer 3",
    question3Text: "Question 3",
    question2Answer: "Answer 2",
    question2Text: "Question 2",
    question1Answer: "Answer 1",
    question1Text: "Question 1",
    gender: "Male",
    phone: "1234567890",
    postalCode: "12345",
    dni: "DNI123456",
    total: 100,
    type: "VIP",
    ticketCode: "VIP123456",
    event: "Event A",
    session: "Session 1",
    uuid: "uuid1",
    name: "VIP Ticket 1",
    status: "Usada",
    email: "john.doe@example.com",
  );

  Ticket ticket2 = Ticket(
    refererUserFullName: "Jane Smith",
    question3Answer: "Answer 3",
    question3Text: "Question 3",
    question2Answer: "Answer 2",
    question2Text: "Question 2",
    question1Answer: "Answer 1",
    question1Text: "Question 1",
    gender: "Female",
    phone: "0987654321",
    postalCode: "54321",
    dni: "DNI654321",
    total: 150,
    type: "Standard",
    ticketCode: "STD654321",
    event: "Event B",
    session: "Session 2",
    uuid: "uuid2",
    name: "Standard Ticket 1",
    status: "Disponible",
    email: "jane.smith@example.com",
  );

  // Insertar los tickets en la base de datos
  await ticketDAO.insert(ticket1);
  await ticketDAO.insert(ticket2);
}
