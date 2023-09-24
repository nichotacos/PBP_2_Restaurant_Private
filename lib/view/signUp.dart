import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/login.dart';
import 'package:pbp_2_restaurant/component/form_component.dart';

class signUpView extends StatefulWidget {
  const signUpView({super.key});

  @override
  State<signUpView> createState() => _signUpViewState();
}

class _signUpViewState extends State<signUpView> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  bool? isLaki;
  bool isAgreementAccepted = false;
  bool successful = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                inputForm((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Username Tidak Boleh Kosong';
                  }
                  if (p0.toLowerCase() == 'anjing') {
                    return 'Tidak Boleh Menggunakan kata kasar';
                  }
                  return null;
                },
                    controller: usernameController,
                    hintTxt: "Username",
                    helperTxt: "Ucup Surucup",
                    iconData: Icons.person),
                inputForm(((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  if (!p0.contains('@')) {
                    return 'Email harus menggunakan @';
                  }
                  return null;
                }),
                    controller: emailController,
                    hintTxt: "Email",
                    helperTxt: "ucup@gmail.com",
                    iconData: Icons.email),
                inputForm(((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Password tidak boleh kosong';
                  }
                  if (p0.length < 5) {
                    return 'Password minimal 5 digit';
                  }
                  return null;
                }),
                    controller: passwordController,
                    hintTxt: "Password",
                    helperTxt: "xxxxxxx",
                    iconData: Icons.password,
                    password: true),
                inputForm(((p0) {
                  if (p0 == null || p0.isEmpty) {
                    return 'Nomor telepon tidak boleh kosong';
                  }
                  return null;
                }),
                    controller: notelpController,
                    hintTxt: "No Telp",
                    helperTxt: "082123456789",
                    iconData: Icons.phone_android),
                Container(
                  margin: const EdgeInsets.fromLTRB(40, 0, 25, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: birthDateController,
                        readOnly: true, // Ini akan membuatnya hanya bisa dibaca
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
                          hintText: 'Tanggal Lahir',
                          prefixIcon: Icon(Icons.calendar_today),
                          labelText: 'Tanggal Lahir',
                          helperText: 'Pilih Tanggal Lahir Anda',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tanggal Lahir tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Jenis Kelamin: '),
                    Radio(
                      value: false,
                      groupValue: isLaki,
                      onChanged: (value) {
                        setState(() {
                          isLaki = value as bool;
                        });
                      },
                    ),
                    const Text('Laki-laki'),
                    Radio(
                      value: true,
                      groupValue: isLaki,
                      onChanged: (value) {
                        setState(() {
                          isLaki = value as bool;
                        });
                      },
                    ),
                    const Text('Perempuan'),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(30, 0, 25, 0),
                  child: CheckboxListTile(
                    title: const Text("Saya setuju dengan User Agreement"),
                    value: isAgreementAccepted,
                    onChanged: (value) {
                      setState(
                        () {
                          isAgreementAccepted = value!;
                        },
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String message = '';

                      if (isLaki == null) {
                        message = 'Jenis kelamin belum dipilih. ';
                      }

                      if (!isAgreementAccepted) {
                        message += 'Anda belum menyetujui User Agreement.';
                      }

                      if (message.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (_) => const AlertDialog(
                            title: Text('Data Berhasil Disimpan'),
                          ),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => LoginView(
                        //       data: formData,
                        //     ),
                        //   ),
                        // );
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

                      if (isLaki != null && isAgreementAccepted) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => AlertDialog(
                            title: const Text('Data Berhasil Disimpan'),
                            content: const SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('Berhasil Sign-Up'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Map<String, dynamic> formData = {};
                                  formData['username'] =
                                      usernameController.text;
                                  formData['password'] =
                                      passwordController.text;

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => LoginView(
                                        data: formData,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Ok'),
                              )
                            ],
                          ),
                        );
                      }

                      // Map<String, dynamic> formData = {};
                      // formData['username'] = usernameController.text;
                      // formData['password'] = passwordController.text;

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => LoginView(
                      //       data: formData,
                      //     ),
                      //   ),
                      // );
                    }
                  },
                  child: const Text('Sign Up'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
