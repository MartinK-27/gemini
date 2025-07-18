import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini/entities/crops.dart';
import 'package:gemini/presentation/providers.dart';
import 'package:go_router/go_router.dart';

class Sensorscreen extends ConsumerStatefulWidget {
  const Sensorscreen({super.key});

  @override
  ConsumerState<Sensorscreen> createState() => _SensorscreenState();
}

class _SensorscreenState extends ConsumerState<Sensorscreen> {
  @override
  Widget build(BuildContext context) {
     final nombreCultivo = ref.watch(selectedcultivoProvider);
    final cultivos = ref.watch(cultivosProvider);

    // ✅ Validación de null
    if (nombreCultivo == null) {
      return const Scaffold(
        body: Center(child: Text('⚠️ No se seleccionó ningún cultivo')),
      );
    }

     // ✅ Buscar el cultivo
    final selectedCultivo = cultivos.firstWhere(
      (c) => c.name == nombreCultivo,
      orElse: () => Crops(name: 'error', image: ''),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCultivo.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: List.generate(8, (index) => _buildSensorCard(index + 1)),
            ),
            const SizedBox(height: 24),
            _buildChartPlaceholder(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(tooltip: "Chati",onPressed: () {
        context.push('/ChatiScreen');
      },backgroundColor: Color.fromARGB(255, 45, 169, 226),
            child: Icon(Icons.send,
          ),),
    );
  }

  Widget _buildSensorCard(int sensorNumber) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42, // Aproximadamente 2 por fila
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(1, 1)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sensor $sensorNumber:",
            style: const TextStyle(fontSize: 13),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "25.3°C", // Valor simulado
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartPlaceholder() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      child: const Center(
        child: Text(
          "Gráfico",
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
    );
  }
}