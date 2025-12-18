import 'package:flutter/material.dart';

/// Fila con icono + label + input
/// Usado para: De, Para, etc.
class Input extends StatelessWidget {
  // Ícono del CircleAvatar
  final IconData icon;

  // Texto superior (ej: "De (Remitente)")
  final String label;

  // Placeholder del input
  final String hint;

  // Controller del TextField
  final TextEditingController? controller;

  // Tipo de teclado
  final TextInputType keyboardType;

  const Input({
    super.key,
    required this.icon,
    required this.label,
    required this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          // Icono circular
          CircleAvatar(
            backgroundColor: Color.fromRGBO(17, 33, 23, 2),
            child: Icon(icon, color: Colors.white),
          ),

          const SizedBox(width: 16),

          // Label + Input
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Texto pequeño superior
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface.withOpacity(0.55),
                  ),
                ),

                const SizedBox(height: 4),

                // Input
                TextFormField(
                  controller: controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Este campo es obligatorio';
                    }
                    return null;
                  },
                  keyboardType: keyboardType,

                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface.withOpacity(0.85),
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(
                      color: colorScheme.onSurface.withOpacity(0.35),
                    ),
                    errorStyle: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
