// cisternas_service.dart
import 'package:cisterna_app/data/models/cisterna_detail.dart';
import 'package:cisterna_app/data/models/cisterna_dimensiones.dart';
import 'package:dio/dio.dart';
import '../models/cisterna.dart';
import 'api_client.dart';

class CisternasService {
  Future<List<Cisterna>> getCisternas() async {
    try {
      final response = await ApiClient.dio.get("/cisternas");
      
      if (response.statusCode == 200) {
        
        if (response.data is Map && response.data.containsKey('cisternas')) {
          final data = response.data["cisternas"] as List;
          ('Cisternas encontradas: ${data.length}');
          
          if (data.isNotEmpty) {
            (' Primer elemento: ${data[0]}');
          }
          
          return data.map((e) => Cisterna.fromJson(e)).toList();
        } else {
         ('Estructura inesperada: ${response.data}');
          return [];
        }
      }
      
     (' Error: Status code ${response.statusCode}');
      return [];
    } on DioException catch (e) {
      (" Error al obtener cisternas: ${e.message}");
      if (e.response != null) {
        (" Response data: ${e.response?.data}");
        (" Response status: ${e.response?.statusCode}");
      }
      rethrow;
    } catch (e) {
      (" Error inesperado: $e");
      rethrow;
    }
  }

  //Ultimo dato
  Future<CisternaDetail> getUltimoDato(int id) async {

    final response = await ApiClient.dio.get("/cisterna/$id/ultimo");

    final data = CisternaDetail.fromJson(response.data);

    return data;

  }

  //Dimensiones

Future<CisternaDimensiones> getCisternaDimension(int id) async {

final response = await ApiClient.dio.get("/dimensiones/$id");

final data = CisternaDimensiones.fromJson(response.data[0]);

return data;

}


}