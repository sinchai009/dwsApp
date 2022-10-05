import 'package:dwrapp/models/sqlite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = 'dwsapp.db';
  final String tableDatbase = 'noti';
  final int versionDatabase = 1;

  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnBody = 'body';

  SQLiteHelper() {
    initalDatabase();
  }

  Future<void> initalDatabase() async {
    await openDatabase(join(await getDatabasesPath(), nameDatabase),
        onCreate: (db, version) => db.execute(
            'CREATE TABLE $tableDatbase (id INTEGER PRIMARY KEY, $columnTitle TEXT, $columnBody TEXT)'),
        version: versionDatabase);
  }

  Future<Database> connectedDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), nameDatabase),
    );
  }

  Future<void> insertValueToDatabase({required SQLiteModel sqLiteModel}) async {
    Database database = await connectedDatabase();
    database.insert(
      tableDatbase,
      sqLiteModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<SQLiteModel>> readAllDatabase() async {
    Database database = await connectedDatabase();
    var sqliteModels = <SQLiteModel>[];

    var maps = await database.query(tableDatbase);
    for (var element in maps) {
      SQLiteModel model = SQLiteModel.fromMap(element);
      sqliteModels.add(model);
    }

    return sqliteModels;
  }

  Future<void> deleteValueWhereId({required int idDelete}) async {
    Database database = await connectedDatabase();
    database.delete(
      tableDatbase,
      where: '$columnId =$idDelete',
    );
  }
}
