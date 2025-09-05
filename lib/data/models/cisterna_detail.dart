class CisternaDetail {
    final DateTime fecha;
    final int id;
    final int cisternaId;
    final double nivel;
    final int eth;
    final String cod;
    final dynamic createdAt;
    final dynamic updatedAt;

    CisternaDetail({
        required this.fecha,
        required this.id,
        required this.cisternaId,
        required this.nivel,
        required this.eth,
        required this.cod,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CisternaDetail.fromJson(Map<String, dynamic> json) => CisternaDetail(
        fecha: DateTime.parse(json["fecha"]),
        id: json["id"],
        cisternaId: json["cisterna_id"],
        nivel: (json["nivel"] as num).toDouble(),
        eth: json["eth"],
        cod: json["cod"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "fecha": fecha.toIso8601String(),
        "id": id,
        "cisterna_id": cisternaId,
        "nivel": nivel,
        "eth": eth,
        "cod": cod,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
