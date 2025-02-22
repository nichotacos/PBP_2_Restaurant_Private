import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pbp_2_restaurant/database/sql_helper.dart';
import 'package:pbp_2_restaurant/login.dart';
import 'package:pbp_2_restaurant/view/register.dart';
import 'package:pbp_2_restaurant/view/starting-page/boarding-page.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFLITE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BoardingPage(),
    );
  }
}

class TestPage extends StatefulWidget {
  const TestPage({super.key, required this.title});

  final String title;

  @override
  State<TestPage> createState() => _TestPageState();
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class _TestPageState extends State<TestPage> {
  //getData
  List<Map<String, dynamic>> user = [];
  void refresh() async {
    final data = await SQLHelper.getUser();
    setState(() {
      user = data;
    });
  }

  late FToast fToast;

  @override
  void initState() {
    refresh();
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EMPLOYEE"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('regist dek'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterView(
                        id: null,
                        username: null,
                        email: null,
                        password: null,
                        telephone: null,
                        bornDate: null),
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text('login dek'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginView()),
                );
              },
            ),
            SizedBox(
              height: 700,
              child: ListView.builder(
                itemCount: user.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(user[index]['email']),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user[index]['username']),
                              Text(user[index]['password']),
                              Text(user[index]['telephone']),
                              Text(user[index]['bornDate'])
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String msg, Color bg) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: bg,
      action: SnackBarAction(
        label: 'hide',
        onPressed: scaffold.hideCurrentSnackBar,
      ),
    ),
  );
}

void showToast(BuildContext context, String msg, Color bg, IconData icons) {
  FToast fToast = FToast();
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: bg,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icons, color: Colors.white),
        const SizedBox(
          width: 12.0,
        ),
        Text(
          msg,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
  );
}
