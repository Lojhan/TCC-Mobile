import 'package:mobile/app/domain/errors/errors.dart';
import 'package:mobile/app/domain/entities/prediction_payload.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:dartz/dartz.dart';
import 'package:mobile/app/domain/interfaces/services/i_predictions_service.dart';
import 'package:mobile/app/infra/interfaces/datasources/I_predict_service.dart';
import 'package:mobile/app/infra/interfaces/i_predictions_repository.dart';

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
    } catch (e) {
      return Left(Failure());
    }
  }
}
