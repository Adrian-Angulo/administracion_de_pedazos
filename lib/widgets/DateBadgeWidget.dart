import 'package:flutter/material.dart';

class DateBadgeWidget extends StatelessWidget {
  final String dateText;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;

  const DateBadgeWidget({
    super.key,
    this.dateText = 'Hoy, 14 Oct',
    this.backgroundColor = const Color(0xFF1A2920),
    this.iconColor = const Color(0xFF5FE3A1),
    this.textColor = const Color(0xFFE8E8E8),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: BoxBorder.all(color: const Color.fromARGB(255, 114, 114, 114)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icono de calendario
          Icon(Icons.calendar_today_rounded, size: 25),
          const SizedBox(width: 12),
          // Texto de fecha
          Text(
            dateText,
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}
