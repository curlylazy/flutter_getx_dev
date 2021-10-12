// import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DialogAlert {
  bool isShowProgressDialog = false;

  alertCustom(String msg, BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: const Text("INFORMASI",
          style: TextStyle(fontSize: 12, letterSpacing: 2)),
      content: Text(msg),
      actions: [
        TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  confirmDialog(String judul, String msg) async {
    return Get.dialog(
        AlertDialog(
          title: Text(judul, style: const TextStyle(fontSize: 12)),
          content: Text(msg),
          actions: <Widget>[
            TextButton(
              child: const Text("CANCEL"),
              style: TextButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Get.back(result: false);
              },
            ),
            TextButton(
              child: const Text("YA"),
              onPressed: () {
                Get.back(result: true);
              },
            )
          ],
        ),
        barrierDismissible: false);

    // print(result);
  }

  proggresDialogShow({var pesan = ""}) {
    isShowProgressDialog = true;
    var msgPesan = "";
    if (pesan == "") {
      msgPesan = "Loading..";
    } else {
      msgPesan = pesan;
    }

    Get.dialog(AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 25), child: Text(msgPesan)),
        ],
      ),
    ));
  }

  proggresDialogHide() {
    if (isShowProgressDialog) {
      isShowProgressDialog = false;
      Get.back();
    }
  }

  confirmAlertDialog(BuildContext context, String title, String msg) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop(false);
      },
    );
    Widget continueButton = TextButton(
      child: const Text("Ya"),
      onPressed: () {
        Navigator.of(context).pop(true);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((valueFromDialog) {
      // use the value as you wish
      return valueFromDialog;
    });
  }

  snackbarError(String msg) {
    Get.snackbar("KESALAHAN", msg,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error, color: Colors.white),
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 6),
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutBack);
  }

  snackbarSuccess(String msg) {
    Get.snackbar("INFORMASI", msg,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.error, color: Colors.white),
        backgroundColor: Colors.green,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        duration: const Duration(seconds: 6),
        isDismissible: true,
        dismissDirection: SnackDismissDirection.HORIZONTAL,
        forwardAnimationCurve: Curves.easeOutBack);
  }
}
