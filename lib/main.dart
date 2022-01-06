// # main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flut_getx_dev/views/my_home_page.dart';
import 'package:flut_getx_dev/views/auth_login.dart';
import 'package:flut_getx_dev/views/user_ae.dart';
import 'package:flut_getx_dev/views/user_list.dart';
import 'package:flut_getx_dev/views/item_list.dart';
import 'package:flut_getx_dev/views/item_ae.dart';
import 'package:flut_getx_dev/views/dashboard.dart';
import 'package:flut_getx_dev/views/splashscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: SplashScreenSistem(),
      getPages: [
        GetPage(name: '/dashboard', page: () => DashboardPage()),
        GetPage(name: '/auth/login', page: () => AuthLogin()),
        GetPage(name: '/user/list', page: () => UserList()),
        GetPage(name: '/user/ae', page: () => UserAE()),
        GetPage(name: '/item/list', page: () => ItemList()),
        GetPage(name: '/item/ae', page: () => ItemAE()),
      ],
    );
  }
}
