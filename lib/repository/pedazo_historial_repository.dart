import 'package:administracion_de_pedazos/models/pedazo_historial.dart';
import 'package:administracion_de_pedazos/services/database_helper.dart';

class PedazoHistorialRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Pedazohistorial>> obtenerHistorial() async {
    return await _databaseHelper.obtenerHistorial();
  }

  Future<int> registrarHistorial(Pedazohistorial pedazo) async {
    return await _databaseHelper.registrarHistorial(pedazo);
  }
}
