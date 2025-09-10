
class CisternaDimensiones {
  final int id;
  final int? radioBase; // Cambiado de dynamic a int?
  final int? base;      // Cambiado de int a int?
  final int? ancho;     // Cambiado de int a int?
  final int? radioCono; // Cambiado de dynamic a int?
  final int? radioSuperiorCono; // Cambiado de dynamic a int?
  final int altura;    
  final int sitioId;
  final int tipoId;
  final DateTime createdAt;
  final DateTime updatedAt;

  CisternaDimensiones({
    required this.id,
    this.radioBase,
    this.base,
    this.ancho,
    this.radioCono,
    this.radioSuperiorCono,
    required this.altura,
    required this.sitioId,
    required this.tipoId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CisternaDimensiones.fromJson(Map<String, dynamic> json) => CisternaDimensiones(
    id: json["id"] as int? ?? 0, // Valor por defecto
    radioBase: json["radio_base"] as int?,
    base: json["base"] as int?,
    ancho: json["ancho"] as int?,
    radioCono: json["radio_cono"] as int?,
    radioSuperiorCono: json["radio_superior_cono"] as int?,
    altura: json["altura"] as int, // no Puede ser null
    sitioId: json["sitio_id"] as int? ?? 0,
    tipoId: json["tipo_id"] as int? ?? 0,
    createdAt: DateTime.parse(json["created_at"] as String? ?? "2025-01-01"),
    updatedAt: DateTime.parse(json["updated_at"] as String? ?? "2025-01-01"),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "radio_base": radioBase,
    "base": base,
    "ancho": ancho,
    "radio_cono": radioCono,
    "radio_superior_cono": radioSuperiorCono,
    "altura": altura,
    "sitio_id": sitioId,
    "tipo_id": tipoId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}