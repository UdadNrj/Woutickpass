import 'package:flutter/foundation.dart';
import 'package:woutickpass/models/objects/session_details.dart';

@immutable
class Session {
  final String uuid;
  final String title;
  final String subtitle;
  final String? wpassCode;
  final DateTime publicStartAt;
  final DateTime publicEndAt;

  const Session({
    required this.uuid,
    required this.title,
    required this.subtitle,
    this.wpassCode,
    required this.publicStartAt,
    required this.publicEndAt,
  });
  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      uuid: json['uuid'] ?? '', // Valor predeterminado si es null
      title: json['title'] ?? 'Sin título', // Evita errores si el valor es null
      subtitle: json['subtitle'] ?? 'Sin subtítulo',
      wpassCode: json['wpass_code'], // Puede ser null, ya que es opcional
      publicStartAt: json['public_start_at'] != null
          ? DateTime.parse(json['public_start_at'])
          : DateTime.now(), // Si es null, usar la fecha actual
      publicEndAt: json['public_end_at'] != null
          ? DateTime.parse(json['public_end_at'])
          : DateTime.now()
              .add(Duration(hours: 2)), // Fecha predeterminada si es null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'title': title,
      'subtitle': subtitle,
      'wpass_code': wpassCode,
      'public_start_at': publicStartAt.toIso8601String(),
      'public_end_at': publicEndAt.toIso8601String(),
    };
  }

  // Convert Session to SessionDetails
  SessionDetails toSessionDetails() {
    return SessionDetails(
      uuid: uuid,
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isFeatured: false,
      isPrivate: false,
      isCanceled: false,
      order: 0,
      name: title,
      slug: '',
      description: subtitle,
      textOutOfStock: '',
      textNotAvailable: '',
      streamingUrl: '',
      streamingDescription: '',
      streamingFreeAccess: false,
      publicStartAt: publicStartAt,
      publicEndAt: publicEndAt.add(Duration(days: 1)),
      startAt: publicStartAt,
      endAt: publicStartAt.add(Duration(hours: 2)),
      doorsOpenTime: '',
      isCashless: false,
      returnsStartAt: publicStartAt,
      returnsEndAt: publicStartAt.add(Duration(hours: 1)),
      returnsMinAmount: 0,
      hasSellMax: false,
      sellMax: 0,
      sellMaxType: '',
      ticketsTotal: 0,
      ticketsSold: 0,
      hasSettlement: true,
      status: '',
      eventVenue: '',
      textOffering: '',
      tickets: [],
    );
  }

  static Session fromSessionDetails(SessionDetails details) {
    return Session(
      uuid: details.uuid,
      title: details.name,
      subtitle: details.description,
      wpassCode: '',
      publicStartAt: details.publicStartAt,
      publicEndAt: details.publicEndAt,
    );
  }
}
