// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/user_list_controller.dart';

String jk = "";

class UserList extends StatelessWidget {
  UserList({Key? key}) : super(key: key);

  final UserListController ctrUser = Get.put(UserListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("User List"),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    ctrUser.loadData(context);
                  },
                  icon: const Icon(Icons.refresh),
                )),
            Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  onPressed: () async {},
                  icon: const Icon(Icons.add),
                )),
          ],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.toNamed('/dashboard');
            },
          ),
        ),
        body: Column(children: [
          Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                const SizedBox(
                  height: 5.0,
                ),
                TextField(
                  controller: ctrUser.ctrKatakunci,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                      isDense: true,
                      border: const OutlineInputBorder(),
                      hintText: 'masukkan katakunci',
                      labelText: 'Katakunci'),
                )
              ])),
          Obx(() => Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(5.0),
                  itemCount: ctrUser.dataUser.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {},
                        child: Card(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 15, bottom: 10),
                                  child: Text(
                                      ctrUser.dataUser[index]['username'],
                                      style: TextStyle(
                                          fontSize: 15, letterSpacing: 3)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 15, bottom: 5),
                                  child: Text(ctrUser.dataUser[index]['nama'],
                                      style: TextStyle(fontSize: 16)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 15, bottom: 5),
                                  child: Text(
                                      ctrUser.dataUser[index]['telepon'],
                                      style: TextStyle(fontSize: 16)),
                                ),
                              ]),
                        ));
                  }))),
          Container(
              decoration: BoxDecoration(color: Colors.grey.shade200),
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: TextButton.icon(
                        icon: Icon(Icons.arrow_left),
                        label: Text('PREV'),
                        onPressed: () {
                          // _prevPage();
                        }),
                  ),
                  Obx(
                    () => Container(
                      alignment: Alignment.center,
                      width: 100,
                      child: Text(
                          "${ctrUser.currentpage.toString()} / ${ctrUser.totalpage..toString()}"),
                    ),
                  ),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                          icon: Icon(Icons.arrow_left),
                          label: Text('NEXT'),
                          onPressed: () {
                            // _nextPage();
                          }))
                ],
              )),
          // Expanded(
          //     child: ListView.builder(
          //         padding: const EdgeInsets.all(5.0),
          //         itemCount: 10,
          //         itemBuilder: (context, index) {
          //           return InkWell(
          //               onTap: () {},
          //               child: Card(
          //                 child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       Padding(
          //                         padding: const EdgeInsets.only(
          //                             top: 5, left: 15, bottom: 10),
          //                         child: Text("Ini Test Data",
          //                             style: TextStyle(
          //                                 fontSize: 15, letterSpacing: 3)),
          //                       ),
          //                       Padding(
          //                         padding: const EdgeInsets.only(
          //                             top: 0, left: 15, bottom: 5),
          //                         child: Text("ok ini sample",
          //                             style: TextStyle(fontSize: 16)),
          //                       ),
          //                     ]),
          //               ));
          //         })),
        ]));
  }
}
