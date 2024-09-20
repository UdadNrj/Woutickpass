import 'dart:convert'; // Necesario para jsonEncode y jsonDecode
import 'package:woutickpass/models/objects/comercials.dart';
import 'package:woutickpass/models/objects/tickets.dart';

class SessionDetails {
  final String uuid;
  final String isActive; // Cadena de texto para estado activo
  final String isCanceled; // Cadena de texto para estado cancelado
  final String title;
  final String subtitle;
  final String? wpassCode; // Campo opcional
  final DateTime publicStartAt;
  final DateTime publicEndAt;
  final List<Commercial> commercials;
  final List<Tickets> tickets;

  SessionDetails({
    required this.uuid,
    required this.isActive,
    required this.isCanceled,
    required this.title,
    required this.subtitle,
    this.wpassCode,
    required this.publicStartAt,
    required this.publicEndAt,
    required this.commercials,
    required this.tickets,
  });

  // Método para crear un objeto a partir de JSON (manual)
  factory SessionDetails.fromJson(Map<String, dynamic> json) {
    return SessionDetails(
      uuid: json['uuid'] ?? '',
      isActive: (json['status'] != null && json['status'] == 3)
          ? 'active'
          : 'inactive', // Conversión manual de status a isActive
      isCanceled: json['is_canceled'] == true
          ? 'true'
          : 'false', // Conversión manual a cadena
      title: json['title'] ?? 'Sin título', // Valor predeterminado si es null
      subtitle: json['subtitle'] ??
          'Sin subtítulo', // Valor predeterminado si es null
      wpassCode: json['wpass_code'], // Este puede ser null
      publicStartAt: DateTime.parse(json['public_start_at'] ??
          DateTime.now()
              .toIso8601String()), // Si es null, asigna la fecha actual
      publicEndAt: DateTime.parse(json['public_end_at'] ??
          DateTime.now()
              .add(Duration(days: 365))
              .toIso8601String()), // Si es null, fecha un año después
      commercials: (json['commercials'] as List<dynamic>)
          .map((e) => Commercial.fromJson(e as Map<String, dynamic>))
          .toList(),
      tickets: (json['tickets'] as List<dynamic>)
          .map((e) => Tickets.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // Método para convertir un objeto a JSON (manual)
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'status': isActive == 'active' ? 3 : 0, // Convertimos isActive a status
      'is_canceled': isCanceled == 'true', // Convertimos isCanceled a boolean
      'title': title,
      'subtitle': subtitle,
      'wpass_code': wpassCode,
      'public_start_at': publicStartAt.toIso8601String(),
      'public_end_at': publicEndAt.toIso8601String(),
      'commercials': commercials.map((e) => e.toJson()).toList(),
      'tickets': tickets.map((e) => e.toJson()).toList(),
    };
  }

  factory SessionDetails.fromMap(Map<String, dynamic> map) {
    return SessionDetails(
      uuid: map['uuid'] ?? '',
      isActive: (map['status'] != null && map['status'] == 3)
          ? 'active'
          : 'inactive', // Conversión manual de status a isActive
      isCanceled: map['is_canceled'] == 1
          ? 'true'
          : 'false', // Convertimos 1 o 0 a cadena 'true' o 'false'
      title: map['title'] ?? 'Sin título', // Valor predeterminado si es null
      subtitle:
          map['subtitle'] ?? 'Sin subtítulo', // Valor predeterminado si es null
      wpassCode: map['wpass_code'], // Este puede ser null
      publicStartAt: DateTime.parse(map['public_start_at'] ??
          DateTime.now()
              .toIso8601String()), // Si es null, asigna la fecha actual
      publicEndAt: DateTime.parse(map['public_end_at'] ??
          DateTime.now()
              .add(Duration(days: 365))
              .toIso8601String()), // Si es null, fecha un año después

      // Deserializar comerciales si es una cadena JSON
      commercials: map['commercials'] is String
          ? (jsonDecode(map['commercials']) as List<dynamic>)
              .map((e) => Commercial.fromMap(e as Map<String, dynamic>))
              .toList()
          : (map['commercials'] as List<dynamic>)
              .map((e) => Commercial.fromMap(e as Map<String, dynamic>))
              .toList(),

      // Deserializar tickets si es una cadena JSON
      tickets: map['tickets'] is String
          ? (jsonDecode(map['tickets']) as List<dynamic>)
              .map((e) => Tickets.fromMap(e as Map<String, dynamic>))
              .toList()
          : (map['tickets'] as List<dynamic>)
              .map((e) => Tickets.fromMap(e as Map<String, dynamic>))
              .toList(),
    );
  }

  // Método para convertir un objeto a un Map (manual)
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'status': isActive == 'active' ? 3 : 0, // Convertimos isActive a status
      'is_canceled':
          isCanceled == 'true' ? 1 : 0, // Convertimos isCanceled a 1 o 0
      'title': title,
      'subtitle': subtitle,
      'wpass_code': wpassCode,
      'public_start_at': publicStartAt.toIso8601String(),
      'public_end_at': publicEndAt.toIso8601String(),
      // Convertimos las listas a JSON si son Listas, si ya es un JSON, lo dejamos
      'commercials': jsonEncode(commercials.map((e) => e.toMap()).toList()),
      'tickets': jsonEncode(tickets.map((e) => e.toMap()).toList()),
    };
  }
}
