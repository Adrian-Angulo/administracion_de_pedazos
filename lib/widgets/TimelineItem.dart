import 'package:administracion_de_pedazos/screens/linea_tiempo_detalle.dart';
import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final String titulo;
  final String hora;
  final String estado;
  final bool isLast;
  final bool isCompleted;
  final double valor;

  const TimelineItem({
    super.key,
    required this.titulo,
    required this.hora,
    required this.estado,
    required this.valor,
    this.isLast = false,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LineaTiempoDetalle()),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // COLUMNA DE LA LÍNEA
          Column(
            children: [
              // CÍRCULO
              Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: isCompleted ? Colors.green : const Color(0xFF1F3A2E),
                  shape: BoxShape.circle,
                  border: BoxBorder.all(color: Color(0xFF3A4F45), width: 2),
                ),
                child: Text(
                  "404",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
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
                          "De: Camilo",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "\$ $valor",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // estado
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isCompleted ? Colors.green : Color(0xFF1A2E25),

                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          estado,
                          style: TextStyle(
                            color: isCompleted ? Colors.white : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        hora,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
