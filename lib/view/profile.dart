import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/login.dart';
import 'package:pbp_2_restaurant/model/user.dart';
import 'package:pbp_2_restaurant/view/update_user.dart';
import 'package:pbp_2_restaurant/main.dart';
import 'package:pbp_2_restaurant/database/sql_helper.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.user});

  final User? user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // void refresh() async {
  //   List<Map<String, dynamic>> user = [];
  //   final data = await SQLHelper.getUser();
  //   setState(() {
  //     user = data;
  //   });
  // }

  @override
  void initState() {
    super.initState();

    refresh(); // Panggil refresh saat halaman dimuat
  }

  Future<void> refresh() async {
    List<Map<String, dynamic>> user = [];
    final data = await SQLHelper.getUser();
    setState(() {
      user = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello ${widget.user!.username}!',
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                shape: const BeveledRectangleBorder(
                    side: BorderSide(color: Colors.red)),
                color: Colors.greenAccent,
                child: SizedBox(
                  height: 150,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username: ${widget.user!.username}',
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'Email: ${widget.user!.email}',
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'Telephone: ${widget.user!.telephone}',
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'Born Date: ${widget.user!.bornDate}',
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => UpdateUser(user: widget.user!),
                            // builder: (_) => TestPage(title: 'title'),
                          )).then((_) => refresh());
                    },
                    child: const Text('Update Data'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getUser() async {
    await SQLHelper.getUser();
  }
}
