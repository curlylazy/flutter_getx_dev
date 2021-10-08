class StringFunction {
  // JSON Data File
  isNullOrEmpty(val) {
    bool iRes = true;
    if (val == null || val == '') {
      iRes = true;
    } else {
      iRes = false;
    }
    return iRes;
  }
}
