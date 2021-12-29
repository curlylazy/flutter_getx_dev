// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

// widget
import 'package:flut_getx_dev/widgets/widget_drawer.dart';

// controller
import 'package:flut_getx_dev/controllers/user_list_controller.dart';

String jk = "";

class UserList extends StatelessWidget {
  UserList({Key? key}) : super(key: key);

  final UserListController ctrUser = Get.put(UserListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: const Text("User List"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  ctrUser.refreshPage();
                },
                icon: const Icon(Icons.refresh),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () async {
                  Get.offNamed('/user/ae');
                },
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        body: Column(children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 5.0,
                ),
                TextField(
                  controller: ctrUser.ctrKatakunci,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          ctrUser.refreshPage();
                        },
                        icon: const Icon(Icons.search),
                      ),
                      isDense: true,
                      border: const OutlineInputBorder(),
                      hintText: 'masukkan katakunci',
                      labelText: 'Katakunci'),
                ),
              ],
            ),
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(5.0),
                itemCount: ctrUser.dataUser.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Card(
                      elevation: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 15, bottom: 10),
                            child: Text(ctrUser.dataUser[index]['username'], style: TextStyle(fontSize: 15, letterSpacing: 3)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 15, bottom: 5),
                            child: Text(ctrUser.dataUser[index]['nama'], style: TextStyle(fontSize: 16)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0, left: 15, bottom: 5),
                            child: Text(ctrUser.dataUser[index]['telepon'], style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      Get.bottomSheet(
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.grey[300]),
                          // color: Colors.grey[300],
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
                                child: Text(
                                  "Data : ${ctrUser.dataUser[index]['username']}",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                title: Text('Hapus', style: TextStyle(color: Colors.red)),
                                onTap: () async {
                                  Get.back();
                                  await ctrUser.hapusData(index);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.edit),
                                title: Text('Edit'),
                                onTap: () {
                                  Get.back();
                                  var parameters = <String, String>{
                                    "mode": "**edit",
                                    "data": ctrUser.dataUser[index]['kodeuser']
                                  };
                                  Get.offNamed("/user/ae", parameters: parameters);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.close),
                                title: Text('Cancel'),
                                onTap: () {
                                  Get.back();
                                },
                              ),
                            ],
                          ),
                        ),
                        // enableDrag: false,
                        // backgroundColor: Theme.of(context).backgroundColor,
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.only(
                        //     topLeft: Radius.circular(20.0),
                        //     topRight: Radius.circular(20.0),
                        //   ),
                        // ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Colors.grey.shade200),
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: TextButton.icon(
                    icon: Icon(Icons.arrow_left),
                    label: Text('PREV'),
                    onPressed: () {
                      ctrUser.prevPage();
                    },
                  ),
                ),
                Obx(
                  () => Container(
                    alignment: Alignment.center,
                    width: 100,
                    child: Text("${ctrUser.currentpage.toString()} / ${ctrUser.totalpage.toString()}"),
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    icon: Icon(Icons.arrow_left),
                    label: Text('NEXT'),
                    onPressed: () {
                      ctrUser.nextPage();
                    },
                  ),
                ),
              ],
            ),
          ),
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
