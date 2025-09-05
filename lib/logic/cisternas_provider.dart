// cisternas_provider.dart
import 'package:cisterna_app/data/models/cisterna_detail.dart';
import 'package:cisterna_app/data/models/cisterna_dimensiones.dart';
import 'package:flutter/material.dart';
import '../data/models/cisterna.dart';
import '../data/services/cisternas_service.dart';


class CisternasProvider with ChangeNotifier {

  List<Cisterna> _cisternas = [];
  final CisternasService _service = CisternasService();
  String? _error;
  bool _isLoading = false;

  List<Cisterna> get cisternas => _cisternas;
  String? get error => _error;
  bool get isLoading => _isLoading;

  CisternaDetail? _ultimoDato;
  bool _isLoadingDetail = false;
  String? _errorDetail;

  CisternaDetail? get ultimoDato => _ultimoDato;
  bool get isLoadingDetail => _isLoadingDetail;
  String? get errorDetail => _errorDetail;

  CisternaDimensiones? _datoAltura;


  CisternaDimensiones? get datoAltura => _datoAltura;
  

  Future<void> loadCisternas() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      _cisternas = await _service.getCisternas();
      
      
    } catch (e) {
      _error = e.toString();
      _cisternas = [];
      //print('Error cargando cisternas: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

Future<void> loadUltimoDato(int cisternaId) async {
    try {
      _isLoadingDetail = true;
      _errorDetail = null;
      notifyListeners();

      _ultimoDato = await _service.getUltimoDato(cisternaId);

    } catch (e) {
      _errorDetail = e.toString();
      print('Error cargando último dato: $e');
    } finally {
      _isLoadingDetail = false;
      notifyListeners();
    }
  }

  Future<void> loadAltura(int cisternaId) async{

    try {
      _datoAltura = null;
      notifyListeners();

      _datoAltura = await _service.getCisternaDimension(cisternaId);

    } catch (e) {
      
      print('Error cargando dato de altura: $e');
    } finally {
      
      notifyListeners();
    }

  }

  void clearDetailData() {
    _ultimoDato = null;
    _errorDetail = null;
    notifyListeners();
  }


}