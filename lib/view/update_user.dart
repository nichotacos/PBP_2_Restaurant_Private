import 'package:checkbox_formfield/checkbox_list_tile_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pbp_2_restaurant/database/sql_helper.dart';
// import 'package:pbp_2_restaurant/model/user.dart';
import 'package:pbp_2_restaurant/entity/user.dart';
import 'package:pbp_2_restaurant/client/user_client.dart';
import 'package:pbp_2_restaurant/view/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pbp_2_restaurant/main.dart';

class UpdateUser extends StatefulWidget {
  const UpdateUser({super.key, required this.user});

  final User user;

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  bool isAgreementAccepted = false;
  bool successful = false;
  bool passwordVisible = false;

  int validateUsername = 0;
  int validateEmail = 0;
  int validatePhone = 0;

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

  void onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    User input = User(
      id: widget.user.id,
      username: usernameController.text,
      password: passwordController.text,
      email: emailController.text,
      telephone: notelpController.text,
      bornDate: birthDateController.text,
      imageData: widget.user.imageData,
      address: widget.user.address,
      poin: widget.user.poin,
    );

    try {
      if (widget.user.id != null) {
        await UserClient.update(input);
      }

      showSnackBar(context, 'Update Success', Colors.green);
      Navigator.pop(context);

      if (context.mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => ProfilePage(user: widget.user)));
      }
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
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
                        setState(() => validateUsername = checkUser);
                      },
                      validator: (value) => value == ''
                          ? 'Please enter your username!'
                          : validateUsername == 1
                              ? 'Username has been used!'
                              : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
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
                        setState(() => validateEmail = checkEmail);
                      },
                      validator: (value) => value == ''
                          ? 'Please enter your email!'
                          : (!value!.contains('@')
                              ? 'Email format incorrect!'
                              : validateEmail == 1
                                  ? 'Email has been used!'
                                  : null),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
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
                      validator: (value) =>
                          value == '' ? 'Please enter your password!' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
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
                                isAgreementAccepted = value;
                              },
                            );
                          },
                          activeColor: const Color.fromARGB(255, 214, 19, 85),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 214, 19, 85),
                        padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String message = '';

                          if (!isAgreementAccepted) {
                            message += 'Anda belum menyetujui User Agreement.';
                          }

                          if (message.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Data Berhasil Disimpan'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: onSubmit,
                                    child: const Text('Ok'),
                                  )
                                ],
                              ),
                            );
                          } else {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Data Gagal Disimpan'),
                                content: Text(message),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Tutup'),
                                  ),
                                ],
                              ),
                            );
                          }
                        }
                      },
                      child: const Text(
                        'Update Data',
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
    );
  }

  Future<void> editUser(int? id) async {
    await SQLHelper.editUser(
        id!,
        usernameController.text,
        emailController.text,
        passwordController.text,
        notelpController.text,
        birthDateController.text);
  }

  Future<int> uniqueValidation(String element, String column) async {
    int check = await SQLHelper.uniqueValidation(element, column);
    return check;
  }
}
