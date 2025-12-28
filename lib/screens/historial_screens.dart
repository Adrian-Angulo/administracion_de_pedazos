import 'package:administracion_de_pedazos/widgets/TimelineItem.dart';
import 'package:administracion_de_pedazos/widgets/font.dart';
import 'package:flutter/material.dart';

class HistorialScreens extends StatelessWidget {
  const HistorialScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'titulo': 'Pedazo #402 - Lote A',
        'estado': 'Registrado',
        'hora': '09:30 AM',
        'isCompleted': false,
      },
      {
        'titulo': 'Pedazo #401 - Lote A',
        'estado': 'Registrado',
        'hora': '10:15 AM',
        'isCompleted': false,
      },
      {
        'titulo': 'Pedazo #399 - Lote B',
        'estado': 'Entregado',
        'hora': '02:15 PM',
        'isCompleted': true,
      },
    ];

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
            const Text(
              'Línea de tiempo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                return TimelineItem(
                  titulo: "Pedazo #402 - Lote A",
                  estado: "Registrado",
                  hora: '09:30 AM',
                  isCompleted: false,
                  isLast: index == items.length - 1,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
