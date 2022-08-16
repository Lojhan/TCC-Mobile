import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';

class PredictionPayload {
  File payload;

  PredictionPayload({
    required this.payload,
  });

  static fromImageXFile(XFile image) async {
    Uint8List bytes = await image.readAsBytes();
    File payload = File.fromRawPath(bytes);
    return PredictionPayload(payload: payload);
  }

  bool valid() {
    payload.existsSync();
    return true;
  }

  toJson() {
    return {
      'payload': payload.path,
    };
  }
}
