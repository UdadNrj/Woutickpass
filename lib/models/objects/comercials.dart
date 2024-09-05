class Commercial {
  final String uuid;
  final String name;

  Commercial({
    required this.uuid,
    required this.name,
  });

  factory Commercial.fromJson(Map<String, dynamic> json) {
    return Commercial(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
    };
  }

  factory Commercial.fromMap(Map<String, dynamic> map) {
    return Commercial(
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
