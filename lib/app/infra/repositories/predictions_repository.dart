import 'package:mobile/app/domain/errors/errors.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/app/external/datasources/prediction_remote_datasource.dart';
import 'package:mobile/app/infra/interfaces/i_predictions_repository.dart';

class PredictionsRepository implements IPredictionsRepository {
  final PredictionRemoteDatasource remoteDatasource;

  PredictionsRepository({
    required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, Prediction>> getPrediction({
    required String id,
  }) async {
    try {
      final data = await remoteDatasource.getById(id);
      return Right(data!);
    } on Failure {
      return Left(Failure());
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<Prediction>>> listPredictions() async {
    try {
      final data = await remoteDatasource.list();
      return Right(data!);
    } on Failure {
      return Left(Failure());
    } catch (e) {
      return Left(Failure());
    }
  }
}
