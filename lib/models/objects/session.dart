import 'package:flutter/foundation.dart';
import 'package:woutickpass/models/objects/comercials.dart';
import 'package:woutickpass/models/objects/session_details.dart';
import 'tickets.dart';

@immutable
class Session {
  final String uuid;
  final String title;
  final String subtitle;
  final String? wpassCode; // Campo opcional
  final DateTime publicStartAt;
  final DateTime publicEndAt;
  final List<Commercial> commercials; // Lista de Commercials
  final List<Tickets> tickets; // Lista de Tickets

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

  /// Validación básica para asegurar que los campos obligatorios no estén vacíos.
  void _validate() {
    if (uuid.isEmpty) {
      throw Exception("El campo 'uuid' no puede estar vacío.");
    }
    if (title.isEmpty) {
      throw Exception("El campo 'title' no puede estar vacío.");
    }
    if (subtitle.isEmpty) {
      throw Exception("El campo 'subtitle' no puede estar vacío.");
    }
    if (publicEndAt.isBefore(publicStartAt)) {
      throw Exception(
          "La fecha de finalización no puede ser anterior a la de inicio.");
    }
  }

  /// Convierte un JSON en una instancia de `Session`
  factory Session.fromJson(Map<String, dynamic> json) {
    // Validación previa para asegurarse de que los datos críticos existan
    if (json['uuid'] == null || json['uuid'].isEmpty) {
      throw Exception("El campo 'uuid' es requerido en los datos JSON.");
    }
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

  /// Convierte la instancia de `Session` en un JSON
  Map<String, dynamic> toJson() {
    // Validar los campos obligatorios antes de convertir a JSON
    _validate();

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

  /// Convierte de `SessionDetails` a `Session`
  static Session fromSessionDetails(SessionDetails details) {
    return Session(
      uuid: details.uuid,
      title: details.title,
      subtitle: details.subtitle,
      wpassCode: null, // Ajusta según sea necesario
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
      isActive: true,
      isCanceled: false,
      title: title,
      subtitle: subtitle,
      publicStartAt: publicStartAt,
      publicEndAt: publicEndAt,
      commercials: commercials,
      tickets: tickets,
    );
  }

  /// Convierte un Map de SQLite a una instancia de `Session`
  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      uuid: map['uuid'] ?? '',
      title: map['title'] ?? 'Sin título',
      subtitle: map['subtitle'] ?? 'Sin subtítulo',
      wpassCode: map['wpass_code'],
      publicStartAt: DateTime.parse(map['public_start_at']),
      publicEndAt: DateTime.parse(map['public_end_at']),
      commercials: (map['commercials'] as List<dynamic>?)
              ?.map((item) => Commercial.fromMap(item))
              .toList() ??
          [],
      tickets: (map['tickets'] as List<dynamic>?)
              ?.map((item) => Tickets.fromMap(item))
              .toList() ??
          [],
    );
  }

  /// Convierte la instancia de `Session` en un Map para SQLite
  Map<String, dynamic> toMap() {
    // Validar antes de convertir
    _validate();

    return {
      'uuid': uuid,
      'title': title,
      'subtitle': subtitle,
      'wpass_code': wpassCode,
      'public_start_at': publicStartAt.toIso8601String(),
      'public_end_at': publicEndAt.toIso8601String(),
      'commercials':
          commercials.map((commercial) => commercial.toMap()).toList(),
      'tickets': tickets.map((ticket) => ticket.toMap()).toList(),
    };
  }
}
