import 'package:dio/dio.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/domain/entities/prediction_payload.dart';
import 'package:mobile/app/main/domain/interfaces/services/i_predictions_service.dart';
import 'package:mobile/app/main/infra/interfaces/datasources/i_predict_service.dart';
import 'package:mobile/app/main/infra/interfaces/i_predictions_repository.dart';
import 'package:mobile/errors/errors.dart';
import 'package:dartz/dartz.dart';

class PredictionsService implements IPredictionsService {
  final IPredictionsRepository predictionsRepository;
  final IPredictDiseaseService predictService;

  PredictionsService({
    required this.predictionsRepository,
    required this.predictService,
  });

  @override
  Future<Either<Failure, Prediction>> getPrediction({
    required String id,
  }) {
    return predictionsRepository.getPrediction(id: id);
  }

  @override
  Future<Either<Failure, List<Prediction>>> listPredictions() {
    return predictionsRepository.listPredictions();
  }

  @override
  Future<Either<Failure, Prediction>> predictDisease({
    required PredictionPayload payload,
  }) async {
    try {
      Prediction result = await predictService(payload: payload);
      return Right(result);
    } on Failure {
      return Left(Failure());
    } on DioError catch (e) {
      if ([
        DioErrorType.connectTimeout,
        DioErrorType.receiveTimeout,
        DioErrorType.sendTimeout
      ].contains(e.type)) {
        return Left(TimeoutFailure());
      } else {
        return Left(Failure());
      }
    } on Error {
      return Left(Failure());
    } on Exception {
      return Left(Failure());
    }
  }
}
