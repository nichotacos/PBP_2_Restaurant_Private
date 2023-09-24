import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/view/home.dart';
import 'package:pbp_2_restaurant/view/signUp.dart';

class LoginView extends StatefulWidget {
  final Map? data;
  const LoginView({Key? key, this.data}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    Map? dataForm = widget.data;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: usernameController,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "username tidak boleh kosong";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Username",
                          labelText: "Inputkan User yang telah didaftar",
                          icon: Icon(Icons.person),
                        ),
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: !showPassword,
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "password kosong";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          labelText: "Inputkan Password",
                          icon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            icon: Icon(showPassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (dataForm!['username'] ==
                                        usernameController.text &&
                                    dataForm['password'] ==
                                        passwordController.text) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const HomeView(),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: const Text('Password Salah'),
                                      content: TextButton(
                                        onPressed: () => pushRegister(context),
                                        child: const Text('Daftar Disini !!'),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            pushRegister(context);
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    pushLogin(context);
                  },
                  child: const Text('Login'),
                ),
                ElevatedButton(
                  onPressed: () {
                    pushRegister(context);
                  },
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void pushRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const signUpView(),
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
}
