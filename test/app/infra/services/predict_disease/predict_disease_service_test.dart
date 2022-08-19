import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mobile/app/infra/services/predict_disease_service.dart';

import '../../../../dummies/payloads.dart';
import '../../../../dummies/predictions.dart';
import '../../../../dummies/strings.dart';

void main() async {
  final Dio dioInstance = Dio();
  final dioAdapter = DioAdapter(dio: dioInstance);
  dioInstance.httpClientAdapter = dioAdapter;

  PredictDiseaseService service = PredictDiseaseService(
      dioInstance: dioInstance, baseUrl: StringDummy.baseUrl);

  dioAdapter.onPost(StringDummy.baseUrl,
      (server) => server.reply(200, StringDummy.predictionRemoteJsonPayload),
      data: Matchers.any);

  test('Should correctly return a prediction', () async {
    final response = await service(payload: perfectPredictionPayload);
    expect(response, perfectPrediction);
  });

  test('Should throw on invalid payload', () async {
    expect(() async => await service(payload: invalidPredictionPayload),
        throwsException);
  });
}
