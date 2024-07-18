import 'package:flutter/foundation.dart';
import 'package:woutickpass/models/Sessions.objeto.dart';  // Para el uso de `@immutable`

@immutable
class Sessions {
  final String uuid; // Identificador único del evento
  final String name; // Nombre del evento
  final String? wpassCode; // Código de pase del evento
  final String eventStartAt; // Fecha de inicio del evento como cadena
  final DateTime startAt; // Fecha de inicio del evento como DateTime

  const Sessions({
    required this.uuid,
    required this.name,
    required this.wpassCode,
    required this.eventStartAt,
    required this.startAt,
  });

  factory Sessions.fromJson(Map<String, dynamic> json) {
    return Sessions(
      uuid: json['uuid'],
      name: json['name'],
      wpassCode: json['wpass_code'],
      eventStartAt: json['event_start_at'],
      startAt: DateTime.parse(json['start_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'wpass_code': wpassCode,
      'event_start_at': eventStartAt,
      'start_at': startAt.toIso8601String(),
    };
  }
}
void main() {
  final jsonData = {
    'uuid': '12345',
    'name': 'Event Name',
    'wpass_code': 'ABC123',
    'event_start_at': '2024-07-04T15:00:00Z',
    'start_at': '2024-07-04T15:00:00Z',
  };

  // Test de fromJson
  final event = Sessions.fromJson(jsonData);
  assert(event.uuid == '12345');
  assert(event.name == 'Event Name');
  assert(event.wpassCode == 'ABC123');
  assert(event.eventStartAt == '2024-07-04T15:00:00Z');
  assert(event.startAt == DateTime.parse('2024-07-04T15:00:00Z'));

  // Test de toJson
  final json = event.toJson();
  assert(json['uuid'] == '12345');
  assert(json['name'] == 'Event Name');
  assert(json['wpass_code'] == 'ABC123');
  assert(json['event_start_at'] == '2024-07-04T15:00:00Z');
  assert(json['start_at'] == '2024-07-04T15:00:00Z');
}
