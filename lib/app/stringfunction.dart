// import 'package:intl/intl.dart';

class StringFunction {
  // JSON Data File
  static isNullOrEmpty(val) {
    bool iRes = true;
    if (val == null || val == '' || val == "null") {
      iRes = true;
    } else {
      iRes = false;
    }
    return iRes;
  }

  static filterString(val) {
    String sres = "";
    if (!StringFunction.isNullOrEmpty(val)) {
      try {
        sres = val.toString();

        if (sres == 'null') {
          return "";
        }

        return sres;
      } catch (e) {
        print("ERROR readDataString :: ${e.toString()}");
        return "";
      }
    } else {
      return "";
    }
  }

  static filterInt(val) {
    int sres = 0;
    if (!StringFunction.isNullOrEmpty(val)) {
      try {
        sres = int.parse(val.toString());
        return sres;
      } catch (e) {
        print("ERROR readDataInt :: ${e.toString()}");
        return 0;
      }
    } else {
      return 0;
    }
  }

  // filterRupiah(val) {
  //   var res = "";
  //   res = NumberFormat.simpleCurrency(locale: 'eu').format(val);
  //   return res;
  // }
}
