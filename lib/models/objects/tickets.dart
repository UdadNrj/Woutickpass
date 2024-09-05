import 'package:json_annotation/json_annotation.dart';

part 'tickets.g.dart';

@JsonSerializable()
class Tickets {
  final String uuid;
  final String name;

  Tickets({
    required this.uuid,
    required this.name,
  });

  factory Tickets.fromJson(Map<String, dynamic> json) =>
      _$TicketsFromJson(json);

  Map<String, dynamic> toJson() => _$TicketsToJson(this);

  factory Tickets.fromMap(Map<String, dynamic> map) {
    return Tickets(
      uuid: map['uuid'] ?? '',
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
    };
  }
}
