// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionDetails _$SessionDetailsFromJson(Map<String, dynamic> json) =>
    SessionDetails(
      uuid: json['uuid'] as String,
      isActive: json['isActive'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isFeatured: json['isFeatured'] as bool,
      isPrivate: json['isPrivate'] as bool,
      isCanceled: json['isCanceled'] as bool,
      order: (json['order'] as num).toInt(),
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
      textOutOfStock: json['textOutOfStock'] as String,
      textNotAvailable: json['textNotAvailable'] as String,
      streamingUrl: json['streamingUrl'] as String,
      streamingDescription: json['streamingDescription'] as String,
      streamingFreeAccess: json['streamingFreeAccess'] as bool,
      publicStartAt: DateTime.parse(json['publicStartAt'] as String),
      publicEndAt: DateTime.parse(json['publicEndAt'] as String),
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      doorsOpenTime: json['doorsOpenTime'] as String,
      isCashless: json['isCashless'] as bool,
      returnsStartAt: DateTime.parse(json['returnsStartAt'] as String),
      returnsEndAt: DateTime.parse(json['returnsEndAt'] as String),
      returnsMinAmount: (json['returnsMinAmount'] as num).toInt(),
      hasSellMax: json['hasSellMax'] as bool,
      sellMax: (json['sellMax'] as num).toInt(),
      sellMaxType: json['sellMaxType'] as String,
      ticketsTotal: (json['ticketsTotal'] as num).toInt(),
      ticketsSold: (json['ticketsSold'] as num).toInt(),
      status: json['status'] as String,
      eventVenue: json['eventVenue'] as String,
      textOffering: json['textOffering'] as String,
      tickets:
          (json['tickets'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SessionDetailsToJson(SessionDetails instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isFeatured': instance.isFeatured,
      'isPrivate': instance.isPrivate,
      'isCanceled': instance.isCanceled,
      'order': instance.order,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'textOutOfStock': instance.textOutOfStock,
      'textNotAvailable': instance.textNotAvailable,
      'streamingUrl': instance.streamingUrl,
      'streamingDescription': instance.streamingDescription,
      'streamingFreeAccess': instance.streamingFreeAccess,
      'publicStartAt': instance.publicStartAt.toIso8601String(),
      'publicEndAt': instance.publicEndAt.toIso8601String(),
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
      'doorsOpenTime': instance.doorsOpenTime,
      'isCashless': instance.isCashless,
      'returnsStartAt': instance.returnsStartAt.toIso8601String(),
      'returnsEndAt': instance.returnsEndAt.toIso8601String(),
      'returnsMinAmount': instance.returnsMinAmount,
      'hasSellMax': instance.hasSellMax,
      'sellMax': instance.sellMax,
      'sellMaxType': instance.sellMaxType,
      'ticketsTotal': instance.ticketsTotal,
      'ticketsSold': instance.ticketsSold,
      'status': instance.status,
      'eventVenue': instance.eventVenue,
      'textOffering': instance.textOffering,
      'tickets': instance.tickets,
    };
