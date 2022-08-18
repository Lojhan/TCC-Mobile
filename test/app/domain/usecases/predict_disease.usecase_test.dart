import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/domain/interfaces/services/i_predictions_service.dart';
import 'package:mobile/app/domain/usecases/predict_disease.usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummies/predictionPayloads.dart';
import '../../../dummies/predictions.dart';
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
}
