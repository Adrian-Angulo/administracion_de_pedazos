import 'package:administracion_de_pedazos/models/Pedazo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;
  static const String _tableName = 'pedazo';

  Future<Database> get database async {
    // Si la DB ya existe, la retorna
    if (_database != null) return _database!;

    // Si no, la inicializa
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    String path = join(await getDatabasesPath(), 'pedazos.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        // SQL para crear la tabla
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, remitente TEXT, destinatario TEXT, valor REAL, numero TEXT )',
        );
      },
    );
  }

  // 📝 INSERTAR
  Future<int> agregarPedazo(Pedazo pedazo) async {
    final db = await database;
    return await db.insert(
      _tableName,
      pedazo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // 📚 CONSULTAR (Todos los pedazos)
  Future<List<Pedazo>> obtenerPedazos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    // Mapea la lista de Maps a una lista de objetos Pedazo
    return List.generate(maps.length, (i) {
      return Pedazo(
        maps[i]['id'],
        remitente: maps[i]['remitente'],
        destinatario: maps[i]['destinatario'],
        valor: maps[i]['valor'],
        numero: maps[i]['numero'],
      );
    });
  }

  // 🗑️ ELIMINAR
  Future<int> eliminarPedazo(int id) async {
    final db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  
}
