import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pbp_2_restaurant/utils/logging_utils.dart';
import 'package:pbp_2_restaurant/view/camera/display_picture.dart';
// import 'package:pbp_2_restaurant/model/user.dart';
import 'package:pbp_2_restaurant/entity/user.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key, required this.user});

  final User user;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  Future<void>? _initializeCameraFuture;
  late CameraController _cameraController;
  var count = 0;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> initializeCamera() async {
    LoggingUtils.logStartFunction('initialize camera'.toUpperCase());
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(firstCamera, ResolutionPreset.medium);
    _initializeCameraFuture = _cameraController.initialize();

    if (mounted) {
      setState(() {});
      LoggingUtils.logEndFunction('success initialize camera'.toUpperCase());
    }
  }

  @override
  void dispose() {
    LoggingUtils.logStartFunction('dispose Cameraview'.toUpperCase());
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_initializeCameraFuture == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take a Picture'),
        backgroundColor: const Color.fromARGB(255, 214, 19, 85),
      ),
      body: FutureBuilder<void>(
        future: _initializeCameraFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_cameraController);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => await previewImageResult(),
        child: const Icon(Icons.camera_alt),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Photo',
            ),
          ],
          currentIndex: _selectedIndex,
          backgroundColor: const Color.fromARGB(255, 214, 19, 85),
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Future<DisplayPictureScreen?> previewImageResult() async {
    String activity = 'Preview Image Result';
    LoggingUtils.logStartFunction(activity);
    try {
      await _initializeCameraFuture;
      final image = await _cameraController.takePicture();
      if (!mounted) return null;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            _cameraController.pausePreview();
            LoggingUtils.logDebugValue(
                'get image on previewImageResult'.toUpperCase(),
                'image.path: ${image.path}');
            return DisplayPictureScreen(
              imagePath: image.path,
              cameraController: _cameraController,
              user: widget.user!,
            );
          },
        ),
      );
    } catch (e) {
      LoggingUtils.logError(activity, e.toString());
      return null;
    }
    return null;
  }
}
