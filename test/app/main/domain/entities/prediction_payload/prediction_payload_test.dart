import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/app/main/domain/entities/prediction_payload.dart';
import 'package:mockito/annotations.dart';

import '../../../../../dummies/files.dart';
import '../../../../../dummies/payloads.dart';

@GenerateMocks([XFile, File])
void main() {
  File file = FileDummy.file;
  test("Should de valid if an existing file is given", () {
    PredictionPayload payload = PredictionPayload(payload: file);
    expect(payload.valid(), true);
  });

  test("Should load correctly from xfile", () async {
    XFile xfile = await FileDummy.xfile;
    PredictionPayload payload = await PredictionPayload.fromImageXFile(xfile);
    expect(payload.valid(), true);
    expect(payload.runtimeType, perfectPredictionPayload.runtimeType);
  });

  test("Should load correctly from file path", () async {
    PredictionPayload payload =
        await PredictionPayload.fromImageFilePath(file.path);
    expect(payload.valid(), true);
    expect(payload.runtimeType, perfectPredictionPayload.runtimeType);
  });

  test("Should return a json map", () {
    PredictionPayload payload = PredictionPayload(payload: file);
    expect(payload.toJson(), {'payload': file});
  });

  test('Should correcly return props', () {
    PredictionPayload payload = PredictionPayload(payload: file);
    expect(payload.props, [file]);
  });
}
