import 'package:cisterna_app/data/models/cisterna.dart';
import 'package:cisterna_app/presentation/auth/login_page.dart';
import 'package:flutter/material.dart';
//import '../presentation/auth/login_page.dart';
import '../presentation/cisternas/cisternas_list_page.dart';
import '../presentation/cisternas/cisterna_detail_page.dart';

class AppRoutes {
  static const login = '/login';
  static const cisternasList = '/cisternas';
  static const cisternaDetail = '/cisternaDetalle';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case cisternasList:
        return MaterialPageRoute(builder: (_) => const CisternasListPage());

      case cisternaDetail:
        final cisterna = settings.arguments as Cisterna;
        return MaterialPageRoute(
          builder: (_) => CisternaDetailPage(cisterna: cisterna),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text("Ruta no encontrada")),
          ),
        );
    }
  }
}
