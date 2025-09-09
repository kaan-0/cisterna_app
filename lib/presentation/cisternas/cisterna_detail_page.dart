// cisterna_detail_page.dart
import 'package:cisterna_app/logic/cisternas_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import '../../data/models/cisterna.dart';
import 'package:intl/intl.dart';



class CisternaDetailPage extends StatefulWidget {
  final Cisterna cisterna;

  const CisternaDetailPage({super.key, required this.cisterna});

  @override
  State<CisternaDetailPage> createState() => _CisternaDetailPageState();
}

class _CisternaDetailPageState extends State<CisternaDetailPage> {

    @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUltimoDato();
    });
  }

  void _loadUltimoDato() {
    final provider = Provider.of<CisternasProvider>(context, listen: false);
    provider.loadUltimoDato(widget.cisterna.id);
    provider.loadAltura(widget.cisterna.id);
    
  }
  
  // void _loadAltura() {
  //   final provider2 = Provider.of<CisternasProvider>(context, listen: false);
  //   provider2.loadAltura(widget.cisterna.id);
    
  // }

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
  }

  double _calcularPorcentaje(double nivelMetros, double alturaMaxima) {

    alturaMaxima=alturaMaxima/100;

    // print(nivelMetros);
    // print(alturaMaxima);
    // print((nivelMetros / alturaMaxima).clamp(0.0, 1.0));

     return (nivelMetros / alturaMaxima).clamp(0.0, 1.0);
     
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CisternasProvider>(context);
    // final provider2 = Provider.of<CisternasProvider>(context);

    final ultimoDato = provider.ultimoDato;
    final altura = provider.datoAltura;
    final fecha = provider.ultimoDato!.fecha;
    
    //print(ultimoDato?.fecha);

    final double nivelTexto = (ultimoDato!.nivel * 100).roundToDouble();

    final double nivelLlenado = ultimoDato.nivel;

    final double alturaMaxima = (altura?.altura ?? 0).toDouble();

    final double nivelPorcentaje = _calcularPorcentaje(nivelLlenado,alturaMaxima);

    var formato = DateFormat('dd-MM-yyyy HH:mm');

    final fechaFormateada = formato.format(fecha);

    


    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.cisterna.nombre
          ),
        actions: [
          IconButton(
           onPressed: _loadUltimoDato,
            icon: const Icon(Icons.refresh),
            tooltip: 'Actualizar',
            ),
        ],
        
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // Text(
            //   widget.cisterna.nombre,
            //   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 8),
            // Text(
            //   widget.cisterna.descripcion ?? "Sin descripción",
            //   style: const TextStyle(fontSize: 16, color: Colors.grey),
            // ),
            
            const SizedBox(height: 20),
            _buildDetailCard("Información de la Cisterna", [
               _buildDetailItem("Nombre", widget.cisterna.nombre),
               _buildDetailItem("Descripción", widget.cisterna.descripcion ?? "N/A"),
               _buildDetailItem("Nivel", "$nivelTexto cms"),
               _buildDetailItem("Leído el",fechaFormateada ),
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

