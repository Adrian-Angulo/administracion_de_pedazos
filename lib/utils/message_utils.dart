import 'package:flutter/material.dart';
import '../widgets/custom_message_widget.dart';

/// Utilidades para mostrar mensajes consistentes en toda la aplicación
/// Centraliza los mensajes más comunes para mantener consistencia
class MessageUtils {
  // ========== MENSAJES DE PEDAZOS ==========

  /// Muestra mensaje cuando se agrega un pedazo exitosamente
  static void showPedazoAdded(BuildContext context) {
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
      type: MessageType.info,
      subtitle: 'Pedazo #$numero eliminado de la lista',
      duration: const Duration(seconds: 3),
    );
  }

  // ========== MENSAJES DE ENTREGAS ==========

  /// Muestra mensaje cuando se entrega un solo pedazo
  static void showSingleDelivery(BuildContext context) {
    CustomMessageWidget.showSnackBar(
      context,
      message: 'Entrega realizada con exito',
      type: MessageType.success,
      duration: const Duration(seconds: 4),
    );
  }

  static bool alertConfirmation(
    BuildContext context,
    int cantidad,
   
    
  ) {
    bool confirm = false;
    AlertDialog(
      title: Text("Confirmacion"),
      content: Text("Esta seguro de entregar $cantidad"),
      actions: [
        FilledButton(
          onPressed: () {
            confirm = true;
          },
          child: Text("Si"),
        ),
        FilledButton(
          onPressed: (){},
          child: Text("No"),
        ),
      ],
    );
    return confirm;
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
