
import 'package:cisterna_app/data/models/cisterna.dart';
import 'package:cisterna_app/logic/auth_provider.dart';
import 'package:cisterna_app/presentation/auth/login_page.dart';
import 'package:cisterna_app/presentation/cisternas/cisterna_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/cisternas_provider.dart';

class CisternasListPage extends StatefulWidget {
  const CisternasListPage({super.key});

  @override
  State<CisternasListPage> createState() => _CisternasListPageState();
}

class _CisternasListPageState extends State<CisternasListPage> {
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _loadCisternas() async {
    final cisternasProvider = Provider.of<CisternasProvider>(context, listen: false);
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await cisternasProvider.loadCisternas();
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCisternas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cisternasProvider = Provider.of<CisternasProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Cisternas"),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, 
        actions: [
           IconButton(
             icon: const Icon(Icons.refresh),
             onPressed: _loadCisternas,
             tooltip: 'Actualizar',
           ),
           IconButton(
             icon: const Icon(Icons.logout),
             onPressed: (){
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              authProvider.logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context)=> LoginPage()), 
                (Route<dynamic> route)=> false,
                );
             },
           ),
        ],
      ),
      body: _buildBody(context, cisternasProvider),
    );
  }

  
  Widget _buildBody(BuildContext context, CisternasProvider cisternasProvider) {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando cisternas...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Error al cargar cisternas',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _loadCisternas,
                icon: const Icon(Icons.refresh),
                label: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    if (cisternasProvider.cisternas.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.water_damage,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No tienes cisternas asignadas',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            const Text(
              'Contacta con el administrador para asignarte cisternas',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _loadCisternas,
              icon: const Icon(Icons.refresh),
              label: const Text('Actualizar'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadCisternas,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cisternasProvider.cisternas.length,
        itemBuilder: (context, index) {
          final cisterna = cisternasProvider.cisternas[index];
          return _buildCisternaCard(context, cisterna);
        },
      ),
    );
  }

  Widget _buildCisternaCard(BuildContext context, Cisterna cisterna) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
         leading: Container(
           width: 50,
           height: 50,
           decoration: BoxDecoration(
             color: Colors.blue[50],
             shape: BoxShape.circle,
           ),
           child: const Icon(
             Icons.water,
             color: Colors.blue,
             size: 30,
           ),
         ),
        title: Text(
          cisterna.nombre,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              cisterna.descripcion ?? "Sin descripción",
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            // Text(
            //   "ID: ${cisterna.id}",
            //   style: TextStyle(
            //     color: Colors.grey[500],
            //     fontSize: 12,
            //   ),
            // ),
          ],
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_outlined,
          size: 16,
          color: Colors.grey,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CisternaDetailPage(cisterna: cisterna),
            ),
          );
        },
      ),
    );
  }
}