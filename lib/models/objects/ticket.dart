import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket {
  final String uuid;
  final DateTime paymentAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String session;
  final String event;
  final String status;
  final String ticketCode;
  final String type;
  final int total;
  final DateTime accessedAt;
  final DateTime checkinAt;
  final DateTime lastEntryAt;
  final DateTime lastExitAt;
  final String name;
  final String dni;
  final DateTime birthdate;
  final String postalCode;
  final String email;
  final String phone;
  final String gender;
  final String question1Text;
  final String question1Answer;
  final String question2Text;
  final String question2Answer;
  final String question3Text;
  final String question3Answer;
  final String refererUserFullName;
  final DateTime bannedAt;

  Ticket({
    required this.uuid,
    required this.paymentAt,
    required this.createdAt,
    required this.updatedAt,
    required this.session,
    required this.event,
    required this.status,
    required this.ticketCode,
    required this.type,
    required this.total,
    required this.accessedAt,
    required this.checkinAt,
    required this.lastEntryAt,
    required this.lastExitAt,
    required this.name,
    required this.dni,
    required this.birthdate,
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
    required this.bannedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);
  Map<String, dynamic> toJson() => _$TicketToJson(this);

  factory Ticket.fromMap(Map<String, dynamic> map) {
    return Ticket(
      uuid: map['uuid'] ?? '',
      paymentAt: DateTime.tryParse(map['payment_at'] ?? '') ?? DateTime.now(),
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
      session: map['session'] ?? '',
      event: map['event'] ?? '',
      status: map['status'] ?? '',
      ticketCode: map['ticket_code'] ?? '',
      type: map['type'] ?? '',
      total: map['total'] ?? 0,
      accessedAt: DateTime.tryParse(map['accessed_at'] ?? '') ?? DateTime.now(),
      checkinAt: DateTime.tryParse(map['checkin_at'] ?? '') ?? DateTime.now(),
      lastEntryAt:
          DateTime.tryParse(map['last_entry_at'] ?? '') ?? DateTime.now(),
      lastExitAt:
          DateTime.tryParse(map['last_exit_at'] ?? '') ?? DateTime.now(),
      name: map['name'] ?? '',
      dni: map['dni'] ?? '',
      birthdate: DateTime.tryParse(map['birthdate'] ?? '') ?? DateTime.now(),
      postalCode: map['postal_code'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      gender: map['gender'] ?? '',
      question1Text: map['question1_text'] ?? '',
      question1Answer: map['question1_answer'] ?? '',
      question2Text: map['question2_text'] ?? '',
      question2Answer: map['question2_answer'] ?? '',
      question3Text: map['question3_text'] ?? '',
      question3Answer: map['question3_answer'] ?? '',
      refererUserFullName: map['referer_user_full_name'] ?? '',
      bannedAt: DateTime.tryParse(map['banned_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'payment_at': paymentAt.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'session': session,
      'event': event,
      'status': status,
      'ticket_code': ticketCode,
      'type': type,
      'total': total,
      'accessed_at': accessedAt.toIso8601String(),
      'checkin_at': checkinAt.toIso8601String(),
      'last_entry_at': lastEntryAt.toIso8601String(),
      'last_exit_at': lastExitAt.toIso8601String(),
      'name': name,
      'dni': dni,
      'birthdate': birthdate.toIso8601String(),
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
      'banned_at': bannedAt.toIso8601String(),
    };
  }
}
