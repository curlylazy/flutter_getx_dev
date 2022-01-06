import 'dart:convert';

class IJson {
  var name = "";
  var tablesArr = {};
  var rowArr = {};
  var rowArrs = [];

  var rowArrFile = {};
  var rowArrsFile = [];

  // JSON Data File
  newFile() {
    name = "DataFileUpload";
  }

  addFile(rowname, value) {
    rowArrFile['rowname'] = rowname;
    rowArrFile['value'] = value;
    rowArrsFile.add(rowArrFile);
    rowArrFile = {};
  }

  createFile() {
    tablesArr[name] = rowArrsFile;
    name = "";
    rowArrsFile = [];
  }

  // JSON Data String
  newTable(tablename) {
    name = tablename;
  }

  addRow(rowname, value) {
    rowArr[rowname] = value;
  }

  endRow() {
    rowArrs.add(rowArr);
    rowArr = {};
  }

  addRowFromObject(obj) {
    rowArrs.add(obj);
    rowArr = {};
  }

  createTableFromObjectCollection(obj) {
    tablesArr[name] = obj;
    name = "";
  }

  createTable() {
    tablesArr[name] = rowArrs;
    name = "";
    rowArrs = [];
  }

  generateJson() {
    var str = jsonEncode(tablesArr);
    return str;
  }

  static jsontodata(data, name) {
    var ret = []; // error parse //
    try {
      var obj = jsonDecode(data);
      ret = obj[name];
      return ret;
    } catch (e) {
      ret = [];
      return ret;
    }
  }
}
