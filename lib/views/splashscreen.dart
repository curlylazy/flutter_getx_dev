import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:flut_getx_dev/controllers/splashscreen_controller.dart';

class SplashScreenSistem extends StatelessWidget {
  SplashScreenSistem({Key? key}) : super(key: key);

  final SplashScreenController ctrSplashScreen = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(50),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.blue.shade100,
              Colors.blue.shade800,
              Colors.blue.shade400
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white60,
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: const [
                  Center(
                    child: Text(
                      "selamat datang",
                      style: TextStyle(letterSpacing: 2, fontSize: 18),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Sistem Informasi",
                      style: TextStyle(letterSpacing: 2, fontSize: 28),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: LoadingIndicator(
                      indicatorType: Indicator.ballBeat,
                      colors: [
                        Colors.blue,
                        Colors.red,
                        Colors.yellow,
                        Colors.green,
                      ],
                      strokeWidth: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
