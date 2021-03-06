import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flut_getx_dev/controllers/auth_controller.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  final AuthController ctrAuth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          bannerHeader(),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: [
                menuData2('Data User', 'assets/images/014-customer service.png', '/user/list'),
                menuData2('Data Pelanggan', 'assets/images/009-courier.png', '/pelanggan/list'),
                menuData2('Data Item', 'assets/images/016-chicken bucket.png', '/item/list'),
                menuLogOut2(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       body: Center(
  //     child: Column(children: [
  //       bannerHeader(),
  //       const SizedBox(height: 10),
  //       Row(mainAxisAlignment: MainAxisAlignment.start, children: [
  //         menuData(context, 'Data User', 'assets/images/014-customer service.png', '/user/list'),
  //         menuData(context, 'Data Pelanggan', 'assets/images/009-courier.png', '/pelanggan/list'),
  //         menuData(context, 'Data Item', 'assets/images/002-french fries.png', '/item/list'),
  //       ]),
  //       Row(mainAxisAlignment: MainAxisAlignment.start, children: [
  //         menuLogOut()
  //       ]),
  //     ]),
  //   ));
  // }

  Widget testContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: 100,
      color: Colors.blueAccent[400],
    );
  }

  Widget menuData2(String judulmenu, String iconmenu, String url) {
    return InkWell(
      onTap: () {
        Get.toNamed(url);
      },
      child: Card(
        elevation: 18.0,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade300,
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconmenu,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                judulmenu,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87, letterSpacing: 2),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget menuLogOut2() {
    return InkWell(
      child: Card(
        elevation: 18.0,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.red.shade500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logout.png",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              const Text(
                "Log Out",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87, letterSpacing: 2),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
      onTap: () {
        ctrAuth.onClickLogOut();
      },
    );
  }

  Widget menuData(BuildContext context, String judulmenu, String iconmenu, String url) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MaterialButton(
        height: 100.0,
        minWidth: 120.0,
        color: Colors.brown[300],
        textColor: Colors.yellow[200],
        child: Column(children: [
          Image.asset(
            iconmenu,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          Text(
            judulmenu,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ]),
        onPressed: () => {
          Navigator.of(context).pushNamed(url)
        },
        splashColor: Colors.redAccent,
      ),
    );
  }

  Widget menuLogOut() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: MaterialButton(
          height: 100.0,
          minWidth: 120.0,
          // color: Theme.of(context).primaryColor,
          color: Colors.grey,
          textColor: Colors.white,
          child: Column(
            children: [
              Image.asset(
                'assets/images/logout.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              const Text(
                'Log Out',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          onPressed: () => {},
          splashColor: Colors.redAccent,
        ),
      ),
    );
  }

  Widget bannerHeader() {
    return Container(
      alignment: Alignment.center,
      height: 200,
      child: Column(
        children: [
          RichText(
            text: const TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.people_alt, size: 14, color: Colors.white),
                ),
                TextSpan(
                  text: "   ",
                ),
                TextSpan(text: "hello user", style: TextStyle(letterSpacing: 2))
              ],
            ),
          ),
          const Text('Aplikasi Resto', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 5, color: Colors.white70, fontSize: 35)),
          const Text(
            'by inspirasi',
            style: TextStyle(color: Colors.white),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/dashboard.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
