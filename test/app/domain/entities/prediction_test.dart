import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/domain/entities/prediction.dart';

import '../../../dummies/strings.dart';

void main() {
  Map<String, dynamic> remoteJsonPayload =
      StringDummy.predictionRemoteJsonPayload;
  Map<String, dynamic> localJsonPayload =
      StringDummy.predictionLocalJsonPayload;

  test("Should be renderable if all the params are given correctly", () {
    Prediction prediction = Prediction(
      id: '1',
      remoteImagePath: 'hemlo',
      dx: 'dx',
      diseaseName: 'diseaseName',
    );
    expect(prediction.renderable(), true);
  });

  test("Should not be renderable if id is null or empty", () {
    Prediction prediction = Prediction(
      id: '',
      remoteImagePath: 'hemlo',
      dx: 'dx',
      diseaseName: 'diseaseName',
    );
    expect(prediction.renderable(), false);
  });

  test("Should not be renderable if dx is null or empty", () {
    Prediction prediction = Prediction(
      id: '1',
      remoteImagePath: 'hemlo',
      dx: '',
      diseaseName: 'diseaseName',
    );
    expect(prediction.renderable(), false);
  });

  test("Should not be renderable if diseaseName is null or empty", () {
    Prediction prediction = Prediction(
      id: '1',
      remoteImagePath: 'hemlo',
      dx: 'dx',
      diseaseName: '',
    );
    expect(prediction.renderable(), false);
  });

  test(
      "Should not be renderable if localImagePath and remoteImagePath are null",
      () {
    Prediction prediction = Prediction(
      id: '1',
      dx: 'dx',
      diseaseName: 'diseaseName',
    );
    expect(prediction.renderable(), false);
  });

  test(
      "Should not be renderable if localImagePath and remoteImagePath are empty",
      () {
    Prediction prediction = Prediction(
      id: '1',
      dx: 'dx',
      diseaseName: 'diseaseName',
      localImagePath: '',
      remoteImagePath: '',
    );
    expect(prediction.renderable(), false);
  });

  test("Should be renderable id a correct remote json is given", () {
    Prediction prediction = Prediction.fromRemote(remoteJsonPayload);
    expect(prediction.renderable(), true);
  });

  test("Should be renderable if a correct local json is given", () {
    Prediction prediction = Prediction.fromLocal(localJsonPayload);
    expect(prediction.renderable(), true);
  });
}
