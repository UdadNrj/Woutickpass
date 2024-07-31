import 'package:flutter/foundation.dart';
import 'package:woutickpass/models/objects/session_details.dart';

@immutable
class Session {
  final String uuid; // Identificador único del evento
  final String title; // Nombre del evento
  final String subtitle; // Subtitulo del evento
  final String? wpassCode; // Código de pase del evento
  final String eventStartAt; // Fecha de inicio del evento como cadena
  final DateTime startAt; // Fecha de inicio del evento como DateTime

  const Session({
    required this.uuid,
    required this.title,
    required this.subtitle,
    required this.wpassCode,
    required this.eventStartAt,
    required this.startAt,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      uuid: json['uuid'],
      title: json['title'],
      subtitle: json['subtitle'],
      wpassCode: json['wpass_code'],
      eventStartAt: json['event_start_at'],
      startAt: DateTime.parse(json['start_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'title': title,
      'subtitle': subtitle,
      'wpass_code': wpassCode,
      'event_start_at': eventStartAt,
      'start_at': startAt.toIso8601String(),
    };
  }

  // Convertir Session a SessionDetails
  SessionDetails toSessionDetails(Session session) {
    // Parsear la fecha de inicio del evento desde el formato ISO 8601
    DateTime eventStartAt = DateTime.parse(session.eventStartAt);

    return SessionDetails(
      uuid: session.uuid,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isFeatured: false,
      isPrivate: false,
      isCanceled: false,
      order: 0,
      name: session.title,
      slug: '',
      description: session.subtitle,
      textOutOfStock: '',
      textNotAvailable: '',
      streamingUrl: '',
      streamingDescription: '',
      streamingFreeAccess: false,
      publicStartAt: eventStartAt,
      publicEndAt: eventStartAt.add(Duration(days: 1)),
      startAt: session.startAt,
      endAt: session.startAt.add(Duration(hours: 2)),
      doorsOpenTime: '',
      isCashless: false,
      returnsStartAt: session.startAt,
      returnsEndAt: session.startAt.add(Duration(hours: 1)),
      returnsMinAmount: 0,
      hasSellMax: false,
      sellMax: 0,
      sellMaxType: '',
      ticketsTotal: 0,
      ticketsSold: 0,
      status: '',
      eventVenue: '',
      textOffering: '',
      tickets: [], // Lista vacía por defecto
    );
  }

  static Session fromSessionDetails(SessionDetails details) {
    return Session(
      uuid: details.uuid,
      title: details.name,
      subtitle: details.description,
      wpassCode: '',
      eventStartAt: details.publicStartAt.toIso8601String(),
      startAt: details.startAt,
    );
  }
}
