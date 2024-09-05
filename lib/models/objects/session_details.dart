import 'package:json_annotation/json_annotation.dart';
import 'package:woutickpass/models/objects/comercials.dart';
import 'package:woutickpass/models/objects/tickets.dart';

part 'session_details.g.dart';

@JsonSerializable(explicitToJson: true)
class SessionDetails {
  final String uuid;
  final bool isActive;
  final bool isCanceled;
  final String name;
  final String subtitle;
  final DateTime publicStartAt;
  final DateTime publicEndAt;
  final List<Commercial> commercials;
  final List<Tickets> tickets;

  SessionDetails({
    required this.uuid,
    required this.isActive,
    required this.isCanceled,
    required this.name,
    required this.subtitle,
    required this.publicStartAt,
    required this.publicEndAt,
    required this.commercials,
    required this.tickets,
  });

  factory SessionDetails.fromJson(Map<String, dynamic> json) =>
      _$SessionDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDetailsToJson(this);

  factory SessionDetails.fromMap(Map<String, dynamic> map) {
    return SessionDetails(
      uuid: map['uuid'] ?? '',
      isActive: map['status'] == 3,
      isCanceled: map['is_canceled'] == true,
      name: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      publicStartAt: map['public_start_at'] != null
          ? DateTime.parse(map['public_start_at'])
          : DateTime.now(),
      publicEndAt: map['public_end_at'] != null
          ? DateTime.parse(map['public_end_at'])
          : DateTime.now().add(Duration(days: 365)),
      commercials: (map['commercials'] as List<dynamic>)
          .map((item) => Commercial.fromMap(item))
          .toList(),
      tickets: (map['tickets'] as List<dynamic>)
          .map((item) => Tickets.fromMap(item))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'status': isActive ? 3 : 0,
      'is_canceled': isCanceled ? 1 : 0,
      'title': name,
      'subtitle': subtitle,
      'public_start_at': publicStartAt.toIso8601String(),
      'public_end_at': publicEndAt.toIso8601String(),
      'commercials':
          commercials.map((commercial) => commercial.toMap()).toList(),
      'tickets': tickets.map((ticket) => ticket.toMap()).toList(),
    };
  }
}
