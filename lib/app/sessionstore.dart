import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:flut_getx_dev/app/json.dart';
import 'package:flut_getx_dev/app/config.dart';
import 'package:flut_getx_dev/app/stringfunction.dart';
import 'package:flut_getx_dev/app/dialog.dart';
import 'package:flut_getx_dev/app/sqliteconnection.dart';

class SessionStore {
  var errMsg = "";
  var connStr = "";
  var conDB;
  SQLiteConnection ic = SQLiteConnection(AppConfig.APP_DB_FILE);

  getConnection() {
    return conDB;
  }

  openDB() async {
    try {
      int iRet = -1;
      String errMsg = "";

      Database conDB = await openDatabase(connStr, version: 1);
    } catch (e) {
      print("KESALAHAN:: openDB() :: ${e.toString()}");
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
      print("KESALAHAN:: onCreate() :: ${e.toString()}");
    }
  }

  onInsert(String table, value) async {
    try {
      var db = await openDBAsnyc();
      await db.insert(table, value);
    } catch (e) {
      print("KESALAHAN:: onInsert() :: ${e.toString()}");
    }
  }

  onRawInsert(String sql) async {
    try {
      var db = await openDBAsnyc();
      await db.rawInsert(sql);
    } catch (e) {
      print("KESALAHAN:: onRawInsert() :: ${e.toString()}");
    }
  }

  onRawUpdate(String sql) async {
    try {
      var db = await openDBAsnyc();
      await db.rawUpdate(sql);
    } catch (e) {
      print("KESALAHAN:: onRawUpdate() :: ${e.toString()}");
    }
  }

  onRawQuery(String sql) async {
    try {
      var db = await openDBAsnyc();
      var res = await db.rawQuery(sql);
      return res;
    } catch (e) {
      print("KESALAHAN:: onSelect() :: ${e.toString()}");
    }
  }
}
