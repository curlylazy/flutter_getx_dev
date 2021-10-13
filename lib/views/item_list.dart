// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/item_list_controller.dart';

class ItemList extends StatelessWidget {
  ItemList({Key? key}) : super(key: key);

  final ItemListController ctrItem = Get.put(ItemListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Item List"),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 0.0),
                child: IconButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    ctrItem.refreshPage();
                  },
                  icon: const Icon(Icons.refresh),
                )),
            Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  onPressed: () async {
                    Get.offNamed('/item/ae');
                  },
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
                  controller: ctrItem.ctrKatakunci,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          ctrItem.refreshPage();
                        },
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
                  itemCount: ctrItem.dataItem.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () async {
                          Get.bottomSheet(Container(
                              // height: 200,
                              color: Colors.grey[300],
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 15, left: 15, bottom: 5),
                                      child: Text(
                                          "Data : ${ctrItem.dataItem[index]['namaitem']}",
                                          style: TextStyle(fontSize: 17))),
                                  ListTile(
                                    leading: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    title: Text('Hapus',
                                        style: TextStyle(color: Colors.red)),
                                    onTap: () async {
                                      Get.back();
                                      await ctrItem.hapusData(index);
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('Edit'),
                                    onTap: () {
                                      Get.back();
                                      var parameters = <String, String>{
                                        "mode": "**edit",
                                        "data": ctrItem.dataItem[index]
                                            ['kodeitem']
                                      };
                                      Get.offNamed("/item/ae",
                                          parameters: parameters);
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
                              )));
                        },
                        child: Card(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 15, bottom: 10),
                                  child: Text(
                                      ctrItem.dataItem[index]['kodeitem'],
                                      style: TextStyle(
                                          fontSize: 15, letterSpacing: 3)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 15, bottom: 5),
                                  child: Text(
                                      ctrItem.dataItem[index]['kategori'],
                                      style: TextStyle(fontSize: 16)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 0, left: 15, bottom: 5),
                                  child: Text(
                                      ctrItem.dataItem[index]['namaitem'],
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
                  TextButton.icon(
                      icon: Icon(Icons.arrow_left),
                      label: Text('PREV'),
                      onPressed: () {
                        ctrItem.prevPage();
                      }),
                  Obx(
                    () => Container(
                      alignment: Alignment.center,
                      width: 100,
                      child: Text(
                          "${ctrItem.currentpage.toString()} / ${ctrItem.totalpage.toString()}"),
                    ),
                  ),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextButton.icon(
                          icon: Icon(Icons.arrow_left),
                          label: Text('NEXT'),
                          onPressed: () {
                            ctrItem.nextPage();
                          }))
                ],
              )),
        ]));
  }
}
