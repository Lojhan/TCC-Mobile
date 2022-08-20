import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/errors/errors.dart';
import 'package:mobile/app/main/domain/interfaces/services/i_predictions_service.dart';
import 'package:mobile/app/main/domain/usecases/display_predictions.usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../dummies/predictions.dart';
import 'display_prediction.usecase_test.mocks.dart';

@GenerateMocks([IPredictionsService])
final predictionFailure = Left<Failure, Prediction>(Failure()).runtimeType;
void main() {
  IPredictionsService predictionsService = MockIPredictionsService();
  DisplayPrediction displayPrediction = DisplayPrediction(
    predictionsService: predictionsService,
  );

  test('Should return a prediction by id', () async {
    when(predictionsService.getPrediction(id: 'id'))
        .thenAnswer((_) async => Right(perfectPrediction));

    final prediction = await displayPrediction('id');
    await untilCalled(predictionsService.getPrediction(id: 'id'));

    verify(predictionsService.getPrediction(id: 'id')).called(1);
    expect(prediction, Right<Failure, Prediction>(perfectPrediction));
  });

  test('Should return a failure when prediction not found', () async {
    when(predictionsService.getPrediction(id: 'id'))
        .thenAnswer((_) async => Left(Failure()));

    final prediction = await displayPrediction('');
    await untilCalled(predictionsService.getPrediction(id: ''));

    verify(predictionsService.getPrediction(id: '')).called(1);
    expect(prediction.runtimeType, predictionFailure);
  });

  test('Should return Left if the service fails', () async {
    when(predictionsService.getPrediction(id: ''))
        .thenAnswer((_) async => Left(Failure()));

    final prediction = await displayPrediction('');
    await untilCalled(predictionsService.getPrediction(id: ''));

    verify(predictionsService.getPrediction(id: '')).called(1);
    expect(prediction.runtimeType, predictionFailure);
  });

  test('Should return Left if the service throws', () async {
    when(predictionsService.getPrediction(id: '')).thenThrow(Failure());

    final prediction = await displayPrediction('');
    await untilCalled(predictionsService.getPrediction(id: ''));

    verify(predictionsService.getPrediction(id: '')).called(1);
    expect(prediction.runtimeType, predictionFailure);
  });
}
