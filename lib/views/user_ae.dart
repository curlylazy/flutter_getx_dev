import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_ae_controller.dart';

String jk = "";

class UserAE extends StatelessWidget {
  UserAE({Key? key}) : super(key: key);

  final UserAEController ctrUserAE = Get.put(UserAEController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Tambah"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 15),
                TextField(
                    controller: ctrUserAE.ctrUsername,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'masukkan username',
                        labelText: 'Username'),
                    onChanged: (value) {
                      ctrUserAE.UserData.username.value = value;
                      // ctrUserAE.UserData.update((_) {
                      //   ctrUserAE.UserData.value.username = value;
                      // });
                    }),
                const SizedBox(height: 10),
                TextField(
                    controller: ctrUserAE.ctrPassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'masukkan password',
                        labelText: 'Password'),
                    onChanged: (value) {
                      ctrUserAE.UserData.password.value = value;
                    }),
                const SizedBox(height: 10),
                TextField(
                    controller: ctrUserAE.ctrNama,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'masukkan nama',
                        labelText: 'Nama'),
                    onChanged: (value) {
                      ctrUserAE.UserData.nama.value = value;
                      // ctrUserAE.UserData.update((_) {
                      //   ctrUserAE.UserData.value.nama = value;
                      // });
                    }),
                const SizedBox(height: 10),
                TextField(
                    controller: ctrUserAE.ctrTelepon,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'masukkan telepon',
                        labelText: 'Telepon'),
                    onChanged: (value) {
                      ctrUserAE.UserData.telepon.value = value;
                      // ctrUserAE.UserData.update((_) {
                      //   ctrUserAE.UserData.value.telepon = value;
                      // });
                    }),
                const SizedBox(height: 10),
                TextField(
                    controller: ctrUserAE.ctrAlamat,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'masukkan alamat',
                        labelText: 'Alamat'),
                    onChanged: (value) {
                      ctrUserAE.UserData.alamat.value = value;
                      // ctrUserAE.UserData.update((_) {
                      //   ctrUserAE.UserData.value.alamat = value;
                      // });
                    }),
                const SizedBox(height: 10),
                TextField(
                    controller: ctrUserAE.ctrEmail,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'masukkan email',
                        labelText: 'Email'),
                    onChanged: (value) {
                      ctrUserAE.UserData.email.value = value;
                      // ctrUserAE.UserData.update((_) {
                      //   ctrUserAE.UserData.value.email = value;
                      // });
                    }),
                const SizedBox(height: 10),
                Container(
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(3)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Jenis Kelamin"),
                          ),
                          Obx(() => RadioListTile(
                                value: "L",
                                dense: true,
                                groupValue: ctrUserAE.UserData.jk.value,
                                // groupValue: ctrUserAE.UserData.value.jk,
                                title: const Text("Laki-laki"),
                                activeColor: Colors.blue,
                                onChanged: (value) {
                                  ctrUserAE.UserData.email.value =
                                      value.toString();
                                  // ctrUserAE.UserData.update((_) {
                                  //   ctrUserAE.UserData.value.jk =
                                  //       value.toString();
                                  // });
                                },
                              )),
                          Obx(() => RadioListTile(
                                value: "P",
                                dense: true,
                                // groupValue: ctrUserAE.UserData.value.jk,
                                groupValue: ctrUserAE.UserData.jk.value,
                                title: const Text("Perempuan"),
                                activeColor: Colors.blue,
                                onChanged: (value) {
                                  ctrUserAE.UserData.jk.value =
                                      value.toString();
                                  // ctrUserAE.UserData.update((_) {
                                  //   ctrUserAE.UserData.value.jk =
                                  //       value.toString();
                                  // });
                                },
                              )),
                        ])),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // _saveData();
                          ctrUserAE.onClick_SaveData(context);
                        },
                        child: const Text('SIMPAN',
                            style: TextStyle(color: Colors.white)),
                      )),
                )
              ],
            )));
  }
}
