// import 'package:intl/intl.dart';

class StringFunction {
  // JSON Data File
  isNullOrEmpty(val) {
    bool iRes = true;
    if (val == null || val == '' || val == "null") {
      iRes = true;
    } else {
      iRes = false;
    }
    return iRes;
  }

  filterString(val) {
    var res = "";
    res = val.toString();
    return res;
  }

  filterInt(val) {
    var res = 0;
    res = int.parse(val);
    return res;
  }

  // filterRupiah(val) {
  //   var res = "";
  //   res = NumberFormat.simpleCurrency(locale: 'eu').format(val);
  //   return res;
  // }
}
