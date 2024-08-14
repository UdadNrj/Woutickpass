import 'package:flutter/foundation.dart';
import 'package:woutickpass/models/objects/session_details.dart';

@immutable
class Session {
  final String uuid;
  final String title;
  final String subtitle;
  final String? wpassCode;
  final String eventStartAt;
  final DateTime startAt;

  const Session({
    required this.uuid,
    required this.title,
    required this.subtitle,
    this.wpassCode,
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
      publicStartAt: DateTime.parse(eventStartAt),
      publicEndAt: DateTime.parse(eventStartAt).add(Duration(days: 1)),
      startAt: startAt,
      endAt: startAt.add(Duration(hours: 2)),
      doorsOpenTime: '',
      isCashless: false,
      returnsStartAt: startAt,
      returnsEndAt: startAt.add(Duration(hours: 1)),
      returnsMinAmount: 0,
      hasSellMax: false,
      sellMax: 0,
      sellMaxType: '',
      ticketsTotal: 0,
      ticketsSold: 0,
      status: '',
      eventVenue: '',
      textOffering: '',
      tickets: [], // Empty list by default
    );
  }

  static Session fromSessionDetails(SessionDetails details) {
    return Session(
      uuid: details.uuid,
      title: details.name,
      subtitle: details.description,
      wpassCode: '', // No direct mapping for wpassCode
      eventStartAt: details.publicStartAt.toIso8601String(),
      startAt: details.startAt,
    );
  }
}
