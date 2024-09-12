import 'package:json_annotation/json_annotation.dart';
import 'package:woutickpass/models/objects/comercials.dart';
import 'package:woutickpass/models/objects/tickets.dart';

part 'session_details.g.dart'; // Archivo generado automáticamente por json_serializable

@JsonSerializable(explicitToJson: true)
class SessionDetails {
  final String uuid;
  final bool isActive;
  final bool isCanceled;
  final String title;
  final String subtitle;
  final String? wpassCode; // Campo opcional wpassCode
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

  // *** JSON SERIALIZATION AUTOMÁTICA ***
  factory SessionDetails.fromJson(Map<String, dynamic> json) =>
      _$SessionDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDetailsToJson(this);

  // *** MAP SERIALIZATION MANUAL ***

  /// Método para crear un objeto a partir de un Map (como los que se usan en bases de datos locales)
  factory SessionDetails.fromMap(Map<String, dynamic> map) {
    return SessionDetails(
      uuid: map['uuid'] ?? '',
      isActive: (map['status'] != null &&
          map['status'] == 3), // Convertimos status == 3 a isActive
      isCanceled: (map['is_canceled'] != null && map['is_canceled'] == true)
          ? true
          : false, // Si es null, será false
      title: map['title'] ?? 'Sin título', // Título predeterminado si es null
      subtitle: map['subtitle'] ??
          'Sin subtítulo', // Subtítulo predeterminado si es null
      wpassCode: map['wpass_code'], // Opcional
      publicStartAt: map['public_start_at'] != null
          ? DateTime.parse(map['public_start_at'])
          : DateTime.now(), // Fecha predeterminada si es null
      publicEndAt: map['public_end_at'] != null
          ? DateTime.parse(map['public_end_at'])
          : DateTime.now().add(Duration(days: 365)), // Fecha predeterminada
      commercials: (map['commercials'] as List<dynamic>?)
              ?.map((item) => Commercial.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [], // Lista vacía si es null
      tickets: (map['tickets'] as List<dynamic>?)
              ?.map((item) => Tickets.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [], // Lista vacía si es null
    );
  }

  /// Método para convertir el objeto a un Map (usado para guardar en bases de datos locales)
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'status': isActive ? 3 : 0, // Convertimos isActive a status (3 es activo)
      'is_canceled': isCanceled ? 1 : 0, // Convertimos isCanceled a 1 o 0
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
