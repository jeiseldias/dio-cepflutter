import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DatabaseRepository {
  Map<int, String> scripts = {
    1: '''
      CREATE TABLE consultas(
        cep TEXT PRIMARY KEY,
        logradouro TEXT,
        bairro TEXT,
        localidade TEXT,
        uf TEXT
      );
    ''',
  };

  static Database? db;

  Future<Database> obterDB() async {
    if (db == null) {
      return await iniciarDB();
    } else {
      return db!;
    }
  }

  Future<Database> iniciarDB() async {
    return await openDatabase(
        path.join(await getDatabasesPath(), 'database.ceps'),
        version: scripts.length, onCreate: (Database db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
      for (var i = oldVersion + 1; i <= scripts.length; i++) {
        await db.execute(scripts[i]!);
      }
    });
  }
}
