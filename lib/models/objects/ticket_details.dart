import 'package:json_annotation/json_annotation.dart';

// Genera el archivo 'ticket_details.g.dart' automáticamente
part 'ticket_details.g.dart';

@JsonSerializable()
class TicketDetails {
  final String uuid;
  @JsonKey(name: 'payment_at')
  final DateTime? paymentAt;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'session_uuid') // Cambiado de 'session' a 'session_uuid'
  final String sessionUuid; // Cambiado de 'session' a 'sessionUuid'
  final String event;
  final String status;
  @JsonKey(name: 'ticket_code')
  final String ticketCode;
  @JsonKey(name: 'ticket_name')
  final String ticketName;
  final String type;
  @JsonKey(name: 'price_public')
  final int pricePublic;
  @JsonKey(name: 'commission_public')
  final int commissionPublic;
  @JsonKey(name: 'accessed_at')
  final DateTime? accessedAt;
  @JsonKey(name: 'checkin_at')
  final DateTime? checkinAt;
  @JsonKey(name: 'last_entry_at')
  final DateTime? lastEntryAt;
  @JsonKey(name: 'last_exit_at')
  final DateTime? lastExitAt;
  final String name;
  final String dni;
  @JsonKey(name: 'birthdate')
  final DateTime? birthdate;
  @JsonKey(name: 'postal_code')
  final String postalCode;
  final String email;
  final String phone;
  final String gender;
  @JsonKey(name: 'question1_text')
  final String question1Text;
  @JsonKey(name: 'question1_answer')
  final String question1Answer;
  @JsonKey(name: 'question2_text')
  final String question2Text;
  @JsonKey(name: 'question2_answer')
  final String question2Answer;
  @JsonKey(name: 'question3_text')
  final String question3Text;
  @JsonKey(name: 'question3_answer')
  final String question3Answer;
  @JsonKey(name: 'referer_user_full_name')
  final String refererUserFullName;
  @JsonKey(name: 'banned_at')
  final DateTime? bannedAt;
  @JsonKey(name: 'refund_at')
  final DateTime? refundAt;

  TicketDetails({
    required this.uuid,
    this.paymentAt,
    this.createdAt,
    this.updatedAt,
    required this.sessionUuid, // Cambiado de 'session' a 'sessionUuid'
    required this.event,
    required this.status,
    required this.ticketCode,
    required this.ticketName,
    required this.type,
    required this.pricePublic,
    required this.commissionPublic,
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
    this.refundAt,
  });

  // Métodos para mapear a JSON y desde JSON
  factory TicketDetails.fromJson(Map<String, dynamic> json) =>
      _$TicketDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TicketDetailsToJson(this);

  // Métodos de conversión de Map a TicketDetails
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'payment_at': paymentAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'session_uuid': sessionUuid, // Asegurarse de usar 'session_uuid'
      'event': event,
      'status': status,
      'ticket_code': ticketCode,
      'ticket_name': ticketName,
      'type': type,
      'price_public': pricePublic,
      'commission_public': commissionPublic,
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
      'refund_at': refundAt?.toIso8601String(),
    };
  }

  factory TicketDetails.fromMap(Map<String, dynamic> map) {
    return TicketDetails(
      uuid: map['uuid'] ?? 'Desconocido',
      paymentAt: map['payment_at'] != null
          ? DateTime.tryParse(map['payment_at'])
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.tryParse(map['created_at'])
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.tryParse(map['updated_at'])
          : null,
      sessionUuid: map['session_uuid'] ?? 'Desconocido',
      event: map['event'] ?? 'Desconocido',
      status: map['status'] ?? 'Desconocido',
      ticketCode: map['ticket_code'] ?? 'Desconocido',
      ticketName: map['ticket_name'] ?? 'Entrada',
      type: map['type'] ?? 'Desconocido',
      pricePublic: map['price_public'] ?? 0,
      commissionPublic: map['commission_public'] ?? 0,
      accessedAt: map['accessed_at'] != null
          ? DateTime.tryParse(map['accessed_at'])
          : null,
      checkinAt: map['checkin_at'] != null
          ? DateTime.tryParse(map['checkin_at'])
          : null,
      lastEntryAt: map['last_entry_at'] != null
          ? DateTime.tryParse(map['last_entry_at'])
          : null,
      lastExitAt: map['last_exit_at'] != null
          ? DateTime.tryParse(map['last_exit_at'])
          : null,
      name: map['name'] ?? 'Nombre no disponible',
      dni: map['dni'] ?? 'Desconocido',
      birthdate:
          map['birthdate'] != null ? DateTime.tryParse(map['birthdate']) : null,
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
          map['banned_at'] != null ? DateTime.tryParse(map['banned_at']) : null,
      refundAt:
          map['refund_at'] != null ? DateTime.tryParse(map['refund_at']) : null,
    );
  }
}
