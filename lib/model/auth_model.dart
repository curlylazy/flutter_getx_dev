// ignore_for_file: non_constant_identifier_names

class AuthModel {
  var kodeuser = "";
  var username_old = "";
  var username = "";
  var password = "";
  var nama = "";
  var telepon = "";
  var alamat = "";
  var email = "";
  var jk = "";

  toJson() => {
        'username_old': username_old,
        'kodeuser': kodeuser,
        'username': username,
        'password': password,
        'nama': nama,
        'telepon': telepon,
        'alamat': alamat,
        'jk': jk,
        'email': email,
      };
}
