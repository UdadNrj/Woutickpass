// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      uuid: json['uuid'] as String,
      session: json['session'] as String,
      event: json['event'] as String,
      status: json['status'] as String,
      ticketCode: json['ticket_code'] as String,
      ticketName: json['ticketName'] as String,
      type: json['type'] as String,
      pricePublic: (json['pricePublic'] as num).toInt(),
      commissionPublic: (json['commissionPublic'] as num).toInt(),
      paymentAt: json['payment_at'] == null
          ? null
          : DateTime.parse(json['payment_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      accessedAt: json['accessed_at'] == null
          ? null
          : DateTime.parse(json['accessed_at'] as String),
      checkinAt: json['checkin_at'] == null
          ? null
          : DateTime.parse(json['checkin_at'] as String),
      lastEntryAt: json['last_entry_at'] == null
          ? null
          : DateTime.parse(json['last_entry_at'] as String),
      lastExitAt: json['last_exit_at'] == null
          ? null
          : DateTime.parse(json['last_exit_at'] as String),
      name: json['name'] as String,
      dni: json['dni'] as String,
      birthdate: json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      postalCode: json['postal_code'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      gender: json['gender'] as String,
      question1Text: json['question1_text'] as String,
      question1Answer: json['question1_answer'] as String,
      question2Text: json['question2_text'] as String,
      question2Answer: json['question2_answer'] as String,
      question3Text: json['question3_text'] as String,
      question3Answer: json['question3_answer'] as String,
      refererUserFullName: json['referer_user_full_name'] as String,
      bannedAt: json['banned_at'] == null
          ? null
          : DateTime.parse(json['banned_at'] as String),
      refundAt: json['refund_at'] == null
          ? null
          : DateTime.parse(json['refund_at'] as String),
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'session': instance.session,
      'event': instance.event,
      'status': instance.status,
      'ticket_code': instance.ticketCode,
      'ticketName': instance.ticketName,
      'type': instance.type,
      'pricePublic': instance.pricePublic,
      'commissionPublic': instance.commissionPublic,
      'payment_at': instance.paymentAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'accessed_at': instance.accessedAt?.toIso8601String(),
      'checkin_at': instance.checkinAt?.toIso8601String(),
      'last_entry_at': instance.lastEntryAt?.toIso8601String(),
      'last_exit_at': instance.lastExitAt?.toIso8601String(),
      'name': instance.name,
      'dni': instance.dni,
      'birthdate': instance.birthdate?.toIso8601String(),
      'postal_code': instance.postalCode,
      'email': instance.email,
      'phone': instance.phone,
      'gender': instance.gender,
      'question1_text': instance.question1Text,
      'question1_answer': instance.question1Answer,
      'question2_text': instance.question2Text,
      'question2_answer': instance.question2Answer,
      'question3_text': instance.question3Text,
      'question3_answer': instance.question3Answer,
      'referer_user_full_name': instance.refererUserFullName,
      'banned_at': instance.bannedAt?.toIso8601String(),
      'refund_at': instance.refundAt?.toIso8601String(),
    };
