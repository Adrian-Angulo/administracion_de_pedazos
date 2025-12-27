import 'package:flutter/material.dart';

/// Tipos de mensajes disponibles
enum MessageType {
  success, // Verde - Para éxitos como "Pedazo agregado"
  error, // Rojo - Para errores
  warning, // Naranja - Para advertencias
  info, // Azul - Para información general
  delivery, // Púrpura - Para entregas específicamente
}

/// Widget personalizable para mostrar mensajes de notificación
/// Soporta diferentes tipos, iconos personalizados y acciones
class CustomMessageWidget extends StatelessWidget {
  /// Texto principal del mensaje
  final String message;

  /// Tipo de mensaje que determina el color y icono por defecto
  final MessageType type;

  /// Icono personalizado (opcional, si no se proporciona usa el del tipo)
  final IconData? customIcon;

  /// Texto secundario opcional (más pequeño, debajo del principal)
  final String? subtitle;

  /// Duración del mensaje en pantalla (por defecto 3 segundos)
  final Duration duration;

  /// Función que se ejecuta cuando se toca el mensaje (opcional)
  final VoidCallback? onTap;

  /// Función que se ejecuta cuando se cierra el mensaje (opcional)
  final VoidCallback? onDismiss;

  /// Si se puede cerrar manualmente con botón X
  final bool dismissible;

  /// Si se debe mostrar con animación de entrada
  final bool animated;

  /// Margen personalizado
  final EdgeInsetsGeometry? margin;

  /// Si se debe mostrar como SnackBar o como widget normal
  final bool asSnackBar;

  const CustomMessageWidget({
    super.key,
    required this.message,
    required this.type,
    this.customIcon,
    this.subtitle,
    this.duration = const Duration(seconds: 3),
    this.onTap,
    this.onDismiss,
    this.dismissible = true,
    this.animated = true,
    this.margin,
    this.asSnackBar = false,
  });

  /// Factory constructor para mensaje de éxito
  factory CustomMessageWidget.success({
    required String message,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
    VoidCallback? onDismiss,
    bool dismissible = true,
    EdgeInsetsGeometry? margin,
  }) {
    return CustomMessageWidget(
      message: message,
      type: MessageType.success,
      subtitle: subtitle,
      duration: duration,
      onTap: onTap,
      onDismiss: onDismiss,
      dismissible: dismissible,
      margin: margin,
    );
  }

  /// Factory constructor para mensaje de error
  factory CustomMessageWidget.error({
    required String message,
    String? subtitle,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onTap,
    VoidCallback? onDismiss,
    bool dismissible = true,
    EdgeInsetsGeometry? margin,
  }) {
    return CustomMessageWidget(
      message: message,
      type: MessageType.error,
      subtitle: subtitle,
      duration: duration,
      onTap: onTap,
      onDismiss: onDismiss,
      dismissible: dismissible,
      margin: margin,
    );
  }

  /// Factory constructor para mensaje de entrega
  factory CustomMessageWidget.delivery({
    required String message,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
    VoidCallback? onDismiss,
    bool dismissible = true,
    EdgeInsetsGeometry? margin,
  }) {
    return CustomMessageWidget(
      message: message,
      type: MessageType.delivery,
      subtitle: subtitle,
      duration: duration,
      onTap: onTap,
      onDismiss: onDismiss,
      dismissible: dismissible,
      margin: margin,
    );
  }

  /// Factory constructor para mensaje de información
  factory CustomMessageWidget.info({
    required String message,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
    VoidCallback? onDismiss,
    bool dismissible = true,
    EdgeInsetsGeometry? margin,
  }) {
    return CustomMessageWidget(
      message: message,
      type: MessageType.info,
      subtitle: subtitle,
      duration: duration,
      onTap: onTap,
      onDismiss: onDismiss,
      dismissible: dismissible,
      margin: margin,
    );
  }

