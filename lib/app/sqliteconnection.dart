import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteConnection {
  var errMsg = "";
  var connStr = "";
  var conDB;

  IConnection(fileLocation) {
    connStr = fileLocation;
  }

  GetConnection() {
    return conDB;
  }

  OpenDB() async {
    try {
      int iRet = -1;
      String errMsg = "";

      Database conDB = await openDatabase(connStr, version: 1);
    } catch (e) {
      print("OpenDB() :: ${e.toString()}");
    }
  }

  Future<Database> OpenDBAsnyc() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, connStr);
    Database conDB = await openDatabase(path, version: 1);
    return conDB;
  }

  onCreate(String sql) async {
    try {
      var db = await OpenDBAsnyc();
      await db.execute(sql);
    } catch (e) {
      print("onCreate() :: ${e.toString()}");
    }
  }

  onInsert(String table, value) async {
    try {
      var db = await OpenDBAsnyc();
      await db.insert(table, value);
    } catch (e) {
      print("onInsert() :: ${e.toString()}");
    }
  }

  onRawInsert(String sql) async {
    try {
      var db = await OpenDBAsnyc();
      await db.rawInsert(sql);
    } catch (e) {
      print("onRawInsert() :: ${e.toString()}");
    }
  }

  onRawUpdate(String sql) async {
    try {
      var db = await OpenDBAsnyc();
      await db.rawUpdate(sql);
    } catch (e) {
      print("onRawUpdate() :: ${e.toString()}");
    }
  }

  onRawQuery(String sql) async {
    try {
      var db = await OpenDBAsnyc();
      var res = await db.rawQuery(sql);
      return res;
    } catch (e) {
      print("onSelect() :: ${e.toString()}");
    }
  }

  // Future<Database> initDb() async {
  //   var databasesPath = await getDatabasesPath();
  //   String path = join(databasesPath, connStr);
  //   Database conDB = await openDatabase(path, version: 1);

  //   return conDB;
  // }
}
