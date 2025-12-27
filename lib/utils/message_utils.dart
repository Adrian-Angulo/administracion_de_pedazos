import 'package:flutter/material.dart';
import '../widgets/custom_message_widget.dart';

/// Utilidades para mostrar mensajes consistentes en toda la aplicación
/// Centraliza los mensajes más comunes para mantener consistencia
class MessageUtils {
  // ========== MENSAJES DE PEDAZOS ==========

  /// Muestra mensaje cuando se agrega un pedazo exitosamente
  static void showPedazoAdded(
    BuildContext context, ) {
    CustomMessageWidget.showSnackBar(
      context,
      message: 'Pedazo registrado exitosamente',
      type: MessageType.success,
      duration: const Duration(seconds: 4),
    );
  }

  /// Muestra mensaje cuando falla el registro de un pedazo
  static void showPedazoAddError(BuildContext context, {String? errorDetails}) {
    CustomMessageWidget.showSnackBar(
      context,
      message: '❌ Error al registrar pedazo',
      type: MessageType.error,
      subtitle: errorDetails ?? 'Verifica los datos e intenta nuevamente',
      duration: const Duration(seconds: 5),
    );
  }

  /// Muestra mensaje cuando se actualiza un pedazo
  static void showPedazoUpdated(
    BuildContext context, {
    required String numero,
  }) {
    CustomMessageWidget.showSnackBar(
      context,
      message: '📝 Pedazo actualizado',
      type: MessageType.info,
      subtitle: 'Pedazo #$numero modificado correctamente',
      duration: const Duration(seconds: 3),
    );
  }

  /// Muestra mensaje cuando se elimina un pedazo
  static void showPedazoDeleted(
    BuildContext context, {
    required String numero,
  }) {
    CustomMessageWidget.showSnackBar(
      context,
      message: '🗑️ Pedazo eliminado',
      type: MessageType.warning,
      subtitle: 'Pedazo #$numero eliminado de la lista',
      duration: const Duration(seconds: 3),
    );
  }

  // ========== MENSAJES DE ENTREGAS ==========

  /// Muestra mensaje cuando se entrega un solo pedazo
  static void showSingleDelivery(
    BuildContext context, {
    required String destinatario,
    required double valor,
    required String numero,
  }) {
    CustomMessageWidget.showSnackBar(
      context,
      message: '🚚 Entrega registrada',
      type: MessageType.delivery,
      subtitle:
          'Para: $destinatario • \$${valor.toStringAsFixed(0)} • #$numero',
      duration: const Duration(seconds: 4),
    );
  }

  /// Muestra mensaje cuando se entregan múltiples pedazos
  static void showMultipleDeliveries(
    BuildContext context, {
    required int cantidad,
    required double valorTotal,
  }) {
    CustomMessageWidget.showSnackBar(
      context,
      message: '🚚 Entregas registradas',
      type: MessageType.delivery,
      subtitle:
          '$cantidad pedazo${cantidad > 1 ? 's' : ''} entregado${cantidad > 1 ? 's' : ''} • Total: \$${valorTotal.toStringAsFixed(0)}',
      duration: const Duration(seconds: 4),
    );
  }

  /// Muestra mensaje cuando falla una entrega
  static void showDeliveryError(BuildContext context, {String? errorDetails}) {
    CustomMessageWidget.showSnackBar(
      context,
      message: '❌ Error en la entrega',
      type: MessageType.error,
      subtitle: errorDetails ?? 'No se pudo registrar la entrega',
      duration: const Duration(seconds: 5),
    );
  }

}
