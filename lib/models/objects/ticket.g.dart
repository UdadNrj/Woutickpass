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
      ticketCode: json['ticketCode'] as String,
      type: json['type'] as String,
      total: (json['total'] as num).toInt(),
      paymentAt: json['paymentAt'] == null
          ? null
          : DateTime.parse(json['paymentAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      accessedAt: json['accessedAt'] == null
          ? null
          : DateTime.parse(json['accessedAt'] as String),
      checkinAt: json['checkinAt'] == null
          ? null
          : DateTime.parse(json['checkinAt'] as String),
      lastEntryAt: json['lastEntryAt'] == null
          ? null
          : DateTime.parse(json['lastEntryAt'] as String),
      lastExitAt: json['lastExitAt'] == null
          ? null
          : DateTime.parse(json['lastExitAt'] as String),
      name: json['name'] as String,
      dni: json['dni'] as String,
      birthdate: json['birthdate'] == null
          ? null
          : DateTime.parse(json['birthdate'] as String),
      postalCode: json['postalCode'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      gender: json['gender'] as String,
      question1Text: json['question1Text'] as String,
      question1Answer: json['question1Answer'] as String,
      question2Text: json['question2Text'] as String,
      question2Answer: json['question2Answer'] as String,
      question3Text: json['question3Text'] as String,
      question3Answer: json['question3Answer'] as String,
      refererUserFullName: json['refererUserFullName'] as String,
      bannedAt: json['bannedAt'] == null
          ? null
          : DateTime.parse(json['bannedAt'] as String),
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'session': instance.session,
      'event': instance.event,
      'status': instance.status,
      'ticketCode': instance.ticketCode,
      'type': instance.type,
      'total': instance.total,
      'paymentAt': instance.paymentAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'accessedAt': instance.accessedAt?.toIso8601String(),
      'checkinAt': instance.checkinAt?.toIso8601String(),
      'lastEntryAt': instance.lastEntryAt?.toIso8601String(),
      'lastExitAt': instance.lastExitAt?.toIso8601String(),
      'name': instance.name,
      'dni': instance.dni,
      'birthdate': instance.birthdate?.toIso8601String(),
      'postalCode': instance.postalCode,
      'email': instance.email,
      'phone': instance.phone,
      'gender': instance.gender,
      'question1Text': instance.question1Text,
      'question1Answer': instance.question1Answer,
      'question2Text': instance.question2Text,
      'question2Answer': instance.question2Answer,
      'question3Text': instance.question3Text,
      'question3Answer': instance.question3Answer,
      'refererUserFullName': instance.refererUserFullName,
      'bannedAt': instance.bannedAt?.toIso8601String(),
    };
