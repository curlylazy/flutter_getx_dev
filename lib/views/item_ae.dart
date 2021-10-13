import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/item_ae_controller.dart';

String jk = "";

class ItemAE extends StatelessWidget {
  ItemAE({Key? key}) : super(key: key);

  final ItemAEController ctrItemAE = Get.put(ItemAEController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(ctrItemAE.judulPage.value)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.offNamed("item/list");
            },
          ),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(height: 15),
                TextField(
                    controller: ctrItemAE.ctrKodeItem,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'masukkan kodeitem',
                        labelText: 'Kode Item'),
                    onChanged: (value) {
                      ctrItemAE.itemData.kodeitem.value = value;
                      // ctrItemAE.itemData.update((_) {
                      //   ctrItemAE.itemData.value.username = value;
                      // });
                    }),
                const SizedBox(height: 10),
                TextField(
                    controller: ctrItemAE.ctrNamaItem,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'masukkan nama item',
                        labelText: 'Nama Item'),
                    onChanged: (value) {
                      ctrItemAE.itemData.namaitem.value = value;
                    }),
                const SizedBox(height: 10),
                TextField(
                    controller: ctrItemAE.ctrKategori,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'masukkan kategori',
                        labelText: 'Kategori'),
                    onChanged: (value) {
                      ctrItemAE.itemData.kategori.value = value;
                      // ctrItemAE.itemData.update((_) {
                      //   ctrItemAE.itemData.value.nama = value;
                      // });
                    }),
                const SizedBox(height: 10),
                TextField(
                    controller: ctrItemAE.ctrHarga,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'masukkan harga',
                        labelText: 'Harga'),
                    onChanged: (value) {
                      ctrItemAE.itemData.harga.value = int.parse(value);
                      // ctrItemAE.itemData.update((_) {
                      //   ctrItemAE.itemData.value.telepon = value;
                      // });
                    }),
                const SizedBox(height: 10),
                TextField(
                    controller: ctrItemAE.ctrKeteranganItem,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'masukkan keterangan',
                        labelText: 'Keterangan'),
                    onChanged: (value) {
                      ctrItemAE.itemData.keteranganitem.value = value;
                      // ctrItemAE.itemData.update((_) {
                      //   ctrItemAE.itemData.value.alamat = value;
                      // });
                    }),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // _saveData();
                          FocusScope.of(context).unfocus();
                          ctrItemAE.onClick_SaveData();
                        },
                        child: const Text('SIMPAN',
                            style: TextStyle(color: Colors.white)),
                      )),
                )
              ],
            )));
  }
}
