import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/app/domain/errors/errors.dart';
import 'package:mobile/app/domain/interfaces/services/i_predictions_service.dart';
import 'package:mobile/app/domain/usecases/display_predictions.usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummies/predictions.dart';
import 'display_prediction.usecase_test.mocks.dart';

@GenerateMocks([IPredictionsService])
void main() {
  IPredictionsService predictionsService = MockIPredictionsService();
  DisplayPrediction displayPrediction = DisplayPrediction(
    predictionsService: predictionsService,
  );

  test('Should return a prediction by id', () async {
    when(predictionsService.getPrediction(id: 'id'))
        .thenAnswer((_) async => Right(perfectPrediction));

    final prediction = await displayPrediction('id');

    expect(prediction, Right<Failure, Prediction>(perfectPrediction));
  });

  test('Should return a failure when prediction not found', () async {
    when(predictionsService.getPrediction(id: 'id'))
        .thenAnswer((_) async => Left(Failure()));

    final prediction = await displayPrediction('');
    expect(prediction.runtimeType,
        Left<Failure, Prediction>(Failure()).runtimeType);
  });

  test('Should return Left if the payload is invalid', () => {});
}
