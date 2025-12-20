import 'package:flutter/material.dart';

/// Input minimalista para números
/// Diseño: texto grande centrado + línea inferior
class MinimalNumberInput extends StatelessWidget {
  // Controller para acceder al valor ingresado
  final TextEditingController controller;

  // Texto de ayuda (ej: "Valor", "Cantidad")
  final String hint;

  // Si es solo lectura
  final bool readOnly;

  const MinimalNumberInput({
    super.key,
    required this.controller,
    required this.hint,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Campo de texto
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Este campo es obligatorio';
            }
            return null;
          },
          controller: controller,
          readOnly: readOnly,

          // Teclado numérico
          keyboardType: TextInputType.number,

          // Centra el texto como en la imagen
          textAlign: TextAlign.center,

          // Estilo del número grande
          style: TextStyle(
            fontSize: 56,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface.withOpacity(0.35),
            letterSpacing: 4,
          ),

          // Quita bordes por defecto
          decoration: InputDecoration(
            hintText: hint,
            errorStyle: TextStyle(color: Colors.redAccent, fontSize: 12),
            hintStyle: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.25),
            ),

            // Elimina bordes tradicionales
            border: InputBorder.none,

            // Reduce padding vertical
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 3),
          ),
        ),

        // Línea inferior (underline)
        Container(
          height: 2,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.onSurface.withOpacity(0.25),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}
