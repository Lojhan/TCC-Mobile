import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/domain/entities/prediction_payload.dart';

import '../../../dummies/files.dart';

void main() {
  File file = FileDummy.file;
  XFile xfile = FileDummy.xfile;
  test("Should de valid", () {
    PredictionPayload payload = PredictionPayload(payload: file);
    expect(payload.valid(), true);
  });

  test("Should load correctly from xfile", () async {
    PredictionPayload payload = await PredictionPayload.fromImageXFile(xfile);
    expect(payload.valid(), true);
  });
}
