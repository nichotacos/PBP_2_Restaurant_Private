import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/view/home.dart';
import 'package:pbp_2_restaurant/view/register.dart';
// import 'package:pbp_2_restaurant/model/user.dart';
import 'package:pbp_2_restaurant/database/sql_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pbp_2_restaurant/main.dart';
import 'package:pbp_2_restaurant/entity/user.dart';
import 'package:pbp_2_restaurant/client/user_client.dart';
import 'dart:async';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({Key? key, this.data}) : super(key: key);

  @override
  State<LoginView> createState() => LoginViewState();
}

bool passwordVisible = false;
User user = User();

class LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  void onPressedLogin() async {
    try {
      var loggedUser = await UserClient.login(
          usernameController.text, passwordController.text);

      if (context.mounted) {
        showToast(context, 'Login Success', Colors.green, Icons.check);
        await Future.delayed(const Duration(seconds: 2));
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomeView(
                user: loggedUser,
                pageIndex: 0,
              ),
            ),
          );
        }
      }
    } catch (e) {
      showToast(context, 'Login Failed', Colors.red, Icons.close);
      await Future.delayed(const Duration(seconds: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            hasScrollBody: false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.transparent,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.transparent,
                                          decorationThickness: 5,
                                          shadows: [
                                            Shadow(
                                              offset: Offset(0, -20),
                                              color: Color.fromARGB(
                                                  255, 59, 59, 59),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.transparent,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                        decorationColor:
                                            Color.fromARGB(255, 214, 19, 85),
                                        decorationThickness: 3,
                                        shadows: [
                                          Shadow(
                                            offset: Offset(0, -20),
                                            color: Color.fromARGB(
                                                255, 214, 19, 85),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  key: const Key('UsernameField'),
                                  controller: usernameController,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.person,
                                      color: Color.fromARGB(255, 214, 19, 85),
                                    ),
                                    labelText: 'Username',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 214, 19, 85),
                                      ),
                                    ),
                                  ),
                                  validator: (value) => value == ''
                                      ? 'Please enter your username!'
                                      : null,
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  key: const Key('PasswordField'),
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Color.fromARGB(255, 214, 19, 85),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off_rounded),
                                      color: const Color.fromARGB(
                                          255, 214, 19, 85),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                    ),
                                    labelText: 'Password',
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(2.0),
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 214, 19, 85),
                                      ),
                                    ),
                                  ),
                                  obscureText: passwordVisible ? false : true,
                                  validator: (value) => value == ''
                                      ? 'Please enter your password!'
                                      : (value!.length < 3
                                          ? 'Password length must be more than 3 characters!'
                                          : null),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.fromLTRB(0, 15, 0, 30),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 214, 19, 85),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        key: const Key('LoginButton'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 214, 19, 85),
                                          padding: const EdgeInsetsDirectional
                                              .symmetric(vertical: 15),
                                          minimumSize:
                                              const Size.fromHeight(20),
                                        ),
                                        onPressed: () async {
                                          onPressedLogin();
                                        },
                                        child: const Text(
                                          'Login',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 40,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Divider(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Text("Login with"),
                                            Expanded(
                                              child: Divider(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        icon: const Icon(Icons.face_2_sharp,
                                            color: Colors.black),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 244, 244, 244),
                                          padding: const EdgeInsetsDirectional
                                              .symmetric(vertical: 15),
                                          minimumSize:
                                              const Size.fromHeight(20),
                                        ),
                                        onPressed: () async {
                                          onPressedLogin();
                                        },
                                        label: const Text(
                                          'Login with Google',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      ElevatedButton.icon(
                                        icon:
                                            const Icon(Icons.facebook_outlined),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 0, 133, 255),
                                          padding: const EdgeInsetsDirectional
                                              .symmetric(vertical: 15),
                                          minimumSize:
                                              const Size.fromHeight(20),
                                        ),
                                        onPressed: () {
                                          onPressedLogin();
                                        },
                                        label: const Text(
                                          'Login with Facebook',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 130,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pushRegister(BuildContext context) {
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
  }

  void pushLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const LoginView(),
      ),
    );
  }

  Future<void> checkLogin() async {
    await SQLHelper.checkLogin(
        usernameController.text, passwordController.text);
  }
}
