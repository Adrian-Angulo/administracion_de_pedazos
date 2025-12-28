import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final String titulo;
  final String estado;
  final String hora;
  final bool isLast;
  final bool isCompleted;

  const TimelineItem({
    super.key,
    required this.titulo,
    required this.estado,
    required this.hora,
    this.isLast = false,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // COLUMNA DE LA LÍNEA
        Column(
          children: [
            // CÍRCULO
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: isCompleted ? Colors.green : const Color(0xFF1F3A2E),
                shape: BoxShape.circle,
                border: BoxBorder.all(color: Color(0xFF3A4F45), width: 2),
              ),
              child: Icon(
                isCompleted ? Icons.check : Icons.inventory_2_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),

            // LÍNEA VERTICAL
            if (!isLast)
              Container(width: 2, height: 30, color: const Color(0xFF3A4F45)),
          ],
        ),

        const SizedBox(width: 12),

        // CONTENIDO
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TEXTO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titulo,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        estado,
                        style: TextStyle(
                          color: isCompleted
                              ? Colors.greenAccent
                              : const Color(0xFF9CCEB4),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                // HORA
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A2E25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    hora,
                    style: TextStyle(
                      color: isCompleted ? Colors.greenAccent : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
