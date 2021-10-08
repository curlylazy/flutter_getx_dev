// ignore_for_file: file_names, prefer_const_constructors, avoid_print, avoid_unnecessary_containers, unnecessary_new, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/my_home_page_controller.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final MyHomePageController controller = Get.put(MyHomePageController());

  TextEditingController ctrTxtUsername = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ctrTxtUsername.text = controller.UserData.username.value;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text(
          'You have pushed the button this many times:',
        ),
        Obx(() => Text('${controller.count.value}')),
        Obx(() => Text('Nih nilainya ${controller.bil_1.value}')),
        Obx(() => Text('User Nya adalah ${controller.username.value}')),
        // Obx(() => Text("hehe ${controller.UserData.username}")),
        Obx(() => Container(
            padding: EdgeInsets.all(10),
            child: TextField(
                controller: ctrTxtUsername,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'masukkan ${controller.username.value}',
                    labelText: 'Password'),
                onChanged: (value) {
                  // controller.UserData.username.value = value;
                }))),
        ElevatedButton(
            onPressed: () {
              controller.increment();
            },
            child: const Text("Klik Saya Dong")),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              controller.calculateTambah();
            },
            child: const Text("Kalkulasi Bilangan")),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              controller.setUsername();
            },
            child: const Text("Tampil User Data"))
      ])),
      // floatingActionButton: const FloatingActionButton(
      //   onPressed: (){ controller.increment(); },
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
