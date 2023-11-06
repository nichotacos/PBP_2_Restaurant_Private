import 'dart:ffi';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/database/sql_helper.dart';
import 'dart:io';
import 'dart:convert';

import 'package:pbp_2_restaurant/utils/logging_utils.dart';
import 'package:pbp_2_restaurant/model/user.dart';
import 'package:pbp_2_restaurant/view/home.dart';
import 'package:pbp_2_restaurant/view/profile.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;
  final CameraController cameraController;
  final User? user;

  const DisplayPictureScreen(
      {Key? key,
      required this.imagePath,
      required this.cameraController,
      required this.user});

  @override
  State<DisplayPictureScreen> createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  File? fileResult;
  String base64Image = '';
  var decode;
  var base64File;

  @override
  void initState() {
    fileResult = File(widget.imagePath);
    List<int> fileBytes = fileResult!.readAsBytesSync();
    base64File = base64Encode(fileBytes);
    decode = base64.decode(base64File);
    super.initState();
  }

  Future<void> refresh() async {
    setState(() {
      widget.user!.imageData = base64File;
    });
  }

  @override
  Widget build(BuildContext context) {
    LoggingUtils.logStartFunction('Build DisplayPictureScreen');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display The Picture'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                // await updateImage(widget.user!.id as int);
                await refresh();

                if (widget.user!.imageData == base64File) {
                  print('true');
                } else {
                  print('false');
                }

                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomeView(
                        user: widget.user,
                        pageIndex: 3,
                      ),
                    ),
                  );
                }
              },
              child: const Text('Save')),
          WillPopScope(
              child: Image.file(
                fileResult!,
                height: 450,
                width: 450,
              ),
              onWillPop: () async {
                widget.cameraController.resumePreview();
                return true;
              }),
        ],
      ),
    );
  }

  // Future<void> updateImage(int userId) async {
  //   try {
  //     // await SQLHelper.saveImage(base64File, userId);
  //     // Other operations or actions after a successful update can be placed here
  //     await SQLHelper.editImage(
  //         base64File, userId, widget.user!.username as String);
  //   } catch (e) {
  //     // Handle any exceptions or errors that occur during the database update
  //     print('Error while updating image: $e');
  //     // Perform necessary actions based on the error, such as showing an error message to the user
  //   }
  // }
}
