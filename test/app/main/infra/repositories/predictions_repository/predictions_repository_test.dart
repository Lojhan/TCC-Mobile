import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/errors/errors.dart';
import 'package:mobile/app/main/external/datasources/prediction_remote_datasource.dart';
import 'package:mobile/app/main/infra/repositories/predictions_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../../dummies/predictions.dart';
import '../../../../../dummies/strings.dart';
import 'predictions_repository_test.mocks.dart';

@GenerateMocks([PredictionRemoteDatasource])
void main() {
  PredictionRemoteDatasource datasource = MockPredictionRemoteDatasource();

  PredictionsRepository predictionsRepository = PredictionsRepository(
    remoteDatasource: datasource,
  );

  group('getPrediction', () {
    test('Should correctly get a prediction by id', () async {
      when(datasource.getById(StringDummy.id))
          .thenAnswer((_) async => perfectPrediction);

      final result =
          await predictionsRepository.getPrediction(id: StringDummy.id);
      expect(result, isA<Right<Failure, Prediction>>());
    });

    test('Should return left if the datasource fails', () async {
      when(datasource.getById(StringDummy.id)).thenThrow(Failure());
      final result =
          await predictionsRepository.getPrediction(id: StringDummy.id);
      expect(result, isA<Left<Failure, Prediction>>());
    });

    test('Should return left if the datasource throws', () async {
      when(datasource.getById(StringDummy.id)).thenThrow(Exception());
      final result =
          await predictionsRepository.getPrediction(id: StringDummy.id);
      expect(result, isA<Left<Failure, Prediction>>());
    });
  });

  group('listPredictions', () {
    test('Should correctly list predictions', () async {
      when(datasource.list())
          .thenAnswer((_) async => List<Prediction>.from([perfectPrediction]));

      final result = await predictionsRepository.listPredictions();
      expect(result, isA<Right<Failure, List<Prediction>>>());
    });

    test('Should return left if the datasource fails', () async {
      when(datasource.list()).thenThrow(Failure());
      final result = await predictionsRepository.listPredictions();
      expect(result, isA<Left<Failure, List<Prediction>>>());
    });

    test('Should return left if the datasource throws', () async {
      when(datasource.list()).thenThrow(Exception());
      final result = await predictionsRepository.listPredictions();
      expect(result, isA<Left<Failure, List<Prediction>>>());
    });
  });
}
