import 'package:json_annotation/json_annotation.dart';

part 'session_details.g.dart';

@JsonSerializable()
class SessionDetails {
  final String uuid;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isFeatured;
  final bool isPrivate;
  final bool isCanceled;
  final int order;
  final String name;
  final String slug;
  final String description;
  final String textOutOfStock;
  final String textNotAvailable;
  final String streamingUrl;
  final String streamingDescription;
  final bool streamingFreeAccess;
  final DateTime publicStartAt;
  final DateTime publicEndAt;
  final DateTime startAt;
  final DateTime endAt;
  final String doorsOpenTime;
  final bool isCashless;
  final DateTime returnsStartAt;
  final DateTime returnsEndAt;
  final int returnsMinAmount;
  final bool hasSellMax;
  final int sellMax;
  final String sellMaxType;
  final int ticketsTotal;
  final int ticketsSold;
  final String status;
  final String eventVenue;
  final String textOffering;
  final List<String> tickets;

  SessionDetails({
    required this.uuid,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.isFeatured,
    required this.isPrivate,
    required this.isCanceled,
    required this.order,
    required this.name,
    required this.slug,
    required this.description,
    required this.textOutOfStock,
    required this.textNotAvailable,
    required this.streamingUrl,
    required this.streamingDescription,
    required this.streamingFreeAccess,
    required this.publicStartAt,
    required this.publicEndAt,
    required this.startAt,
    required this.endAt,
    required this.doorsOpenTime,
    required this.isCashless,
    required this.returnsStartAt,
    required this.returnsEndAt,
    required this.returnsMinAmount,
    required this.hasSellMax,
    required this.sellMax,
    required this.sellMaxType,
    required this.ticketsTotal,
    required this.ticketsSold,
    required this.status,
    required this.eventVenue,
    required this.textOffering,
    required this.tickets,
  });

  factory SessionDetails.fromJson(Map<String, dynamic> json) =>
      _$SessionDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SessionDetailsToJson(this);

  factory SessionDetails.fromMap(Map<String, dynamic> map) {
    return SessionDetails(
      uuid: map['uuid'],
      isActive: map['is_active'] == 1,
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      isFeatured: map['is_featured'] == 1,
      isPrivate: map['is_private'] == 1,
      isCanceled: map['is_canceled'] == 1,
      order: map['order'],
      name: map['name'],
      slug: map['slug'],
      description: map['description'],
      textOutOfStock: map['text_out_of_stock'],
      textNotAvailable: map['text_not_available'],
      streamingUrl: map['streaming_url'],
      streamingDescription: map['streaming_description'],
      streamingFreeAccess: map['streaming_free_access'] == 1,
      publicStartAt: DateTime.parse(map['public_start_at']),
      publicEndAt: DateTime.parse(map['public_end_at']),
      startAt: DateTime.parse(map['start_at']),
      endAt: DateTime.parse(map['end_at']),
      doorsOpenTime: map['doors_open_time'],
      isCashless: map['is_cashless'] == 1,
      returnsStartAt: DateTime.parse(map['returns_start_at']),
      returnsEndAt: DateTime.parse(map['returns_end_at']),
      returnsMinAmount: map['returns_min_amount'],
      hasSellMax: map['has_sell_max'] == 1,
      sellMax: map['sell_max'],
      sellMaxType: map['sell_max_type'],
      ticketsTotal: map['tickets_total'],
      ticketsSold: map['tickets_sold'],
      status: map['status'],
      eventVenue: map['event_venue'],
      textOffering: map['text_offering'],
      tickets: (map['tickets'] as String).split(','),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'is_featured': isFeatured ? 1 : 0,
      'is_private': isPrivate ? 1 : 0,
      'is_canceled': isCanceled ? 1 : 0,
      'order': order,
      'name': name,
      'slug': slug,
      'description': description,
      'text_out_of_stock': textOutOfStock,
      'text_not_available': textNotAvailable,
      'streaming_url': streamingUrl,
      'streaming_description': streamingDescription,
      'streaming_free_access': streamingFreeAccess ? 1 : 0,
      'public_start_at': publicStartAt.toIso8601String(),
      'public_end_at': publicEndAt.toIso8601String(),
      'start_at': startAt.toIso8601String(),
      'end_at': endAt.toIso8601String(),
      'doors_open_time': doorsOpenTime,
      'is_cashless': isCashless ? 1 : 0,
      'returns_start_at': returnsStartAt.toIso8601String(),
      'returns_end_at': returnsEndAt.toIso8601String(),
      'returns_min_amount': returnsMinAmount,
      'has_sell_max': hasSellMax ? 1 : 0,
      'sell_max': sellMax,
      'sell_max_type': sellMaxType,
      'tickets_total': ticketsTotal,
      'tickets_sold': ticketsSold,
      'status': status,
      'event_venue': eventVenue,
      'text_offering': textOffering,
      'tickets': tickets.join(','),
    };
  }
}
