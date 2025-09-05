// cisterna_detail_page.dart
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import '../../data/models/cisterna.dart';


class CisternaDetailPage extends StatefulWidget {
  final Cisterna cisterna;

  const CisternaDetailPage({super.key, required this.cisterna});

  @override
  State<CisternaDetailPage> createState() => _CisternaDetailPageState();
}

class _CisternaDetailPageState extends State<CisternaDetailPage> {

   double nivelPorcentaje = 0.25; // 72% traer de api el nivel de llenado y calcular porcentaje
   double nivelLlenado = 1.03;//nivel viene en metros


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.cisterna.nombre
          ),
        actions: [
          IconButton(
            onPressed: null, 
            icon: Icon(Icons.logout),
            ),
        ],
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.cisterna.nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.cisterna.descripcion ?? "Sin descripción",
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            
            const SizedBox(height: 20),
            _buildDetailCard("Información de la Cisterna", [
               _buildDetailItem("Nombre", widget.cisterna.nombre),
               _buildDetailItem("Descripción", widget.cisterna.descripcion ?? "N/A"),
               _buildDetailItem("Nivel en metros", nivelLlenado.toString()),
              Center(
                child: SizedBox(
                height: 220,
                width: 220,
                child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: LiquidCircularProgressIndicator(
                      value: nivelPorcentaje, // 0.0 - 1.0
                      valueColor: const AlwaysStoppedAnimation(Colors.blueAccent),
                      backgroundColor: Colors.white,
                      borderColor: Colors.blueGrey,
                      borderWidth: 5.0,
                      direction: Axis.vertical,
                        center: Text(
                        "${(nivelPorcentaje*100).toStringAsFixed(0)}%",
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                                ),
                              ),
                           ),
                        ),
                      ),
                    ),
                  ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailCard(String title, List<Widget> children) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}

