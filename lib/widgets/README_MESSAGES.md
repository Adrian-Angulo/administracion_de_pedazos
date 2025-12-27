# Sistema de Mensajes Personalizados

Este sistema proporciona widgets y utilidades para mostrar mensajes consistentes y atractivos en toda la aplicación.

## Componentes Principales

### 1. CustomMessageWidget
Widget principal para mostrar mensajes con diferentes estilos y comportamientos.

### 2. MessageUtils
Clase de utilidades con métodos predefinidos para los mensajes más comunes.

### 3. MessageType (Enum)
Define los tipos de mensajes disponibles:
- `success` - Verde (éxitos)
- `error` - Rojo (errores)
- `warning` - Naranja (advertencias)
- `info` - Azul (información)
- `delivery` - Púrpura (entregas)

## Uso Básico

### Como SnackBar (Recomendado)

```dart
// Usando la extensión del contexto
context.showSuccessMessage('Pedazo agregado exitosamente');
context.showErrorMessage('Error al guardar');
context.showDeliveryMessage('Entrega registrada');
context.showInfoMessage('Datos actualizados');

// Usando MessageUtils (más opciones)
MessageUtils.showPedazoAdded(
  context,
  destinatario: 'Adrian',
  remitente: 'Carlos',
  valor: 20000,
  numero: '404',
);
```

### Como Widget en la UI

```dart
Column(
  children: [
    CustomMessageWidget.success(
      message: 'Operación exitosa',
      subtitle: 'Los datos se guardaron correctamente',
      onTap: () => print('Mensaje tocado'),
    ),
    CustomMessageWidget.error(
      message: 'Error de validación',
      subtitle: 'Revisa los campos marcados',
    ),
  ],
)
```

## Ejemplos de Uso por Categoría

### Mensajes de Pedazos

```dart
// Pedazo agregado exitosamente
MessageUtils.showPedazoAdded(
  context,
  destinatario: 'Diana',
  remitente: 'Carlos',
  valor: 15000,
  numero: '789',
);

// Error al agregar pedazo
MessageUtils.showPedazoAddError(
  context,
  errorDetails: 'El número ya existe',
);

// Pedazo actualizado
MessageUtils.showPedazoUpdated(
  context,
  numero: '404',
);

// Pedazo eliminado
MessageUtils.showPedazoDeleted(
  context,
  numero: '404',
);
```

### Mensajes de Entregas

```dart
// Entrega individual
MessageUtils.showSingleDelivery(
  context,
  destinatario: 'Adrian',
  valor: 20000,
  numero: '404',
);

// Entregas múltiples
MessageUtils.showMultipleDeliveries(
  context,
  cantidad: 3,
  valorTotal: 45000,
);

// Error en entrega
MessageUtils.showDeliveryError(
  context,
  errorDetails: 'No se pudo conectar con el servidor',
);
```

### Mensajes de Base de Datos

```dart
// Datos cargados
MessageUtils.showDataLoaded(
  context,
  totalPedazos: 12,
);

// Datos sincronizados
MessageUtils.showDataSynced(
  context,
  totalPedazos: 15,
  totalEntregas: 8,
);

// Datos limpiados
MessageUtils.showDataCleared(context);

// Error de base de datos
MessageUtils.showDatabaseError(
  context,
  errorDetails: 'Error de conexión SQLite',
);
```

### Mensajes de Validación

```dart
// Error de validación específico
MessageUtils.showValidationError(
  context,
  field: 'Número',
  error: 'Debe tener 3 dígitos',
);

// Número duplicado
MessageUtils.showDuplicateNumber(
  context,
  numero: '404',
);

// Campos requeridos
MessageUtils.showRequiredFields(
  context,
  fields: ['Remitente', 'Destinatario', 'Valor'],
);
```

### Mensajes de Búsqueda

```dart
// Sin resultados
MessageUtils.showNoResults(
  context,
  query: 'Adrian',
);

// Resultados encontrados
MessageUtils.showSearchResults(
  context,
  resultCount: 5,
  query: 'Adrian',
);
```

## Personalización Avanzada

### Widget Personalizado

