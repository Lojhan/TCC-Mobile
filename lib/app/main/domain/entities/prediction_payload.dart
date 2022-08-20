import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class PredictionPayload extends Equatable {
  final File payload;

  const PredictionPayload({
    required this.payload,
  });

  static Future<PredictionPayload> fromImageXFile(XFile image) async {
    Uint8List bytes = await image.readAsBytes();
    File payload = File.fromRawPath(bytes);
    await payload.create(recursive: true);
    return PredictionPayload(payload: payload);
  }

  static Future<PredictionPayload> fromImageFilePath(String path) async {
    File payload = File(path);
    return PredictionPayload(payload: payload);
  }

  bool valid() {
    return payload.existsSync();
  }

  toJson() {
    return {
      'payload': payload,
    };
  }

  @override
  List<Object?> get props => [payload];
}