  /// Obtiene la configuración de colores según el tipo de mensaje
  MessageConfig _getMessageConfig() {
    switch (type) {
      case MessageType.success:
        return MessageConfig(
          backgroundColor: const Color(0xFF4CAF50),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: Icons.check_circle,
        );
      case MessageType.error:
        return MessageConfig(
          backgroundColor: const Color(0xFFF44336),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: Icons.error,
        );
      case MessageType.warning:
        return MessageConfig(
          backgroundColor: const Color(0xFFFF9800),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: Icons.warning,
        );
      case MessageType.info:
        return MessageConfig(
          backgroundColor: const Color(0xFF2196F3),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: Icons.info,
        );
      case MessageType.delivery:
        return MessageConfig(
          backgroundColor: const Color(0xFF9C27B0),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: Icons.local_shipping,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = _getMessageConfig();

    Widget messageWidget = Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: config.backgroundColor.withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icono
                Icon(
                  customIcon ?? config.icon,
                  color: config.iconColor,
                  size: 24,
                ),
                const SizedBox(width: 12),

                // Contenido del mensaje
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Mensaje principal
                      Text(
                        message,
                        style: TextStyle(
                          color: config.textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      // Subtítulo opcional
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            color: config.textColor.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Botón de cerrar (si es dismissible)
                if (dismissible) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onDismiss,
                    icon: Icon(Icons.close, color: config.iconColor, size: 20),
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );

    // Aplicar animación si está habilitada
    if (animated) {
      return TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 300),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, (1 - value) * 50),
            child: Opacity(opacity: value, child: child),
          );
        },
        child: messageWidget,
      );
    }

    return messageWidget;
  }

  /// Muestra el mensaje como SnackBar
  static void showSnackBar(
    BuildContext context, {
    required String message,
    required MessageType type,
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
    IconData? customIcon,
  }) {
    final config = _getConfigForType(type);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(customIcon ?? config.icon, color: config.iconColor, size: 24),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      color: config.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: config.textColor.withValues(alpha: 0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
        backgroundColor: config.backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Método estático para obtener configuración por tipo
  static MessageConfig _getConfigForType(MessageType type) {
    switch (type) {
      case MessageType.success:
        return MessageConfig(
          backgroundColor: const Color(0xFF4CAF50),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: Icons.check_circle,
        );
      case MessageType.error:
        return MessageConfig(
          backgroundColor: const Color(0xFFF44336),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: Icons.error,
        );
      case MessageType.warning:
        return MessageConfig(
          backgroundColor: const Color(0xFFFF9800),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: Icons.warning,
        );
      case MessageType.info:
        return MessageConfig(
          backgroundColor: const Color(0xFF2196F3),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: Icons.info,
        );
      case MessageType.delivery:
        return MessageConfig(
          backgroundColor: const Color(0xFF9C27B0),
          iconColor: Colors.white,
          textColor: Colors.white,
          icon: Icons.local_shipping,
        );
    }
  }
}

/// Configuración de colores e iconos para cada tipo de mensaje
class MessageConfig {
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final IconData icon;

  const MessageConfig({
    required this.backgroundColor,
    required this.iconColor,
    required this.textColor,
    required this.icon,
  });
}

/// Extensión para facilitar el uso del widget de mensajes
extension MessageExtension on BuildContext {
  /// Muestra un mensaje de éxito
  void showSuccessMessage(
    String message, {
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    CustomMessageWidget.showSnackBar(
      this,
      message: message,
      type: MessageType.success,
      subtitle: subtitle,
      duration: duration,
    );
  }

  /// Muestra un mensaje de error
  void showErrorMessage(
    String message, {
    String? subtitle,
    Duration duration = const Duration(seconds: 4),
  }) {
    CustomMessageWidget.showSnackBar(
      this,
      message: message,
      type: MessageType.error,
      subtitle: subtitle,
      duration: duration,
    );
  }

  /// Muestra un mensaje de entrega
  void showDeliveryMessage(
    String message, {
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    CustomMessageWidget.showSnackBar(
      this,
      message: message,
      type: MessageType.delivery,
      subtitle: subtitle,
      duration: duration,
    );
  }

  /// Muestra un mensaje de información
  void showInfoMessage(
    String message, {
    String? subtitle,
    Duration duration = const Duration(seconds: 3),
  }) {
    CustomMessageWidget.showSnackBar(
      this,
      message: message,
      type: MessageType.info,
      subtitle: subtitle,
      duration: duration,
    );
  }
}
