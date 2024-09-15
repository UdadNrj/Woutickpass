class Commercial {
  final String uuid;
  final String name;

  Commercial({required this.uuid, required this.name});

  // Método para crear un objeto a partir de JSON (manual)
  factory Commercial.fromJson(Map<String, dynamic> json) {
    String name = json['name'] ??
        'Desconocido'; // Asigna 'Desconocido' si el nombre es null o vacío
    if (name.isEmpty) {
      name =
          'Desconocido'; // Si el campo está vacío, también asigna 'Desconocido'
    }
    return Commercial(
      uuid: json['uuid'] ?? '',
      name: name,
    );
  }

  // Método para convertir un objeto a JSON
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name.isEmpty
          ? 'Desconocido'
          : name, // Asegurarse de que no esté vacío
    };
  }

  // Método para crear un objeto a partir de un Map (manual)
  factory Commercial.fromMap(Map<String, dynamic> map) {
    String name = map['name'] ??
        'Desconocido'; // Asigna 'Desconocido' si el nombre es null o vacío
    if (name.isEmpty) {
      name =
          'Desconocido'; // Si el campo está vacío, también asigna 'Desconocido'
    }
    return Commercial(
      uuid: map['uuid'] ?? '',
      name: name,
    );
  }

  // Método para convertir un objeto a un Map
  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'name': name.isEmpty
          ? 'Desconocido'
          : name, // Asegurarse de que no esté vacío
    };
  }
}
