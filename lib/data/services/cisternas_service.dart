// cisternas_service.dart
import 'package:dio/dio.dart';
import '../models/cisterna.dart';
import 'api_client.dart';

class CisternasService {
  Future<List<Cisterna>> getCisternas() async {
    try {
      final response = await ApiClient.dio.get("/cisternas");
      //final  dimensiones = await ApiClient.dio.get("/dimensiones/");

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

  //getDimensiones?
}