import 'package:dartz/dartz.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/app/domain/errors/errors.dart';

abstract class IPredictionsRepository {
  Future<Either<Failure, List<Prediction>>> listPredictions();

  Future<Either<Failure, Prediction>> getPrediction({
    required String id,
  });
}
