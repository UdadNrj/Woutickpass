import 'package:flutter/foundation.dart';
import 'package:woutickpass/models/objects/comercials.dart';
import 'package:woutickpass/models/objects/session_details.dart';
import 'package:woutickpass/models/objects/tickets.dart';


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
      // Manejo del caso null para commercials y tickets
      commercials: (json['commercials'] as List<dynamic>?)
              ?.map((item) => Commercial.fromJson(item))
              .toList() ??
          [], // Si es null, devuelve una lista vacía
      tickets: (json['tickets'] as List<dynamic>?)
              ?.map((item) => Tickets.fromJson(item))
              .toList() ??
          [], // Si es null, devuelve una lista vacía
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

  // Convertir Session a SessionDetails
  SessionDetails toSessionDetails() {
    return SessionDetails(
      uuid: uuid,
      isActive: true, // Por defecto lo marcamos como activo
      isCanceled: false, // Puedes cambiar este valor según tu lógica de negocio
      name: title,
      subtitle: subtitle,
      publicStartAt: publicStartAt,
      publicEndAt: publicEndAt,
      commercials: commercials, // Usa la lista de commercials existente
      tickets: tickets, // Usa la lista de tickets existente
    );
  }

  // Convertir de SessionDetails a Session
  static Session fromSessionDetails(SessionDetails details) {
    return Session(
      uuid: details.uuid,
      title: details.name,
      subtitle: details.subtitle,
      wpassCode: '', // Puedes ajustarlo según sea necesario
      publicStartAt: details.publicStartAt,
      publicEndAt: details.publicEndAt,
      commercials: details.commercials,
      tickets: details.tickets,
    );
  }
}



// import 'package:flutter/foundation.dart';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:woutickpass/models/objects/comercials.dart';
// import 'package:woutickpass/models/objects/session_details.dart';
// import 'package:woutickpass/models/objects/tickets.dart';

// part 'session.g.dart';

// @JsonSerializable(explicitToJson: true)
// @immutable
// class Session {
//   final String uuid;
//   final String title;
//   final String subtitle;
//   final String? wpassCode;
//   final DateTime publicStartAt;
//   final DateTime publicEndAt;
//   final List<Commercial> commercials;
//   final List<Tickets> tickets;

//   const Session({
//     required this.uuid,
//     required this.title,
//     required this.subtitle,
//     this.wpassCode,
//     required this.publicStartAt,
//     required this.publicEndAt,
//     required this.commercials,
//     required this.tickets,
//   });

//   factory Session.fromJson(Map<String, dynamic> json) =>
//       _$SessionFromJson(json);

//   Map<String, dynamic> toJson() => _$SessionToJson(this);

//   factory Session.fromMap(Map<String, dynamic> map) {
//     return Session(
//       uuid: map['uuid'] ?? '',
//       title: map['title'] ?? 'Sin título',
//       subtitle: map['subtitle'] ?? 'Sin subtítulo',
//       wpassCode: map['wpass_code'],
//       publicStartAt: map['public_start_at'] != null
//           ? DateTime.parse(map['public_start_at'])
//           : DateTime.now(),
//       publicEndAt: map['public_end_at'] != null
//           ? DateTime.parse(map['public_end_at'])
//           : DateTime.now().add(Duration(hours: 2)),
//       commercials: (map['commercials'] as List<dynamic>?)
//               ?.map((item) => Commercial.fromMap(item))
//               .toList() ??
//           [],
//       tickets: (map['tickets'] as List<dynamic>?)
//               ?.map((item) => Tickets.fromMap(item))
//               .toList() ??
//           [],
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'uuid': uuid,
//       'title': title,
//       'subtitle': subtitle,
//       'wpass_code': wpassCode,
//       'public_start_at': publicStartAt.toIso8601String(),
//       'public_end_at': publicEndAt.toIso8601String(),
//       'commercials':
//           commercials.map((commercial) => commercial.toMap()).toList(),
//       'tickets': tickets.map((ticket) => ticket.toMap()).toList(),
//     };
//   }

//   // Convertir Session a SessionDetails
//   SessionDetails toSessionDetails() {
//     return SessionDetails(
//       uuid: uuid,
//       isActive: true, // Por defecto lo marcamos como activo
//       isCanceled: false, // Puedes cambiar este valor según tu lógica de negocio
//       name: title,
//       subtitle: subtitle,
//       publicStartAt: publicStartAt,
//       publicEndAt: publicEndAt,
//       commercials: commercials, // Usa la lista de commercials existente
//       tickets: tickets, // Usa la lista de tickets existente
//     );
//   }

//   // Convertir de SessionDetails a Session
//   static Session fromSessionDetails(SessionDetails details) {
//     return Session(
//       uuid: details.uuid,
//       title: details.name,
//       subtitle: details.subtitle,
//       wpassCode: '', // Puedes ajustarlo según sea necesario
//       publicStartAt: details.publicStartAt,
//       publicEndAt: details.publicEndAt,
//       commercials: details.commercials,
//       tickets: details.tickets,
//     );
//   }
// }
