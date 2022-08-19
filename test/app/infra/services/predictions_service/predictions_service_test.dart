import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/app/domain/errors/errors.dart';
import 'package:mobile/app/infra/interfaces/datasources/i_predict_service.dart';
import 'package:mobile/app/infra/interfaces/i_predictions_repository.dart';
import 'package:mobile/app/infra/services/predictions_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummies/payloads.dart';
import '../../../../dummies/predictions.dart';
import '../../../../dummies/strings.dart';
import 'predictions_service_test.mocks.dart';

@GenerateMocks([IPredictionsRepository, IPredictDiseaseService])
void main() {
  final IPredictionsRepository predictionsRepository =
      MockIPredictionsRepository();
  final IPredictDiseaseService predictService = MockIPredictDiseaseService();
  PredictionsService service = PredictionsService(
    predictionsRepository: predictionsRepository,
    predictService: predictService,
  );

  test('Should correcly return a prediction by id', () async {
    when(predictionsRepository.getPrediction(id: StringDummy.id))
        .thenAnswer((_) => Future.value(Right(perfectPrediction)));

    final result = await service.getPrediction(id: StringDummy.id);
    expect(result, Right(perfectPrediction));
  });

  test('Should correcly return a list of predictions', () async {
    when(predictionsRepository.listPredictions()).thenAnswer(
      (_) async => Right<Failure, List<Prediction>>(List<Prediction>.from(
        [perfectPrediction],
      )),
    );

    final result = await service.listPredictions();
    expect(result, isA<Right<Failure, List<Prediction>>>());
  });

  test('Should correcly return a prediction', () async {
    when(predictService.call(payload: perfectPredictionPayload))
        .thenAnswer((_) async => perfectPrediction);
    final result =
        await service.predictDisease(payload: perfectPredictionPayload);
    expect(result, Right(perfectPrediction));
  });

  test('Should correcly return a failure when prediction fails', () async {
    when(predictService.call(payload: perfectPredictionPayload))
        .thenThrow(Failure());
    final result =
        await service.predictDisease(payload: perfectPredictionPayload);
    expect(result, isA<Left<Failure, Prediction>>());
  });

  test('Should correcly return a failure when prediction throws an error',
      () async {
    when(predictService.call(payload: perfectPredictionPayload))
        .thenThrow(Error());
    final result =
        await service.predictDisease(payload: perfectPredictionPayload);
    expect(result, isA<Left<Failure, Prediction>>());
  });

  test('Should correcly return a failure when prediction throws', () async {
    when(predictService.call(payload: perfectPredictionPayload))
        .thenThrow(Exception());
    final result =
        await service.predictDisease(payload: perfectPredictionPayload);
    expect(result, isA<Left<Failure, Prediction>>());
  });
}
