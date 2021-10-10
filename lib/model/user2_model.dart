import 'package:get/get.dart';

class UserModel2 {
  var username = "".obs;
  var password = "".obs;
  var nama = "".obs;
  var telepon = "".obs;
  var alamat = "".obs;
  var email = "".obs;
  var jk = "".obs;

  Map<String, dynamic> toJson() => {
        'username': username.value,
        'password': password.value,
        'nama': nama.value,
        'telepon': telepon.value,
        'alamat': alamat.value,
        'jk': jk.value,
        'email': email.value,
      };
}
