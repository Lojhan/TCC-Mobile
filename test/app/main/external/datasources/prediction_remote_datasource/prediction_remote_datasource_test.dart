import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:mobile/app/main/external/datasources/prediction_remote_datasource.dart';

import '../../../../../dummies/predictions.dart';
import '../../../../../dummies/strings.dart';

void main() {
  final Dio dioInstance = Dio();
  final dioAdapter = DioAdapter(dio: dioInstance);
  dioInstance.httpClientAdapter = dioAdapter;

  dioAdapter
    ..onGet(
      '${StringDummy.baseUrl}/${StringDummy.id}',
      (server) => server.reply(200, StringDummy.predictionRemoteJsonPayload),
    )
    ..onGet(
      StringDummy.baseUrl,
      (server) => server.reply(
        200,
        const JsonEncoder().convert([StringDummy.predictionRemoteJsonPayload]),
      ),
    )
    ..onPost(
      StringDummy.baseUrl,
      (server) => server.reply(200, StringDummy.predictionRemoteJsonPayload),
      data: perfectPrediction.toJson,
    )
    ..onPut(
      '${StringDummy.baseUrl}/${StringDummy.id}',
      (server) => server.reply(
        200,
        const JsonEncoder().convert(StringDummy.predictionRemoteJsonPayload),
      ),
      data: perfectPrediction.toJson,
    )
    ..onDelete(
      '${StringDummy.baseUrl}/${StringDummy.id}',
      (server) => server.reply(200, StringDummy.predictionRemoteJsonPayload),
    );

  PredictionRemoteDatasource service = PredictionRemoteDatasource(
      dioInstance: dioInstance, baseUrl: StringDummy.baseUrl);

  test('Should get a Prediction by it\'s id', () async {
    final prediction = await service.getById(StringDummy.id);
    expect(prediction, isNotNull);
    expect(prediction?.id, StringDummy.id);
    expect(prediction?.remoteImagePath, StringDummy.remoteImagePath);
    expect(prediction?.dx, StringDummy.dx);
    expect(prediction?.diseaseName, StringDummy.diseaseName);
    expect(prediction?.createdAt, DateTime.parse(StringDummy.date));
    expect(prediction?.predicted, true);
  });

  test('Should get a list of Predictions', () async {
    final predictions = await service.list();
    expect(predictions?.length, 1);
    expect(predictions?.first.id, StringDummy.id);
    expect(predictions?.first.remoteImagePath, StringDummy.remoteImagePath);
    expect(predictions?.first.dx, StringDummy.dx);
    expect(predictions?.first.diseaseName, StringDummy.diseaseName);
    expect(predictions?.first.createdAt, DateTime.parse(StringDummy.date));
    expect(predictions?.first.predicted, true);
  });

  test('Should save a Prediction', () async {
    final prediction = await service.save(perfectPrediction);
    expect(prediction?.id, StringDummy.id);
    expect(prediction?.remoteImagePath, StringDummy.remoteImagePath);
    expect(prediction?.dx, StringDummy.dx);
    expect(prediction?.diseaseName, StringDummy.diseaseName);
    expect(prediction?.createdAt, DateTime.parse(StringDummy.date));
    expect(prediction?.predicted, true);
  });

  test('Should update a Prediction', () async {
    final prediction = await service.update(perfectPrediction);
    expect(prediction?.id, StringDummy.id);
    expect(prediction?.remoteImagePath, StringDummy.remoteImagePath);
    expect(prediction?.dx, StringDummy.dx);
    expect(prediction?.diseaseName, StringDummy.diseaseName);
    expect(prediction?.createdAt, DateTime.parse(StringDummy.date));
    expect(prediction?.predicted, true);
  });

  test('Should delete a Prediction', () async {
    final prediction = await service.delete(StringDummy.id);
    expect(prediction?.id, StringDummy.id);
    expect(prediction?.remoteImagePath, StringDummy.remoteImagePath);
    expect(prediction?.dx, StringDummy.dx);
    expect(prediction?.diseaseName, StringDummy.diseaseName);
    expect(prediction?.createdAt, DateTime.parse(StringDummy.date));
    expect(prediction?.predicted, true);
  });
}
