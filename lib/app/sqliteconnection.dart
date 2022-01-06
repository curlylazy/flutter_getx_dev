import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteConnection {
  var errMsg = "";
  var connStr = "";
  var conDB;

  SQLiteConnection(fileLocation) {
    connStr = fileLocation;
  }

  getConnection() {
    return conDB;
  }

  openDB() async {
    try {
      int iRet = -1;
      String errMsg = "";

      Database conDB = await openDatabase(connStr, version: 1);
    } catch (e) {
      print("OpenDB() :: ${e.toString()}");
    }
  }

  Future<Database> openDBAsnyc() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, connStr);
    Database conDB = await openDatabase(path, version: 1);
    return conDB;
  }

  onCreate(String sql) async {
    try {
      var db = await openDBAsnyc();
      await db.execute(sql);
    } catch (e) {
      print("onCreate() :: ${e.toString()}");
    }
  }

  onInsert(String table, value) async {
    try {
      var db = await openDBAsnyc();
      await db.insert(table, value);
    } catch (e) {
      print("onInsert() :: ${e.toString()}");
    }
  }

  onRawInsert(String sql) async {
    try {
      var db = await openDBAsnyc();
      await db.rawInsert(sql);
    } catch (e) {
      print("onRawInsert() :: ${e.toString()}");
    }
  }

  onRawUpdate(String sql) async {
    try {
      var db = await openDBAsnyc();
      await db.rawUpdate(sql);
    } catch (e) {
      print("onRawUpdate() :: ${e.toString()}");
    }
  }

  onRawDelete(String sql) async {
    try {
      var db = await openDBAsnyc();
      await db.rawDelete(sql);
    } catch (e) {
      print("onRawDelete() :: ${e.toString()}");
    }
  }

  onRawQuery(String sql) async {
    try {
      var db = await openDBAsnyc();
      var res = await db.rawQuery(sql);
      return res;
    } catch (e) {
      print("onSelect() :: ${e.toString()}");
    }
  }

  tableExist(String tableName) async {
    Database db = await openDBAsnyc();

    String strSQL = "SELECT COUNT(*) FROM sqlite_master WHERE type = 'table' AND name = '" + tableName + "'; ";
    var count = Sqflite.firstIntValue(await db.rawQuery(strSQL));

    db.close();

    if (count == null || int.parse(count.toString()) == 0) {
      // print("tabel kosong");
      return false;
    } else {
      // print("tabel ada");
      return true;
    }
  }

  // Future<Database> initDb() async {
  //   var databasesPath = await getDatabasesPath();
  //   String path = join(databasesPath, connStr);
  //   Database conDB = await openDatabase(path, version: 1);

  //   return conDB;
  // }
}