```dart
CustomMessageWidget(
  message: 'Mensaje personalizado',
  type: MessageType.success,
  customIcon: Icons.star,
  subtitle: 'Con icono personalizado',
  duration: Duration(seconds: 5),
  dismissible: true,
  animated: true,
  onTap: () => print('Tocado'),
  onDismiss: () => print('Cerrado'),
  margin: EdgeInsets.all(20),
)
```

### Factory Constructors

```dart
// Mensaje de éxito
CustomMessageWidget.success(
  message: 'Operación exitosa',
  subtitle: 'Todo salió bien',
  duration: Duration(seconds: 4),
);

// Mensaje de error
CustomMessageWidget.error(
  message: 'Error crítico',
  subtitle: 'Contacta al soporte',
  duration: Duration(seconds: 6),
);

// Mensaje de entrega
CustomMessageWidget.delivery(
  message: 'Entrega completada',
  subtitle: '5 pedazos entregados',
);

// Mensaje de información
CustomMessageWidget.info(
  message: 'Actualización disponible',
  subtitle: 'Versión 2.0 lista para descargar',
);
```

## Integración en Pantallas

### En Formularios

```dart
// Después de validar formulario
if (!_formKey.currentState!.validate()) {
  List<String> camposVacios = [];
  if (_nombreController.text.isEmpty) camposVacios.add('Nombre');
  if (_valorController.text.isEmpty) camposVacios.add('Valor');
  
  MessageUtils.showRequiredFields(context, fields: camposVacios);
  return;
}

// Después de guardar exitosamente
MessageUtils.showPedazoAdded(
  context,
  destinatario: _destinatarioController.text,
  remitente: _remitenteController.text,
  valor: double.parse(_valorController.text),
  numero: _numeroController.text,
);
```

### En Operaciones Asíncronas

```dart
Future<void> _guardarDatos() async {
  try {
    // Mostrar loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    await _repository.guardar(datos);
    
    Navigator.pop(context); // Cerrar loading
    
    // Mostrar éxito
    MessageUtils.showSuccess(
      context,
      message: 'Datos guardados',
      subtitle: 'La información se guardó correctamente',
    );
    
  } catch (e) {
    Navigator.pop(context); // Cerrar loading
    
    // Mostrar error
    MessageUtils.showError(
      context,
      message: 'Error al guardar',
      subtitle: e.toString(),
    );
  }
}
```

### En Listas y Búsquedas

```dart
// Después de una búsqueda
final resultados = await _buscar(query);

if (resultados.isEmpty) {
  MessageUtils.showNoResults(context, query: query);
} else {
  MessageUtils.showSearchResults(
    context,
    resultCount: resultados.length,
    query: query,
  );
}
```

## Configuración de Colores

Los colores están predefinidos pero se pueden personalizar:

```dart
// En MessageConfig
MessageConfig(
  backgroundColor: Color(0xFF4CAF50), // Verde para éxito
  iconColor: Colors.white,
  textColor: Colors.white,
  icon: Icons.check_circle,
)
```

## Mejores Prácticas

### ✅ Hacer

1. **Usar MessageUtils** para mensajes comunes
2. **Proporcionar contexto** en los subtítulos
3. **Usar duraciones apropiadas** (3s para info, 5s para errores)
4. **Ser consistente** con los tipos de mensajes
5. **Incluir detalles útiles** en los subtítulos

```dart
// ✅ Bueno
MessageUtils.showPedazoAdded(
  context,
  destinatario: 'Adrian',
  remitente: 'Carlos',
  valor: 20000,
  numero: '404',
);

// ✅ Bueno
MessageUtils.showError(
  context,
  message: 'Error de conexión',
  subtitle: 'Verifica tu internet e intenta nuevamente',
);
```

### ❌ Evitar

1. **Mensajes muy largos** sin subtítulos
2. **Duraciones muy cortas** para errores importantes
3. **Usar tipos incorrectos** (error para advertencias)
4. **Mensajes sin contexto**

```dart
// ❌ Malo
context.showErrorMessage('Error'); // Sin contexto

// ❌ Malo
CustomMessageWidget.success(
  message: 'Este es un mensaje muy largo que no debería estar en el título principal porque es difícil de leer',
); // Muy largo, debería usar subtitle
```

## Extensiones Futuras

- Soporte para temas personalizados
- Animaciones más complejas
- Sonidos de notificación
- Persistencia de mensajes importantes
- Integración con notificaciones push