import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pbp_2_restaurant/login.dart';
import 'package:pbp_2_restaurant/component/form_component.dart';
import 'package:pbp_2_restaurant/main.dart';
// import 'package:pbp_2_restaurant/model/user.dart';
import 'package:pbp_2_restaurant/database/sql_helper.dart';
import 'package:pbp_2_restaurant/view/homePage.dart';
import 'package:pbp_2_restaurant/entity/user.dart';
import 'package:pbp_2_restaurant/client/user_client.dart';
import 'package:pbp_2_restaurant/view/starting-page/boarding-page.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class RegisterView extends StatefulWidget {
  const RegisterView(
      {super.key,
      required this.id,
      required this.username,
      required this.email,
      required this.password,
      required this.telephone,
      required this.bornDate});

  final int? id;

  final String? username;
  final String? email;
  final String? password;
  final String? telephone;
  final String? bornDate;

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  bool isAgreementAccepted = false;
  bool successful = false;
  bool passwordVisible = false;

  bool validateUsername = true;
  bool validateEmail = true;
  int validatePhone = 0;

  late List<String?> userEmails;
  late List<String?> userUsernames;

  late Future<List<User>> allUser;
  late FToast ftoast;

  Future<List<User>> getAllUser() async {
    var getUser = await UserClient.fetchAll();
    return getUser;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ftoast = FToast();
    getAllUser().then((users) {
      userEmails = users.map((user) => user.email).toList();
      userUsernames = users.map((user) => user.username).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    ftoast.init(context);
    if (widget.id != null) {
      usernameController.text = widget.username!;
      emailController.text = widget.email!;
      passwordController.text = widget.password!;
      notelpController.text = widget.telephone!;
      birthDateController.text = widget.bornDate!;
    }

    void onSubmit() async {
      if (!_formKey.currentState!.validate()) return;

      Future<void> registerUser() async {
        try {
          Uint8List imageData =
              (await rootBundle.load('assets/images/test.jpeg'))
                  .buffer
                  .asUint8List();
          String base64Image =
              "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";

          User input = User(
            id: 0,
            username: usernameController.text,
            password: passwordController.text,
            email: emailController.text,
            telephone: notelpController.text,
            bornDate: birthDateController.text,
            imageData: base64Image,
            address: null,
            poin: 0,
          );

          if (widget.id == null) {
            await UserClient.create(input);
          }

          if (context.mounted) {
            showToast(context, 'Register Success', Colors.green, Icons.check);
            await Future.delayed(const Duration(seconds: 2));
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginView(),
                ),
              );
            }
          }
        } catch (e) {
          if (context.mounted) {
            showToast(context, 'Register Failed', Colors.red, Icons.close);
            await Future.delayed(const Duration(seconds: 2));
          }
        }
      }

      Alert(
        context: context,
        type: AlertType.warning,
        title: "Confirmation",
        desc: "Are you sure you want to register?",
        buttons: [
          DialogButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              // Set nilai awal (kosong) pada setiap controller
              usernameController.text = '';
              emailController.text = '';
              passwordController.text = '';
              notelpController.text = '';
              birthDateController.text = '';

              Navigator.pop(context); // Tutup AlertDialog
            },
            color: Colors.grey,
          ),
          DialogButton(
            child: Text(
              "Register",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () async {
              Navigator.pop(context); // Tutup AlertDialog
              await registerUser(); // Panggil fungsi untuk menangani registrasi
            },
            color: Colors.green,
          ),
        ],
      ).show();
    }

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.transparent,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: Color.fromARGB(255, 214, 19, 85),
                              decorationThickness: 3,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, -20),
                                  color: Color.fromARGB(255, 214, 19, 85),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(width: 5),
                          TextButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginView())),
                            child: const Text(
                              'Login',
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
                                    color: Color.fromARGB(255, 59, 59, 59),
                                  )
                                ],
                              ),
                            ),
                          )
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
                        onChanged: (value) async {
                          final checkUser = await uniqueValidation(
                              usernameController.text, 'username');
                          setState(() =>
                              validateUsername = isUsernameAvailable(value));
                        },
                        validator: (value) => value == ''
                            ? 'Please enter your username!'
                            : validateUsername == false
                                ? 'Username has been taken!'
                                : null,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        key: const Key('EmailField'),
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email_rounded,
                            color: Color.fromARGB(255, 214, 19, 85),
                          ),
                          labelText: 'Email',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 214, 19, 85),
                            ),
                          ),
                        ),
                        onChanged: (value) async {
                          final checkEmail = await uniqueValidation(
                              emailController.text, 'email');
                          setState(
                              () => validateEmail = isEmailAvailable(value));
                        },
                        validator: (value) => value == ''
                            ? 'Please enter your email!'
                            : (!value!.contains('@')
                                ? 'Email format incorrect!'
                                : validateEmail == false
                                    ? 'Email has been taken!'
                                    : null),
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
                            color: const Color.fromARGB(255, 214, 19, 85),
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
                      const SizedBox(height: 10),
                      TextFormField(
                        key: const Key('TelephoneField'),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        controller: notelpController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.call,
                            color: Color.fromARGB(255, 214, 19, 85),
                          ),
                          labelText: 'Telephone',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.0),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 214, 19, 85),
                            ),
                          ),
                        ),
                        onChanged: (value) async {
                          final checkPhone = await uniqueValidation(
                              notelpController.text, 'telephone');
                          setState(() => validatePhone = checkPhone);
                        },
                        validator: (value) => value == ''
                            ? 'Please enter your telephone number!'
                            : validatePhone == 1
                                ? 'Phone number has been used!'
                                : null,
                      ),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              key: const Key('DateField'),
                              controller: birthDateController,
                              readOnly:
                                  true, // Ini akan membuatnya hanya bisa dibaca
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1960),
                                  lastDate: DateTime.now(),
                                ).then((pickedDate) {
                                  if (pickedDate != null) {
                                    setState(() {
                                      birthDateController.text = pickedDate
                                          .toLocal()
                                          .toString()
                                          .split(' ')[0];
                                    });
                                  }
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Born Date',
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: Color.fromARGB(255, 214, 19, 85),
                                ),
                                labelText: 'Born Date',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your born date!';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Theme(
                        data: ThemeData(
                          unselectedWidgetColor:
                              const Color.fromARGB(255, 214, 19, 85),
                        ),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: double.infinity,
                          child: CheckboxListTileFormField(
                            key: const Key('CheckboxField'),
                            title: const Text(
                                "I agree to the Privacy Policy, Terms of Use, and Terms of Services"),
                            validator: (bool? value) {
                              if (value!) {
                                return null;
                              } else {
                                return 'This field must be checked!';
                              }
                            },
                            onChanged: (value) {
                              setState(
                                () {
                                  isAgreementAccepted = value!;
                                },
                              );
                            },
                            activeColor: const Color.fromARGB(255, 214, 19, 85),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        key: const Key('SignUpButton'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 214, 19, 85),
                          padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            onSubmit();
                            // showToast(context, 'asdfaasdf', Colors.amber,
                            //     Icons.check);
                          }
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addUser() async {
    await SQLHelper.addUser(
      usernameController.text,
      emailController.text,
      passwordController.text,
      notelpController.text,
      birthDateController.text,
    );
  }

  Future<int> uniqueValidation(String element, String column) async {
    int check = await SQLHelper.uniqueValidation(element, column);
    return check;
  }

  bool isUsernameAvailable(String value) {
    print(userUsernames);
    return !userUsernames.contains(value);
  }

  bool isEmailAvailable(String value) {
    print(userEmails);
    return !userEmails.contains(value);
  }
}
