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
}
