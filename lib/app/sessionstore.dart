import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:flut_getx_dev/app/config.dart';
import 'package:flut_getx_dev/app/stringfunction.dart';
import 'package:flut_getx_dev/app/sqliteconnection.dart';

// model
import 'package:flut_getx_dev/model/return_model.dart';

class SessionStore {
  SQLiteConnection sqLite = SQLiteConnection(AppConfig.APP_DB_FILE);

  cekSessionLogin() async {
    try {
      bool isLogin = false;
      var strSQL = "";

      strSQL = "SELECT * FROM tbl_session";
      List res = await sqLite.onRawQuery(strSQL);

      if (res.isNotEmpty) {
        isLogin = true;
        retriveSessionLogin(kodeuser: res[0]['kodeuser'], username: res[0]['username'], nama: res[0]['nama']);
      }

      return isLogin;
    } catch (e) {
      var ret = ReturnModel();
      ret.Number = 1;
      ret.Message = "cekSessionLogin() :: ${e.toString()}";
      return ret;
    }
  }

  retriveSessionLogin({kodeuser, username, nama}) {
    GetStorage().write("kodeuser", kodeuser);
    GetStorage().write("username", username);
    GetStorage().write("nama", nama);
  }

  removeSessionLogin() async {
    try {
      var ret = ReturnModel();

      bool isLogin = false;
      var strSQL = "";

      // hapus data terlebih dahulu
      strSQL = "DELETE FROM tbl_session WHERE kodeuser = '${GetStorage().read("kodeuser")}'";
      await sqLite.onRawDelete(strSQL);

      ret.Number = 0;
      return ret;
    } catch (e) {
      var ret = ReturnModel();
      ret.Number = 1;
      ret.Message = "cekSessionLogin() :: ${e.toString()}";
      return ret;
    }
  }

  setSessionLogin(res) async {
    try {
      var ret = ReturnModel();

      res = res['DataUser'];
      var kodeuser = res['kodeuser'];
      var username = res['username'];
      var nama = res['nama'];

      if (StringFunction.isNullOrEmpty(kodeuser)) {
        ret.Number = 1;
        ret.Message = "[kodeuser] masih kosong";
        return ret;
      }

      var strSQL = "";

      strSQL = " CREATE TABLE IF NOT EXISTS tbl_session(kodeuser varchar(100), username varchar(100), nama varchar(100)); ";
      await sqLite.onCreate(strSQL);

      // hapus data terlebih dahulu
      await sqLite.onRawDelete("DELETE FROM tbl_session WHERE kodeuser = '$kodeuser';");

      // masukkan data user login
      strSQL = "INSERT INTO tbl_session(kodeuser, username, nama) VALUES('$kodeuser', '$username', '$nama');";
      await sqLite.onRawInsert(strSQL);

      retriveSessionLogin(kodeuser: kodeuser, username: username, nama: nama);

      ret.Number = 0;
      return ret;
    } catch (e) {
      var ret = ReturnModel();
      ret.Number = 1;
      ret.Message = "setSessionLogin() :: ${e.toString()}";
      return ret;
    }
  }
}
