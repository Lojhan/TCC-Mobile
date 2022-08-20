import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/errors/errors.dart';
import 'package:mobile/app/domain/interfaces/services/i_predictions_service.dart';
import 'package:mobile/app/domain/usecases/list_predictions.usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummies/predictions.dart';
import 'list_prediction.usecase_test.mocks.dart';

@GenerateMocks([IPredictionsService])
void main() {
  IPredictionsService predictionsService = MockIPredictionsService();
  ListPredictions listPredictions = ListPredictions(
    predictionsService: predictionsService,
  );
  test('Should return a list of predictions', () async {
    when(predictionsService.listPredictions())
        .thenAnswer((_) async => Right(<Prediction>[perfectPrediction]));

    final predictions = await listPredictions();

    await untilCalled(predictionsService.listPredictions());

    verify(predictionsService.listPredictions()).called(1);
    expect(
        predictions.runtimeType,
        Right<Failure, List<Prediction>>(<Prediction>[perfectPrediction])
            .runtimeType);
  });

  test('Should return left if the service fails', () async {
    when(predictionsService.listPredictions())
        .thenAnswer((_) async => Left(Failure()));

    final predictions = await listPredictions();

    await untilCalled(predictionsService.listPredictions());

    verify(predictionsService.listPredictions()).called(1);
    expect(predictions.runtimeType,
        Left<Failure, List<Prediction>>(Failure()).runtimeType);
  });

  test('Should return left if the service throws', () async {
    when(predictionsService.listPredictions()).thenThrow(Failure());

    final predictions = await listPredictions();

    await untilCalled(predictionsService.listPredictions());

    verify(predictionsService.listPredictions()).called(1);
    expect(predictions.runtimeType,
        Left<Failure, List<Prediction>>(Failure()).runtimeType);
  });

  test('Should return left if the service excepts', () async {
    when(predictionsService.listPredictions()).thenThrow(Exception());

    final predictions = await listPredictions();

    await untilCalled(predictionsService.listPredictions());

    verify(predictionsService.listPredictions()).called(1);
    expect(predictions.runtimeType,
        Left<Failure, List<Prediction>>(Failure()).runtimeType);
  });
}
