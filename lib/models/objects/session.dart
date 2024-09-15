import 'package:flutter/foundation.dart';
import 'package:woutickpass/models/objects/comercials.dart';
import 'package:woutickpass/models/objects/session_details.dart';
import 'tickets.dart';

@immutable
class Session {
  final String uuid;
  final String title;
  final String subtitle;
  final String? wpassCode;
  final DateTime publicStartAt;
  final DateTime publicEndAt;
  final List<Commercial> commercials;
  final List<Tickets> tickets;

  const Session({
    required this.uuid,
    required this.title,
    required this.subtitle,
    this.wpassCode,
    required this.publicStartAt,
    required this.publicEndAt,
    required this.commercials,
    required this.tickets,
  });

  /// Convierte de `SessionDetails` a `Session`
  static Session fromSessionDetails(SessionDetails details) {
    return Session(
      uuid: details.uuid,
      title: details.title,
      subtitle: details.subtitle,
      wpassCode: details.wpassCode,
      publicStartAt: details.publicStartAt,
      publicEndAt: details.publicEndAt,
      commercials: details.commercials,
      tickets: details.tickets,
    );
  }

  /// Convierte `Session` a `SessionDetails`
  SessionDetails toSessionDetails() {
    return SessionDetails(
      uuid: uuid,
      isActive: 'active', // Valor predeterminado por defecto
      isCanceled: 'false', // Valor predeterminado por defecto
      title: title,
      subtitle: subtitle,
      publicStartAt: publicStartAt,
      publicEndAt: publicEndAt,
      commercials: commercials,
      tickets: tickets,
    );
  }

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      uuid: json['uuid'] ?? '',
      title: json['title'] ?? 'Sin título',
      subtitle: json['subtitle'] ?? 'Sin subtítulo',
      wpassCode: json['wpass_code'],
      publicStartAt: json['public_start_at'] != null
          ? DateTime.parse(json['public_start_at'])
          : DateTime.now(),
      publicEndAt: json['public_end_at'] != null
          ? DateTime.parse(json['public_end_at'])
          : DateTime.now().add(Duration(hours: 2)),
      commercials: (json['commercials'] as List<dynamic>?)
              ?.map((item) => Commercial.fromJson(item))
              .toList() ??
          [],
      tickets: (json['tickets'] as List<dynamic>?)
              ?.map((item) => Tickets.fromJson(item))
              .toList() ??
          [],
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
      'commercials':
          commercials.map((commercial) => commercial.toJson()).toList(),
      'tickets': tickets.map((ticket) => ticket.toJson()).toList(),
    };
  }
}
