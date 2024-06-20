class EventS {
  final String uuid;
  final String name;
  final String imageUrl;
  final int status;
  final String wpassCode;
  final DateTime publicStartAt;
  final bool isOwner;
  final bool isEditor;
  final bool isAnalyst;
  bool isSelected;

  EventS({
    required this.uuid,
    required this.name,
    required this.imageUrl,
    required this.status,
    required this.wpassCode,
    required this.publicStartAt,
    required this.isOwner,
    required this.isEditor,
    required this.isAnalyst,
    this.isSelected = false,
  });

  factory EventS.fromJson(Map<String, dynamic> json) {
    print('JSON received: $json');
    return EventS(
      uuid: json['uuid'],
      name: json['name'],
      imageUrl: json['image'],
      status: json['status'],
      wpassCode: json['wpass_code'],
      publicStartAt: DateTime.parse(json['public_start_at']),
      isOwner: json['is_owner'],
      isEditor: json['is_editor'],
      isAnalyst: json['is_analyst'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'image': imageUrl,
      'status': status,
      'wpass_code': wpassCode,
      'public_start_at': publicStartAt.toIso8601String(),
      'is_owner': isOwner,
      'is_editor': isEditor,
      'is_analyst': isAnalyst,
      'is_selected': isSelected,
    };
  }
}

Map<String, dynamic> eventData = {
  "uuid": "5744643c-cbfd-4703-9048-fb6335324252",
  "name": "Summer Voley",
  "image":
      "https://api-dev.woutick.com/media/media/events/main/imagen-de-publicidad_6WZMXAS.png",
  "status": 5,
  "wpass_code": "00000AAAAA",
  "public_start_at": "2024-06-03T12:58:57+02:00",
  "is_owner": true,
  "is_editor": true,
  "is_analyst": true
};
