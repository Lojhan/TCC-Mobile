import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/app/domain/errors/errors.dart';
import 'package:mobile/app/domain/interfaces/services/i_predictions_service.dart';
import 'package:mobile/app/domain/usecases/list_predictions.usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummies/predictions.dart';
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

    final predictions = await listPredictions.call();
    expect(
        predictions.runtimeType,
        Right<Failure, List<Prediction>>(<Prediction>[perfectPrediction])
            .runtimeType);
  });
}
