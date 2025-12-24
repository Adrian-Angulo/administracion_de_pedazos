import 'package:administracion_de_pedazos/models/Pedazo.dart';
import 'package:administracion_de_pedazos/services/database_helper.dart';

class PedazoRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Pedazo>> getPedazos() async {
    return await _databaseHelper.obtenerPedazos();
  }

  Future<int> registrarPedazo(Pedazo pedazo) async {
    return await _databaseHelper.agregarPedazo(pedazo);
  }

  Future<int> eliminarPedazo(int id) async {
    return await _databaseHelper.eliminarPedazo(id);
  }
}
