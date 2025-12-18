import 'package:flutter/material.dart';

/// Card de inputs estilo financiero moderno
/// Se puede reutilizar para "De", "Para", "Valor", etc.
class CardWidget extends StatelessWidget {
  final List<Widget> children;
  const CardWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      // Decoración principal de la card
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: colorScheme.onSurface.withOpacity(0.08)),
        /* boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ], */
      ),

      child: Column(children: children),
    );
  }
}
