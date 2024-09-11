class Commercial {
  final String uuid;
  final String name;

  Commercial({
    required this.uuid,
    required this.name,
  });

  // Convierte un JSON en una instancia de Commercial
  factory Commercial.fromJson(Map<String, dynamic> json) {
    if (json['name'] == null || json['name'].isEmpty) {
      print(
          "Advertencia: El campo 'name' está vacío o es null en el comercial con uuid ${json['uuid']}");
    }
    return Commercial(
      uuid: json['uuid'] ?? '',
      name: json['name'] ??
          'Nombre desconocido', // Cambiar a un valor por defecto claro
    );
  }

  // Convierte la instancia de Commercial en un JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
    };
  }

  // Convierte un Map de SQLite a una instancia de Commercial
  factory Commercial.fromMap(Map<String, dynamic> map) {
    return Commercial(
      uuid: map['uuid'] ?? '',
      name: map['name'] ?? '',
    );
  }

  // Convierte la instancia de Commercial en un Map para SQLite
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name,
    };
  }
}
