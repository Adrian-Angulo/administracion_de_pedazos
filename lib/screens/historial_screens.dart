import 'package:administracion_de_pedazos/formatters/formatters.dart';
import 'package:administracion_de_pedazos/models/pedazo_historial.dart';
import 'package:administracion_de_pedazos/providers/historial_providers.dart';
import 'package:administracion_de_pedazos/widgets/DateBadgeWidget.dart';
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

  @override
  Widget build(BuildContext context) {
    final lista_historial = context.watch<HistorialProviders>().historial;

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [DateBadgeWidget(dateText: formatDateTime(),)],
            ),
            const SizedBox(height: 16),
            const Text(
              'Línea de tiempo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: lista_historial.isEmpty
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
                      itemCount: lista_historial.length,
                      itemBuilder: (context, index) {
                        Pedazohistorial historial = lista_historial[index];
                        return TimelineItem(
                          destinatario: historial.destinatario,
                          remitente: historial.remitente,
                          numero: historial.numero,
                          valor: historial.valor,
                          estado: historial.estado,
                          hora: historial.hora,
                          isCompleted: historial.isCompleted == 0
                              ? false
                              : true,
                          isLast: index == lista_historial.length - 1,
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
