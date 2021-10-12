// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

class UserModel2 {
  var kodeuser = "".obs;
  var username_old = "".obs;
  var username = "".obs;
  var password = "".obs;
  var nama = "".obs;
  var telepon = "".obs;
  var alamat = "".obs;
  var email = "".obs;
  var jk = "".obs;

  Map<String, dynamic> toJson() => {
        'username_old': username_old.value,
        'kodeuser': kodeuser.value,
        'username': username.value,
        'password': password.value,
        'nama': nama.value,
        'telepon': telepon.value,
        'alamat': alamat.value,
        'jk': jk.value,
        'email': email.value,
      };
}
