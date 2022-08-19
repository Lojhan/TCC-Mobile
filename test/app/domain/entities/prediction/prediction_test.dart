import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/app/domain/entities/prediction_payload.dart';

import '../../../../dummies/files.dart';
import '../../../../dummies/predictionPayloads.dart';
import '../../../../dummies/predictions.dart';
import '../../../../dummies/strings.dart';

void main() {
  test('Should be equatable', () {
    expect(perfectPrediction, equals(perfectPrediction));
  });

  test('Should return a json map', () {
    expect(perfectPrediction.toJson, {
      'id': 'id',
      'localImagePath': 'localImagePath',
      'remoteImagePath': 'remoteImagePath',
      'dx': 'dx',
      'diseaseName': 'diseaseName',
      'createdAt': DateTime.parse('2020-01-01').toIso8601String(),
      'predicted': true,
    });
  });

  test('Should correctly load from local', () {
    Prediction prediction = Prediction.fromLocal({
      'id': 'id',
      'localImagePath': 'localImagePath',
      'dx': 'dx',
      'diseaseName': 'diseaseName',
      'createdAt': DateTime.parse('2020-01-01').toIso8601String(),
      'predicted': true,
    });
    expect(prediction.id, 'id');
    expect(prediction.localImagePath, 'localImagePath');
    expect(prediction.dx, 'dx');
    expect(prediction.diseaseName, 'diseaseName');
    expect(prediction.createdAt, DateTime.parse('2020-01-01'));
    expect(prediction.predicted, true);
  });

  test('Should correctly load from remote', () {
    Prediction prediction = Prediction.fromRemote({
      'id': 'id',
      'remoteImagePath': 'remoteImagePath',
      'dx': 'dx',
      'diseaseName': 'diseaseName',
      'createdAt': DateTime.parse('2020-01-01').toIso8601String(),
      'predicted': true,
    });
    expect(prediction.id, 'id');
    expect(prediction.remoteImagePath, 'remoteImagePath');
    expect(prediction.dx, 'dx');
    expect(prediction.diseaseName, 'diseaseName');
    expect(prediction.createdAt, DateTime.parse('2020-01-01'));
    expect(prediction.predicted, true);
  });

  test('Should correctly load from json', () {
    Prediction prediction = Prediction.fromJson({
      'id': 'id',
      'localImagePath': 'localImagePath',
      'remoteImagePath': 'remoteImagePath',
      'dx': 'dx',
      'diseaseName': 'diseaseName',
      'createdAt': DateTime.parse('2020-01-01').toIso8601String(),
      'predicted': true,
    });
    expect(prediction.id, 'id');
    expect(prediction.localImagePath, 'localImagePath');
    expect(prediction.remoteImagePath, 'remoteImagePath');
    expect(prediction.dx, 'dx');
    expect(prediction.diseaseName, 'diseaseName');
    expect(prediction.createdAt, DateTime.parse('2020-01-01'));
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
}
