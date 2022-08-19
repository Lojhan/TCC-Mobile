import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/app/domain/errors/errors.dart';
import 'package:mobile/app/domain/interfaces/services/i_predictions_service.dart';
import 'package:mobile/app/domain/usecases/predict_disease.usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummies/predictionPayloads.dart';
import '../../../../dummies/predictions.dart';
import 'predict_disease.usecase_test.mocks.dart';

@GenerateMocks([IPredictionsService])
void main() {
  IPredictionsService predictionsService = MockIPredictionsService();
  PredictDisease predictDisease = PredictDisease(
    predictionsService: predictionsService,
  );
  test('Should return a prediction', () async {
    when(predictionsService.predictDisease(payload: perfectPredictionPayload))
        .thenAnswer((_) async => Right(perfectPrediction));
    final prediction = await predictDisease(payload: perfectPredictionPayload);

    expect(prediction, Right(perfectPrediction));
  });

  test('Should return left if payload is invalid', () async {
    when(predictionsService.predictDisease(payload: invalidPredictionPayload))
        .thenAnswer((_) async => Left(InvalidPredictionPayloadError()));
    final prediction = await predictDisease(payload: invalidPredictionPayload);
    expect(invalidPredictionPayload.valid(), false);
    expect(prediction.runtimeType,
        Left<Failure, Prediction>(InvalidPredictionPayloadError()).runtimeType);
  });

  test('Should return left if the service fails', () async {
    when(predictionsService.predictDisease(payload: perfectPredictionPayload))
        .thenAnswer((_) async => Left(Failure()));
    final prediction = await predictDisease(payload: perfectPredictionPayload);

    expect(prediction.runtimeType,
        Left<Failure, Prediction>(Failure()).runtimeType);
  });

  test('Should return left if the throws failure', () async {
    when(predictionsService.predictDisease(payload: perfectPredictionPayload))
        .thenThrow(Failure());
    final prediction = await predictDisease(payload: perfectPredictionPayload);

    expect(prediction.runtimeType,
        Left<Failure, Prediction>(Failure()).runtimeType);
  });

  test('Should return left if the service throws', () async {
    when(predictionsService.predictDisease(payload: perfectPredictionPayload))
        .thenThrow(Exception());
    final prediction = await predictDisease(payload: perfectPredictionPayload);

    expect(prediction.runtimeType,
        Left<Failure, Prediction>(Failure()).runtimeType);
  });

  test('Should return left if the service throws InvalidPredictionPayloadError',
      () async {
    when(predictionsService.predictDisease(payload: perfectPredictionPayload))
        .thenThrow(InvalidPredictionPayloadError());
    final prediction = await predictDisease(payload: perfectPredictionPayload);

    expect(prediction.runtimeType,
        Left<Failure, Prediction>(Failure()).runtimeType);
  });
}
