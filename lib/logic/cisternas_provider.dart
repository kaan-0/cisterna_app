// cisternas_provider.dart
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

  Future<void> loadCisternas() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      
      _cisternas = await _service.getCisternas();
      
      
      // for (var cisterna in _cisternas) {
      //   print('   - ${cisterna.toString()}');
      // }
      
    } catch (e) {
      _error = e.toString();
      _cisternas = [];
      //print('Error cargando cisternas: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}