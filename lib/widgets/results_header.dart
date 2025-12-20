import 'package:flutter/material.dart';

class ResultsHeader extends StatelessWidget {
  final int resultCount;
  final VoidCallback onSelectAll;
  final bool allSelected;

  const ResultsHeader({
    super.key,
    required this.resultCount,
    required this.onSelectAll,
    this.allSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$resultCount resultado${resultCount != 1 ? 's' : ''} ',
            style: TextStyle(
              color: colorScheme.onSurface.withOpacity(0.6),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: onSelectAll,
            child: Text(
              allSelected ? 'Deseleccionar todos' : 'Seleccionar todos',
              style: TextStyle(
                color: colorScheme.primary,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
