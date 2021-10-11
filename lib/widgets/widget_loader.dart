import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetLoader extends GetxController {
  showLoaderDialog(BuildContext context, {String pesan = ""}) {
    String msgPesan = "";
    if (pesan == "") {
      msgPesan = "Loading..";
    } else {
      msgPesan = pesan;
    }

    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 25), child: Text(msgPesan)),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  hideDialog(BuildContext context) {
    Navigator.of(context).pop();
  }
}
