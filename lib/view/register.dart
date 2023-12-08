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
      Uint8List imageData = (await rootBundle.load('assets/images/test.jpeg'))
          .buffer
          .asUint8List();
      String base64Image = base64Encode(imageData);

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

      try {
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
        // showSnackBar(context, 'Register Success', Colors.green);
      } catch (e) {
        if (context.mounted) {
          showToast(context, 'Register Failed', Colors.red, Icons.close);
          await Future.delayed(const Duration(seconds: 2));
        }
      }
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
