// cisterna.dart
class Cisterna {
  final int id;
  final String nombre;
  final String? descripcion;

  Cisterna({
    required this.id,
    required this.nombre,
    this.descripcion,
  });

  factory Cisterna.fromJson(Map<String, dynamic> json) {
    try {
      
      return Cisterna(
        id: json["sitio_id"] ?? json["id"] ?? 0,
        nombre: json["sitio_nombre"] ?? json["nombre"] ?? "Sin nombre",
        descripcion: json["sitio_descripcion"] ?? json["descripcion"],
      );
    } catch (e) {
      
      rethrow;
    }
  }

  // Método para debug
  @override
  String toString() {
    return 'Cisterna{id: $id, nombre: $nombre, descripcion: $descripcion}';
  }
}