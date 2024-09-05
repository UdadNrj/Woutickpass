// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionDetails _$SessionDetailsFromJson(Map<String, dynamic> json) =>
    SessionDetails(
      uuid: json['uuid'] as String,
      isActive: json['isActive'] as bool,
      isCanceled: json['isCanceled'] as bool,
      name: json['name'] as String,
      subtitle: json['subtitle'] as String,
      publicStartAt: DateTime.parse(json['publicStartAt'] as String),
      publicEndAt: DateTime.parse(json['publicEndAt'] as String),
      commercials: (json['commercials'] as List<dynamic>)
          .map((e) => Commercial.fromJson(e as Map<String, dynamic>))
          .toList(),
      tickets: (json['tickets'] as List<dynamic>)
          .map((e) => Tickets.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SessionDetailsToJson(SessionDetails instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'isActive': instance.isActive,
      'isCanceled': instance.isCanceled,
      'name': instance.name,
      'subtitle': instance.subtitle,
      'publicStartAt': instance.publicStartAt.toIso8601String(),
      'publicEndAt': instance.publicEndAt.toIso8601String(),
      'commercials': instance.commercials.map((e) => e.toJson()).toList(),
      'tickets': instance.tickets.map((e) => e.toJson()).toList(),
    };
