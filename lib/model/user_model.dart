class UserModel {
  String username;
  String password;
  String nama;
  String telepon;
  String alamat;

  UserModel(
      {required this.username,
      required this.password,
      required this.nama,
      required this.telepon,
      required this.alamat});

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'nama': nama,
        'telepon': telepon,
        'alamat': alamat,
      };
}
