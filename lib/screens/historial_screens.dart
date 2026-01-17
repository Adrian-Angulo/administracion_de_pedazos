import 'package:administracion_de_pedazos/models/pedazo_historial.dart';
import 'package:administracion_de_pedazos/providers/historial_providers.dart';
import 'package:administracion_de_pedazos/widgets/TimelineItem.dart';
import 'package:administracion_de_pedazos/widgets/font.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistorialScreens extends StatefulWidget {
  const HistorialScreens({super.key});

  @override
  State<HistorialScreens> createState() => _HistorialScreensState();
}

class _HistorialScreensState extends State<HistorialScreens> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HistorialProviders>().cargarHistorial();
    });
  }

  Future<void> _seleccionarFecha(
    BuildContext context,
    DateTime? fechaSeleccionada,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fechaSeleccionada ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (picked != null && picked != fechaSeleccionada) {
      context.read<HistorialProviders>().cambiarFechaSelecionada(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final providerHistorial = context.watch<HistorialProviders>();
    final fechaSeleccionada = providerHistorial.fechaSeleccionada;
    final listaHistorial = providerHistorial.filtrarHistorial();

    return Scaffold(
      appBar: AppBar(
        title: titlePrimary("Historial"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Línea de tiempo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "${fechaSeleccionada?.day}/${fechaSeleccionada?.month}/${fechaSeleccionada?.year}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),

                  onTap: () => _seleccionarFecha(context, fechaSeleccionada),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Expanded(
              child: listaHistorial.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.history, size: 64, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No hay historial disponible',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: listaHistorial.length,
                      itemBuilder: (context, index) {
                        Pedazohistorial historial = listaHistorial[index];
                        return TimelineItem(
                          destinatario: historial.destinatario,
                          remitente: historial.remitente,
                          numero: historial.numero,
                          valor: historial.valor,
                          estado: historial.estado,
                          fecha: historial.fecha,
                          isCompleted: historial.isCompleted == 0
                              ? false
                              : true,
                          isLast: index == listaHistorial.length - 1,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
