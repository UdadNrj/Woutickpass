import 'package:woutickpass/models/objects/ticket.dart';
import 'package:woutickpass/services/dao/ticket_dao.dart';

Future<void> insertSampleTickets() async {
  final ticketDAO = TicketDAO.instance;

  // Crear tickets de ejemplo
  Ticket ticket1 = Ticket(
    uuid: "uuid1",
    session: "Session 1",
    event: "Event A",
    status: "Usada",
    ticketCode: "VIP123456",
    ticketName: "VIP Ticket 1", // Añadido campo ticketName
    type: "VIP",
    pricePublic: 100, // Ajustado
    commissionPublic: 0, // Agregar valor predeterminado para commission
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
    createdAt: DateTime.now(), // Puedes ajustar estas fechas si es necesario
    updatedAt: DateTime.now(),
  );

  Ticket ticket2 = Ticket(
    uuid: "uuid2",
    session: "Session 2",
    event: "Event B",
    status: "Disponible",
    ticketCode: "STD654321",
    ticketName: "Standard Ticket 1", // Añadido campo ticketName
    type: "Standard",
    pricePublic: 150, // Ajustado
    commissionPublic: 0, // Agregar valor predeterminado para commission
    name: "Jane Smith",
    dni: "DNI654321",
    postalCode: "54321",
    email: "jane.smith@example.com",
    phone: "0987654321",
    gender: "Female",
    question1Text: "Question 1",
    question1Answer: "Answer 1",
    question2Text: "Question 2",
    question2Answer: "Answer 2",
    question3Text: "Question 3",
    question3Answer: "Answer 3",
    refererUserFullName: "Jane Smith",
    createdAt: DateTime.now(), // Puedes ajustar estas fechas si es necesario
    updatedAt: DateTime.now(),
  );

  // Insertar los tickets en la base de datos
  await ticketDAO.insert(ticket1);
  await ticketDAO.insert(ticket2);
}
