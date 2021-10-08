// ignore_for_file: avoid_print, non_constant_identifier_names, unnecessary_new

import 'package:flut_getx_dev/model/user_model.dart';
import 'package:flut_getx_dev/model/pelanggan_model.dart';
import 'package:get/get.dart';

class MyHomePageController extends GetxController {
  final count = 0.obs;
  final bil_1 = 0.obs;
  final bil_2 = 0.obs;

  // final UserData = new UserModel(
  //     username: "".obs,
  //     password: "".obs,
  //     nama: "".obs,
  //     telepon: "".obs,
  //     alamat: "".obs);

  final username = "".obs;

  @override
  onInit() {
    print("hai ini di load");
    // UserData.username.value = "Dwitod";
    super.onInit();
  }

  increment() {
    count.value++;
  }

  calculateTambah() async {
    bil_1.value = 200;
  }

  setUsername() {
    username.value = "ini nih datanya.";
  }

  setUserData() {
    // UserData.nama.value = "hahahah";
  }
}
