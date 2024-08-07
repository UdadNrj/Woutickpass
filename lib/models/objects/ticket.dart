import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  String uuid;
  String session;
  String event;
  String status;
  String ticketCode;
  String type;
  int total;
  DateTime? paymentAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? accessedAt;
  DateTime? checkinAt;
  DateTime? lastEntryAt;
  DateTime? lastExitAt;
  String name;
  String dni;
  DateTime? birthdate;
  String postalCode;
  String email;
  String phone;
  String gender;
  String question1Text;
  String question1Answer;
  String question2Text;
  String question2Answer;
  String question3Text;
  String question3Answer;
  String refererUserFullName;
  DateTime? bannedAt;

  Ticket({
    required this.uuid,
    required this.session,
    required this.event,
    required this.status,
    required this.ticketCode,
    required this.type,
    required this.total,
    this.paymentAt,
    this.createdAt,
    this.updatedAt,
    this.accessedAt,
    this.checkinAt,
    this.lastEntryAt,
    this.lastExitAt,
    required this.name,
    required this.dni,
    this.birthdate,
    required this.postalCode,
    required this.email,
    required this.phone,
    required this.gender,
    required this.question1Text,
    required this.question1Answer,
    required this.question2Text,
    required this.question2Answer,
    required this.question3Text,
    required this.question3Answer,
    required this.refererUserFullName,
    this.bannedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
  Map<String, dynamic> toJson() => _$TicketToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'session': session,
      'event': event,
      'status': status,
      'ticket_code': ticketCode,
      'type': type,
      'total': total,
      'payment_at': paymentAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'accessed_at': accessedAt?.toIso8601String(),
      'checkin_at': checkinAt?.toIso8601String(),
      'last_entry_at': lastEntryAt?.toIso8601String(),
      'last_exit_at': lastExitAt?.toIso8601String(),
      'name': name,
      'dni': dni,
      'birthdate': birthdate?.toIso8601String(),
      'postal_code': postalCode,
      'email': email,
      'phone': phone,
      'gender': gender,
      'question1_text': question1Text,
      'question1_answer': question1Answer,
      'question2_text': question2Text,
      'question2_answer': question2Answer,
      'question3_text': question3Text,
      'question3_answer': question3Answer,
      'referer_user_full_name': refererUserFullName,
      'banned_at': bannedAt?.toIso8601String(),
    };
  }

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      uuid: map['uuid'] ?? 'Desconocido',
      session: map['session'] ?? 'Desconocido',
      event: map['event'] ?? 'Desconocido',
      status: map['status'] ?? 'Desconocido',
      ticketCode: map['ticket_code'] ?? 'Desconocido',
      type: map['type'] ?? 'Desconocido',
      total: map['total'] ?? 0,
      paymentAt:
          map['payment_at'] != null ? DateTime.parse(map['payment_at']) : null,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      updatedAt:
          map['updated_at'] != null ? DateTime.parse(map['updated_at']) : null,
      accessedAt: map['accessed_at'] != null
          ? DateTime.parse(map['accessed_at'])
          : null,
      checkinAt:
          map['checkin_at'] != null ? DateTime.parse(map['checkin_at']) : null,
      lastEntryAt: map['last_entry_at'] != null
          ? DateTime.parse(map['last_entry_at'])
          : null,
      lastExitAt: map['last_exit_at'] != null
          ? DateTime.parse(map['last_exit_at'])
          : null,
      name: map['name'] ?? 'Nombre no disponible',
      dni: map['dni'] ?? 'Desconocido',
      birthdate:
          map['birthdate'] != null ? DateTime.parse(map['birthdate']) : null,
      postalCode: map['postal_code'] ?? 'Desconocido',
      email: map['email'] ?? 'Desconocido',
      phone: map['phone'] ?? 'Desconocido',
      gender: map['gender'] ?? 'Desconocido',
      question1Text: map['question1_text'] ?? 'Desconocido',
      question1Answer: map['question1_answer'] ?? 'Desconocido',
      question2Text: map['question2_text'] ?? 'Desconocido',
      question2Answer: map['question2_answer'] ?? 'Desconocido',
      question3Text: map['question3_text'] ?? 'Desconocido',
      question3Answer: map['question3_answer'] ?? 'Desconocido',
      refererUserFullName: map['referer_user_full_name'] ?? 'Desconocido',
      bannedAt:
          map['banned_at'] != null ? DateTime.parse(map['banned_at']) : null,
    );
  }
}

void main() {
  // Supongamos que obtenemos la lista de tickets de alguna API
  List<Ticket> tickets = [
    Ticket(
      uuid: '1',
      session: 'S1',
      event: 'E1',
      status: 'active',
      ticketCode: 'T1',
      type: 'VIP',
      total: 100,
      name: 'John Doe',
      dni: '123456789',
      postalCode: '12345',
      email: 'john@example.com',
      phone: '1234567890',
      gender: 'M',
      question1Text: 'Q1',
      question1Answer: 'A1',
      question2Text: 'Q2',
      question2Answer: 'A2',
      question3Text: 'Q3',
      question3Answer: 'A3',
      refererUserFullName: 'Referrer',
    ),
    Ticket(
      uuid: '2',
      session: 'S2',
      event: 'E2',
      status: 'inactive',
      ticketCode: 'T2',
      type: 'Regular',
      total: 50,
      name: '',
      dni: '987654321',
      postalCode: '54321',
      email: 'jane@example.com',
      phone: '0987654321',
      gender: 'F',
      question1Text: 'Q1',
      question1Answer: 'A1',
      question2Text: 'Q2',
      question2Answer: 'A2',
      question3Text: 'Q3',
      question3Answer: 'A3',
      refererUserFullName: 'Referrer',
    ),
  ];

  // Filtrando los nombres vacíos
  List<String> names = tickets
      .map((ticket) =>
          ticket.name.isNotEmpty ? ticket.name : 'Nombre no disponible')
      .toList();

  print(names); // Imprime: [John Doe, Nombre no disponible]
}
