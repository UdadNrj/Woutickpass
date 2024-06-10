class Sesion {
  String nombre;
  String ubicacion;
  DateTime fecha;

  Sesion({required this.nombre, required this.ubicacion, required this.fecha});
}

class Evento {
  String id;
  String titulo;
  DateTime fecha;
  String ubicacion;

  List<Sesion> sesiones;

  Evento({
    required this.id,
    required this.titulo,
    required this.fecha,
    required this.ubicacion,
    required this.sesiones,
  });
}
