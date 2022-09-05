import 'package:dartz/dartz.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/domain/entities/prediction_payload.dart';
import 'package:mobile/app/main/domain/entities/retry_prediction_payload.dart';
import 'package:mobile/errors/errors.dart';

abstract class IPredictionsService {
  Future<Either<Failure, Prediction>> getPrediction({
    required String id,
  });

  Future<Either<Failure, List<Prediction>>> listPredictions();

  Future<Either<Failure, Prediction>> predictDisease({
    required PredictionPayload payload,
  });

  Future<Either<Failure, Prediction>> retry({
    required RetryPredictionPayload payload,
  });
}
