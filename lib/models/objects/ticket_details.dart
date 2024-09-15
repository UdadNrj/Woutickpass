class TicketDetails {
  final String uuid;
  final DateTime? paymentAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String sessionUuid;
  final String event;
  final String status;
  final String ticketCode;
  final String ticketName;
  final String type;
  final int pricePublic;
  final int commissionPublic;
  final DateTime? accessedAt;
  final DateTime? checkinAt;
  final DateTime? lastEntryAt;
  final DateTime? lastExitAt;
  final String name;
  final String dni;
  final DateTime? birthdate;
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
  final DateTime? bannedAt;
  final DateTime? refundAt;

  TicketDetails({
    required this.uuid,
    this.paymentAt,
    this.createdAt,
    this.updatedAt,
    required this.sessionUuid,
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

  // Método copyWith para crear una copia del objeto con campos modificados
  TicketDetails copyWith({
    String? uuid,
    DateTime? paymentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? sessionUuid,
    String? event,
    String? status,
    String? ticketCode,
    String? ticketName,
    String? type,
    int? pricePublic,
    int? commissionPublic,
    DateTime? accessedAt,
    DateTime? checkinAt,
    DateTime? lastEntryAt,
    DateTime? lastExitAt,
    String? name,
    String? dni,
    DateTime? birthdate,
    String? postalCode,
    String? email,
    String? phone,
    String? gender,
    String? question1Text,
    String? question1Answer,
    String? question2Text,
    String? question2Answer,
    String? question3Text,
    String? question3Answer,
    String? refererUserFullName,
    DateTime? bannedAt,
    DateTime? refundAt,
  }) {
    return TicketDetails(
      uuid: uuid ?? this.uuid,
      paymentAt: paymentAt ?? this.paymentAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      sessionUuid: sessionUuid ?? this.sessionUuid,
      event: event ?? this.event,
      status: status ?? this.status,
      ticketCode: ticketCode ?? this.ticketCode,
      ticketName: ticketName ?? this.ticketName,
      type: type ?? this.type,
      pricePublic: pricePublic ?? this.pricePublic,
      commissionPublic: commissionPublic ?? this.commissionPublic,
      accessedAt: accessedAt ?? this.accessedAt,
      checkinAt: checkinAt ?? this.checkinAt,
      lastEntryAt: lastEntryAt ?? this.lastEntryAt,
      lastExitAt: lastExitAt ?? this.lastExitAt,
      name: name ?? this.name,
      dni: dni ?? this.dni,
      birthdate: birthdate ?? this.birthdate,
      postalCode: postalCode ?? this.postalCode,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      gender: gender ?? this.gender,
      question1Text: question1Text ?? this.question1Text,
      question1Answer: question1Answer ?? this.question1Answer,
      question2Text: question2Text ?? this.question2Text,
      question2Answer: question2Answer ?? this.question2Answer,
      question3Text: question3Text ?? this.question3Text,
      question3Answer: question3Answer ?? this.question3Answer,
      refererUserFullName: refererUserFullName ?? this.refererUserFullName,
      bannedAt: bannedAt ?? this.bannedAt,
      refundAt: refundAt ?? this.refundAt,
    );
  }

  // Método fromJson para convertir JSON a TicketDetails
  factory TicketDetails.fromJson(Map<String, dynamic> json) {
    return TicketDetails(
      uuid: json['uuid'] ?? '',
      paymentAt: json['payment_at'] != null
          ? DateTime.tryParse(json['payment_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
      sessionUuid: json['session_uuid'] ?? '',
      event: json['event'] ?? '',
      status: json['status'] ?? '',
      ticketCode: json['ticket_code'] ?? '',
      ticketName: json['ticket_name'] ?? '',
      type: json['type'] ?? '',
      pricePublic: json['price_public'] ?? 0,
      commissionPublic: json['commission_public'] ?? 0,
      accessedAt: json['accessed_at'] != null
          ? DateTime.tryParse(json['accessed_at'])
          : null,
      checkinAt: json['checkin_at'] != null
          ? DateTime.tryParse(json['checkin_at'])
          : null,
      lastEntryAt: json['last_entry_at'] != null
          ? DateTime.tryParse(json['last_entry_at'])
          : null,
      lastExitAt: json['last_exit_at'] != null
          ? DateTime.tryParse(json['last_exit_at'])
          : null,
      name: json['name'] ?? '',
      dni: json['dni'] ?? '',
      birthdate: json['birthdate'] != null
          ? DateTime.tryParse(json['birthdate'])
          : null,
      postalCode: json['postal_code'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      question1Text: json['question1_text'] ?? '',
      question1Answer: json['question1_answer'] ?? '',
      question2Text: json['question2_text'] ?? '',
      question2Answer: json['question2_answer'] ?? '',
      question3Text: json['question3_text'] ?? '',
      question3Answer: json['question3_answer'] ?? '',
      refererUserFullName: json['referer_user_full_name'] ?? '',
      bannedAt: json['banned_at'] != null
          ? DateTime.tryParse(json['banned_at'])
          : null,
      refundAt: json['refund_at'] != null
          ? DateTime.tryParse(json['refund_at'])
          : null,
    );
  }

  // Método toJson para convertir TicketDetails a JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'payment_at': paymentAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'session_uuid': sessionUuid,
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

  // Método para crear una instancia de TicketDetails desde un Map (para DAO)
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

  // Conversión a Map para la base de datos
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'payment_at': paymentAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'session_uuid': sessionUuid,
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
}
