import 'package:mobile/app/domain/errors/errors.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/app/external/datasources/prediction_local_datasource.dart';
import 'package:mobile/app/external/datasources/prediction_remote_datasource.dart';
import 'package:mobile/app/infra/interfaces/i_predictions_repository.dart';

class PredictionsRepository implements IPredictionsRepository {
  late PredictionLocalDataSource localDatasource;
  late PredictionRemoteDatasource remoteDatasource;

  PredictionsRepository({
    required this.localDatasource,
    required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, Prediction>> getPrediction({
    required String id,
  }) async {
    try {
      Prediction data = await localDatasource.getById(id);
      return Right(data);
    } on Failure {
      final data = await remoteDatasource.getById(id);
      return Right(data);
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, List<Prediction>>> listPredictions() async {
    try {
      List<Prediction> data = await localDatasource.list();
      return Right(data);
    } on Failure {
      final data = await remoteDatasource.list();
      return Right(data);
    } catch (e) {
      return Left(Failure());
    }
  }
}
