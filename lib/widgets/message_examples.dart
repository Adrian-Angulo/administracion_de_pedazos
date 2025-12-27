import 'package:flutter/material.dart';
import 'custom_message_widget.dart';

/// Ejemplos de uso del CustomMessageWidget
/// Demuestra diferentes formas de implementar mensajes en la aplicación
class MessageExamples extends StatelessWidget {
  const MessageExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplos de Mensajes'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              'Ejemplos de Mensajes Personalizados',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Sección 1: Mensajes como widgets
            _buildSection(context, 'Mensajes como Widgets', [
              CustomMessageWidget.success(
                message: 'Pedazo agregado exitosamente',
                subtitle: 'El pedazo se guardó en la base de datos',
                onTap: () => _showDialog(context, 'Mensaje de éxito tocado'),
              ),

              CustomMessageWidget.delivery(
                message: 'Entrega registrada',
                subtitle: '3 pedazos entregados por \$45,000',
                onTap: () => _showDialog(context, 'Mensaje de entrega tocado'),
              ),

              CustomMessageWidget.error(
                message: 'Error al guardar',
                subtitle: 'Verifica tu conexión e intenta nuevamente',
                onTap: () => _showDialog(context, 'Mensaje de error tocado'),
              ),

              CustomMessageWidget.info(
                message: 'Información importante',
                subtitle: 'Los datos se sincronizan automáticamente',
                onTap: () => _showDialog(context, 'Mensaje de info tocado'),
              ),
            ]),

            const SizedBox(height: 30),

            // Sección 2: Botones para SnackBars
            _buildSection(context, 'Mensajes como SnackBars', [
              _buildActionButton(
                context,
                'Mostrar Éxito',
                Colors.green,
                () => context.showSuccessMessage(
                  'Pedazo registrado correctamente',
                  subtitle: 'Para: Adrian - Valor: \$20,000',
                ),
              ),

              _buildActionButton(
                context,
                'Mostrar Entrega',
                Colors.purple,
                () => context.showDeliveryMessage(
                  'Entregas completadas',
                  subtitle: '5 pedazos entregados hoy',
                ),
              ),

              _buildActionButton(
                context,
                'Mostrar Error',
                Colors.red,
                () => context.showErrorMessage(
                  'Error de validación',
                  subtitle: 'El número de pedazo ya existe',
                ),
              ),

              _buildActionButton(
                context,
                'Mostrar Info',
                Colors.blue,
                () => context.showInfoMessage(
                  'Base de datos actualizada',
                  subtitle: 'Última sincronización: hace 2 minutos',
                ),
              ),
            ]),

            const SizedBox(height: 30),

            // Sección 3: Mensajes personalizados
            _buildSection(context, 'Mensajes Personalizados', [
              CustomMessageWidget(
                message: 'Mensaje con icono personalizado',
                type: MessageType.success,
                customIcon: Icons.star,
                subtitle: 'Este mensaje usa un icono de estrella',
                onTap: () => _showDialog(context, 'Mensaje personalizado'),
              ),

              CustomMessageWidget(
                message: 'Mensaje no dismissible',
                type: MessageType.warning,
                subtitle: 'Este mensaje no se puede cerrar manualmente',
                dismissible: false,
                onTap: () => _showDialog(context, 'Mensaje sin botón cerrar'),
              ),
            ]),

            const SizedBox(height: 30),

            // Sección 4: Casos de uso reales
            _buildSection(context, 'Casos de Uso Reales', [
              _buildActionButton(
                context,
                'Simular Registro de Pedazo',
                Colors.green,
                () => _simulateAddPedazo(context),
              ),

              _buildActionButton(
                context,
                'Simular Entrega Múltiple',
                Colors.purple,
                () => _simulateMultipleDelivery(context),
              ),

              _buildActionButton(
                context,
                'Simular Error de Validación',
                Colors.red,
                () => _simulateValidationError(context),
              ),

              _buildActionButton(
                context,
                'Simular Carga de Datos',
                Colors.blue,
                () => _simulateDataLoad(context),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  /// Construye una sección con título y contenido
  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        ...children.map(
          (child) =>
              Padding(padding: const EdgeInsets.only(bottom: 8), child: child),
        ),
      ],
    );
  }

  /// Construye un botón de acción
  Widget _buildActionButton(
    BuildContext context,
    String label,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label),
      ),
    );
  }

  /// Muestra un diálogo simple
  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Acción'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// Simula el registro de un pedazo
  void _simulateAddPedazo(BuildContext context) {
    // Simular proceso de guardado
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context); // Cerrar loading

      // Mostrar mensaje de éxito
      context.showSuccessMessage(
        'Pedazo registrado exitosamente',
        subtitle: 'Para: Diana - De: Carlos - Valor: \$15,000 - Número: 789',
        duration: const Duration(seconds: 4),
      );
    });
  }

  /// Simula entrega múltiple
  void _simulateMultipleDelivery(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pop(context);

      context.showDeliveryMessage(
        'Entregas registradas correctamente',
        subtitle: '3 pedazos entregados - Total: \$38,000',
        duration: const Duration(seconds: 4),
      );
    });
  }

  /// Simula error de validación
  void _simulateValidationError(BuildContext context) {
    context.showErrorMessage(
      'Error de validación',
      subtitle: 'El número 404 ya está registrado. Usa otro número.',
      duration: const Duration(seconds: 5),
    );
  }

  /// Simula carga de datos
  void _simulateDataLoad(BuildContext context) {
    context.showInfoMessage(
      'Datos actualizados',
      subtitle: 'Se cargaron 12 pedazos desde la base de datos',
      duration: const Duration(seconds: 3),
    );
  }
}

/// Clase helper para usar mensajes en toda la aplicación
class AppMessages {
  /// Mensaje cuando se agrega un pedazo exitosamente
  static void showPedazoAdded(
    BuildContext context, {
    required String destinatario,
    required String remitente,
    required double valor,
    required String numero,
  }) {
    context.showSuccessMessage(
      'Pedazo registrado exitosamente',
      subtitle:
          'Para: $destinatario - De: $remitente - \$${valor.toStringAsFixed(0)} - #$numero',
    );
  }

  /// Mensaje cuando se entregan pedazos
  static void showPedazosDelivered(
    BuildContext context, {
    required int cantidad,
    required double valorTotal,
  }) {
    context.showDeliveryMessage(
      'Entrega${cantidad > 1 ? 's' : ''} registrada${cantidad > 1 ? 's' : ''}',
      subtitle:
          '$cantidad pedazo${cantidad > 1 ? 's' : ''} entregado${cantidad > 1 ? 's' : ''} - Total: \$${valorTotal.toStringAsFixed(0)}',
    );
  }

  /// Mensaje de error genérico
  static void showError(
    BuildContext context, {
    required String error,
    String? details,
  }) {
    context.showErrorMessage(
      error,
      subtitle: details,
      duration: const Duration(seconds: 5),
    );
  }

  /// Mensaje de información
  static void showInfo(
    BuildContext context, {
    required String message,
    String? details,
  }) {
    context.showInfoMessage(message, subtitle: details);
  }

  /// Mensaje cuando se actualiza la base de datos
  static void showDataUpdated(
    BuildContext context, {
    required int totalPedazos,
  }) {
    context.showInfoMessage(
      'Datos actualizados',
      subtitle: 'Total de pedazos: $totalPedazos',
    );
  }

  /// Mensaje cuando se limpia la base de datos
  static void showDataCleared(BuildContext context) {
    context.showInfoMessage(
      'Datos limpiados',
      subtitle: 'Todos los pedazos han sido eliminados',
    );
  }
}
