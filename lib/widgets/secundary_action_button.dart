import 'package:flutter/material.dart';

/// Botón secundario para acciones no primarias
/// Ejemplo: "Filtrar Pedazos"
class SecundaryActionButton extends StatelessWidget {
  // Texto del botón
  final String label;

  // Ícono que acompaña el texto
  final IconData icon;

  // Acción al presionar
  final VoidCallback onPressed;

  const SecundaryActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Accedemos al esquema de colores del tema
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        // Container para poder controlar fondo, borde y sombras
        child: Container(
          height: 54,
          padding: const EdgeInsets.symmetric(horizontal: 20),

          // Decoración visual del botón
          decoration: BoxDecoration(
            // Fondo oscuro tipo glass / card
            color: colorScheme.surfaceVariant,

            // Bordes totalmente redondeados (pill button)
            borderRadius: BorderRadius.circular(30),

            // Borde verde muy sutil
            border: Border.all(color: colorScheme.primary.withOpacity(0.25)),

            // Glow suave como en la imagen
            /*  boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withOpacity(0.12),
                blurRadius: 5,
                offset: const Offset(0, 0),
              ),
            ], */
          ),

          // Contenido interno del botón
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícono verde
              Icon(icon, size: 20, color: colorScheme.primary),

              const SizedBox(width: 5),

              // Texto del botón
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
