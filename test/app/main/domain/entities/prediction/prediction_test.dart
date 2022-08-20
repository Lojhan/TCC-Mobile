import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/domain/entities/prediction_payload.dart';

import '../../../../../dummies/files.dart';
import '../../../../../dummies/payloads.dart';
import '../../../../../dummies/predictions.dart';
import '../../../../../dummies/strings.dart';

void main() {
  test('Should be equatable', () {
    expect(perfectPrediction, equals(perfectPrediction));
  });

  test('Should return a json map', () {
    expect(perfectPrediction.toJson, {
      'id': StringDummy.id,
      'localImagePath': StringDummy.localImagePath,
      'remoteImagePath': StringDummy.remoteImagePath,
      'dx': StringDummy.dx,
      'diseaseName': StringDummy.diseaseName,
      'createdAt': DateTime.parse(StringDummy.date).toIso8601String(),
      'predicted': true,
    });
  });

  test('Should correctly load from local', () {
    Prediction prediction = Prediction.fromLocal({
      'id': StringDummy.id,
      'localImagePath': StringDummy.localImagePath,
      'dx': StringDummy.dx,
      'diseaseName': StringDummy.diseaseName,
      'createdAt': DateTime.parse(StringDummy.date).toIso8601String(),
      'predicted': 'true',
    });
    expect(prediction.id, StringDummy.id);
    expect(prediction.localImagePath, StringDummy.localImagePath);
    expect(prediction.dx, StringDummy.dx);
    expect(prediction.diseaseName, StringDummy.diseaseName);
    expect(prediction.createdAt, DateTime.parse(StringDummy.date));
    expect(prediction.predicted, true);
  });

  test('Should correctly load from remote', () {
    Prediction prediction = Prediction.fromRemote({
      'id': StringDummy.id,
      'remoteImagePath': StringDummy.remoteImagePath,
      'dx': StringDummy.dx,
      'diseaseName': StringDummy.diseaseName,
      'createdAt': DateTime.parse(StringDummy.date).toIso8601String(),
      'predicted': 'true',
    });
    expect(prediction.id, StringDummy.id);
    expect(prediction.localImagePath, '');
    expect(prediction.remoteImagePath, StringDummy.remoteImagePath);
    expect(prediction.dx, StringDummy.dx);
    expect(prediction.diseaseName, StringDummy.diseaseName);
    expect(prediction.createdAt, DateTime.parse(StringDummy.date));
    expect(prediction.predicted, true);
  });

  test('Should correctly load from json', () {
    Prediction prediction = Prediction.fromJson({
      'id': StringDummy.id,
      'localImagePath': StringDummy.localImagePath,
      'remoteImagePath': StringDummy.remoteImagePath,
      'dx': StringDummy.dx,
      'diseaseName': StringDummy.diseaseName,
      'createdAt': DateTime.parse(StringDummy.date).toIso8601String(),
      'predicted': 'true',
    });
    expect(prediction.id, StringDummy.id);
    expect(prediction.localImagePath, StringDummy.localImagePath);
    expect(prediction.remoteImagePath, StringDummy.remoteImagePath);
    expect(prediction.dx, StringDummy.dx);
    expect(prediction.diseaseName, StringDummy.diseaseName);
    expect(prediction.createdAt, DateTime.parse(StringDummy.date));
    expect(prediction.predicted, true);
  });

  test('Should correctly load from payload', () async {
    PredictionPayload payload =
        await PredictionPayload.fromImageFilePath(FileDummy.file.path);
    Prediction prediction = Prediction.fromPayload(payload);
    expect(prediction.localImagePath, StringDummy.filePath);
    expect(prediction.remoteImagePath, 'not uploaded');
    expect(prediction.dx, 'undetermined');
    expect(prediction.diseaseName, 'undetermined');
    expect(prediction.predicted, false);
  });

  test('Should correctly merge response and payload', () async {
    Prediction prediction = Prediction.mergeResponsePayload(
        perfectPrediction, perfectPredictionPayload);
    expect(prediction.localImagePath, StringDummy.filePath);
    expect(prediction.remoteImagePath, StringDummy.remoteImagePath);
    expect(prediction.dx, StringDummy.dx);
    expect(prediction.diseaseName, StringDummy.diseaseName);
    expect(prediction.predicted, true);
  });

  test('Should correctly list props', () {
    expect(perfectPrediction.props, [
      perfectPrediction.id,
      perfectPrediction.localImagePath,
      perfectPrediction.remoteImagePath,
      perfectPrediction.dx,
      perfectPrediction.diseaseName,
      perfectPrediction.createdAt,
      perfectPrediction.predicted,
    ]);
  });

  test('Should correcly map bools', () {
    expect(Prediction.formatPredicted(true), true);
    expect(Prediction.formatPredicted(false), false);
    expect(Prediction.formatPredicted('true'), true);
    expect(Prediction.formatPredicted('false'), false);
    expect(Prediction.formatPredicted(''), false);
    expect(Prediction.formatPredicted(null), false);
  });

  test('Should correctly format date', () {
    DateTime date = DateTime.parse(StringDummy.date);
    expect(Prediction.formatDate(date), date);
    expect(Prediction.formatDate(StringDummy.date), date);
    expect(Prediction.formatDate(null), isA<DateTime>());
  });

  test('Should return an image path', () {
    expect(perfectPrediction.image, StringDummy.localImagePath);
  });
}
