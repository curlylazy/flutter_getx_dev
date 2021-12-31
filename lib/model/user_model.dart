class UserModel {
  String username;
  String password;
  String nama;
  String telepon;
  String alamat;
  String email;
  String jk;

  UserModel({
    required this.username,
    required this.password,
    required this.nama,
    required this.telepon,
    required this.jk,
    required this.email,
    required this.alamat,
  });

  toJson() => {
        'username': username,
        'password': password,
        'nama': nama,
        'telepon': telepon,
        'alamat': alamat,
        'jk': jk,
        'email': email,
      };
}
