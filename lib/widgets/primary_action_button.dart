import 'package:flutter/material.dart';

/// Botón principal reutilizable para acciones importantes (CTA)
/// Ejemplo: "Registrar Nuevo Pedazo"
class PrimaryActionButton extends StatelessWidget {
  // Texto que se muestra en el botón
  final String label;

  // Ícono que acompaña al texto
  final IconData icon;

  // Acción que se ejecuta al presionar el botón
  final VoidCallback onPressed;

  const PrimaryActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Accedemos al esquema de colores definido en el ThemeData
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      // Hace que el botón ocupe todo el ancho disponible
      width: double.infinity,
      height: 56,

      child: ElevatedButton(
        // Acción del botón
        onPressed: onPressed,

        // Estilo visual del botón
        style: ElevatedButton.styleFrom(
          // Color principal (verde del dashboard)
          backgroundColor: colorScheme.primary,

          // Color del texto e ícono
          foregroundColor: Colors.black,

          // Elimina sombras exageradas (look moderno)
          elevation: 0,

          // Bordes completamente redondeados
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),

        // Contenido del botón: ícono + texto
        child: Row(
          // Centra horizontalmente el contenido
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícono de acción
            Icon(icon, size: 22),

            const SizedBox(width: 10),

            // Texto del botón
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
