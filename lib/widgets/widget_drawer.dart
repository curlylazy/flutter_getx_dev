import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // const UserAccountsDrawerHeader(
          //   currentAccountPicture: CircleAvatar(
          //     backgroundImage: NetworkImage('https://images.unsplash.com/photo-1485290334039-a3c69043e517?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTYyOTU3NDE0MQ&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=300'),
          //   ),
          //   accountEmail: Text('jane.doe@example.com'),
          //   accountName: Text(
          //     'Jane Doe',
          //     style: TextStyle(fontSize: 24.0),
          //   ),
          //   decoration: BoxDecoration(
          //     color: Colors.black87,

          //   ),
          // ),
          SizedBox(
            height: 150,
            child: DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Keresto.co.id',
                    style: TextStyle(color: Colors.white, fontSize: 22, letterSpacing: 3),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Solusi Manajemen Resto Online',
                    style: TextStyle(color: Colors.white, fontSize: 13, letterSpacing: 1),
                  )
                ],
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
                image: DecorationImage(fit: BoxFit.fill, image: AssetImage('assets/images/sidebar.jpg')),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.house),
            title: const Text(
              'Dashboard',
              style: TextStyle(fontSize: 15.0),
            ),
            onTap: () {
              Get.toNamed("/dashboard");
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text(
              'User',
              style: TextStyle(fontSize: 15.0),
            ),
            onTap: () {
              Get.toNamed("/user/list");
            },
          ),
        ],
      ),
    );
  }
}
