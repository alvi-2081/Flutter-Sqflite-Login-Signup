import 'package:sqflite_app/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Database? _db;

  static const String dbName = 'test.db';
  static const String tableName = 'user';
  static const int version = 1;

  static const String dbUserID = 'user_id';
  static const String dbUserName = 'user_name';
  static const String dbEmail = 'email';
  static const String dbPassword = 'password';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    // io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    var databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, dbName);
    var db = await openDatabase(dbPath, version: version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $tableName ("
        " $dbUserID TEXT, "
        " $dbUserName TEXT, "
        " $dbEmail TEXT,"
        " $dbPassword TEXT, "
        " PRIMARY KEY ($dbUserID)"
        ")");
  }

  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(tableName, user.toMap());
    return res;
  }

  Future<UserModel?> getLoginUser(String userName, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $tableName WHERE "
        "$dbUserName = '$userName' AND "
        "$dbPassword = '$password'");

    if (res.isNotEmpty) {
      return UserModel.fromMap(res.first);
    }

    return null;
  }

  Future<int> updateUser(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.update(tableName, user.toMap(),
        where: '$dbUserID = ?', whereArgs: [user.userId]);
    return res;
  }

  Future<int> deleteUser(String user_id) async {
    var dbClient = await db;
    var res = await dbClient
        .delete(tableName, where: '$dbUserID = ?', whereArgs: [user_id]);
    return res;
  }
}
