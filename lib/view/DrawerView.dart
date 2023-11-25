import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:pbp_2_restaurant/model/user.dart';
import 'package:pbp_2_restaurant/entity/user.dart';
import 'package:pbp_2_restaurant/login.dart';
import 'package:pbp_2_restaurant/view/register.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key, required this.user});
  final User user;

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.green, // Background Warna Bagian Profil
              ),
              accountName: Text(
                "${widget.user!.username}",
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "${widget.user!.email}",
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage("assets/images/test.jpeg"),
              ),
            ),
          ),

          // Profile Account
          const ListTile(
            leading: Icon(
              CupertinoIcons.home,
              color: Colors.black,
            ),
            title: Text(
              "Home",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.person,
              color: Colors.black,
            ),
            title: Text(
              "My Account",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.cart,
              color: Colors.black,
            ),
            title: Text(
              "Orders",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.heart_fill,
              color: Colors.red,
            ),
            title: Text(
              "Favorites",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: Text(
              "Settings",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: const Text(
              "Log out",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginView())),
          ),
        ],
      ),
    );
  }
}
