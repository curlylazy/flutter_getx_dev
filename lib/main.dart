// # main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './views/my_home_page.dart';
import './views/user_ae.dart';
import './views/user_list.dart';
import './views/dashboard.dart';

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
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: DashboardPage(),
      getPages: [
        GetPage(name: '/dashboard', page: () => DashboardPage()),
        GetPage(name: '/user/list', page: () => UserList()),
        GetPage(name: '/user/ae', page: () => UserAE()),
      ],
    );
  }
}
