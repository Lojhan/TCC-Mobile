import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController controller;

  List<Map<IconData, FlashMode>> flashmodes = [
    {Icons.flash_off: FlashMode.off},
    {Icons.flash_on: FlashMode.always},
    {Icons.flash_auto: FlashMode.auto},
  ];

  int selectedFlashmode = 0;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.camera, ResolutionPreset.ultraHigh);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  void nextFlashMode() {
    setState(() {
      selectedFlashmode = (selectedFlashmode + 1) % flashmodes.length;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  FutureOr<void> takePicture() async {
    if (!controller.value.isInitialized) {
      return null;
    }

    if (controller.value.isTakingPicture) {
      return null;
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    XFile file = await controller.takePicture();
    await file.saveTo(filePath);
    Navigator.of(context).pop(filePath);
  }

  Widget cameraPreview() {
    return Positioned(
      top: MediaQuery.of(context).size.height * .1,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .75,
      child: CameraPreview(controller),
    );
  }

  Widget takePictureButton() {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * .03,
      child: FloatingActionButton(
        heroTag: 'defaultIcon',
        onPressed: takePicture,
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Widget toggleFlashButton() {
    return Positioned(
      bottom: MediaQuery.of(context).size.height * .032,
      left: 20,
      child: ElevatedButton(
        onPressed: nextFlashMode,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(12),
        ),
        child: Icon(flashmodes[selectedFlashmode].keys.first),
      ),
    );
  }

  Widget goBackIcon() {
    return Positioned(
      top: MediaQuery.of(context).size.height * .025,
      left: MediaQuery.of(context).size.width * .02,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Row(
          children: const [
            Icon(Icons.arrow_back),
            Text('Back'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        goBackIcon(),
        toggleFlashButton(),
        cameraPreview(),
        takePictureButton(),
      ],
    );
  }
}