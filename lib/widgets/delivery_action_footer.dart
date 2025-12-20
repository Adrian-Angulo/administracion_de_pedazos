import 'package:flutter/material.dart';

class DeliveryActionFooter extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onRegister;
  final String? scheduleText;
  final double totalValue;

  const DeliveryActionFooter({
    super.key,
    required this.selectedCount,
    required this.onRegister,
    this.scheduleText,
    required this.totalValue,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1A14),
        border: Border(
          top: BorderSide(color: colorScheme.onSurface.withOpacity(0.2)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: 10,
              children: [
                Text(
                  "Valor total a entregar: ",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "\$ $totalValue",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: selectedCount > 0 ? onRegister : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                disabledBackgroundColor: Colors.grey.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: selectedCount > 0 ? Colors.white : Colors.grey,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    selectedCount > 0
                        ? 'Registrar Entrega ($selectedCount)'
                        : 'Selecciona al menos un pedazo',
                    style: TextStyle(
                      color: selectedCount > 0 ? Colors.white : Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
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
