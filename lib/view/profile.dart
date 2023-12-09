import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:pbp_2_restaurant/model/user.dart';
import 'package:pbp_2_restaurant/entity/user.dart';
import 'package:pbp_2_restaurant/main.dart';
import 'package:pbp_2_restaurant/view/update_user.dart';
import 'package:pbp_2_restaurant/database/sql_helper.dart';
import 'package:pbp_2_restaurant/view/viewMap/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pbp_2_restaurant/view/camera/camera.dart';
import 'package:pbp_2_restaurant/QRView/QrCamera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:pbp_2_restaurant/client/user_client.dart';
import 'package:pbp_2_restaurant/view/homePage.dart';
import 'package:pbp_2_restaurant/feedback.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.user});

  final User user;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? image;
  String id = const Uuid().v1();
  String username = '';
  String telephone = '';
  int point = 0;
  String imageData = '';

  void refresh() async {
    final dataUser = await UserClient.find(widget.user.id);
    setState(() {
      id = dataUser.id.toString();
      username = dataUser.username!;
      telephone = dataUser.telephone!;
      point = dataUser.poin!;
      imageData = dataUser.imageData!;
      print('length adalah: ${imageData.toString().length}');
    });
  }

  void changePassword() async {
    try {
      if (widget.user.id != null) {
        await UserClient.forgotPassword(widget.user);
      }

      showSnackBar(context, 'Berhasil Mengganti Password Menjadi Username!',
          Colors.green);
      // Navigator.pop(context);
      refresh();
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    refresh(); // Panggil refresh saat halaman dimuat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color.fromARGB(40, 255, 0, 0),
                        foregroundColor: const Color.fromARGB(1000, 255, 0, 0),
                      ),
                      child: const Icon(CupertinoIcons.back),
                      onPressed: () => Navigator.pop(context),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Stack(
                      children: [
                        Material(
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                    child: AlertDialog(
                                      title: const Text('Edit Photo Profile'),
                                      actions: [
                                        TextButton.icon(
                                          onPressed: () async {
                                            await pickImage();
                                          },
                                          icon:
                                              const Icon(Icons.image_outlined),
                                          label:
                                              const Text('Choose From Library'),
                                        ),
                                        TextButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: ((context) =>
                                                    CameraView(
                                                      user: widget.user,
                                                    )),
                                              ),
                                            );
                                          },
                                          icon: const Icon(Icons.camera),
                                          label: const Text('Take Photo'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                              radius: 75,
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 240, 240),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: MemoryImage(
                                  base64Decode(
                                    imageData,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 0,
                          child: SizedBox(
                            height: 40,
                            width: 40,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: const BorderSide(color: Colors.white),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 214, 19, 85),
                              ),
                              onPressed: () {},
                              child: const Center(
                                  child: Icon(
                                Icons.create_outlined,
                                color: Colors.white,
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Personal Info',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Username',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Text(
                            // '${widget.user!.username}',
                            username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Telephone',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Text(
                            // '${widget.user!.telephone}',
                            telephone,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 10, 15, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Poin',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Text(
                            // '${widget.user!.poin}',
                            point.toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 214, 19, 85),
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 18),
                  minimumSize: const Size.fromHeight(20),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
                child: const Text(
                  'Set Address',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 214, 19, 85),
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 18),
                  minimumSize: const Size.fromHeight(20),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) =>
                              UpdateUser(user: widget.user))));
                },
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 214, 19, 85),
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 18),
                  minimumSize: const Size.fromHeight(20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QRCameraPage(
                        user: widget.user,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'QR Scan',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 214, 19, 85),
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 18),
                  minimumSize: const Size.fromHeight(20),
                ),
                onPressed: () {
                  changePassword();
                },
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 25,
              ),ElevatedButton(
                key: const Key('BtnFeedback'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 214, 19, 85),
                  padding: const EdgeInsetsDirectional.symmetric(vertical: 18),
                  minimumSize: const Size.fromHeight(20),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FeedbackPage(
                        id: id,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Feedback',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // SizedBox(
              //   height: 120,
              //   child: Text(widget.user!.imageData as String),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  
  Future<void> getUser() async {
    await SQLHelper.getUser();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);
      var pickedImage = base64Encode(imageTemp.readAsBytesSync());
      await SQLHelper.editImage(base64Encode(imageTemp.readAsBytesSync()),
          widget.user!.id!, widget.user!.username!.toString());
      setState(() =>
          widget.user!.imageData = base64Encode(imageTemp.readAsBytesSync()));

      User input = User(
        id: widget.user.id,
        username: widget.user.username,
        password: widget.user.password,
        email: widget.user.email,
        telephone: widget.user.telephone,
        bornDate: widget.user.bornDate,
        imageData: pickedImage,
        address: widget.user.address,
        poin: widget.user.poin,
      );

      await UserClient.updateImage(widget.user);

      showSnackBar(context, 'Update Photo Success', Colors.green);
      Navigator.pop(context);
    } on PlatformException catch (e) {
      const SnackBar(content: Text('Failed to Pick Image!'));
    }
  }
}
