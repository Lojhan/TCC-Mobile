import 'package:dartz/dartz.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/app/domain/entities/prediction_payload.dart';
import 'package:mobile/app/domain/interfaces/services/i_predictions_service.dart';
import 'package:mobile/errors/errors.dart';

class PredictDisease {
  final IPredictionsService predictionsService;

  PredictDisease({required this.predictionsService});

  Future<Either<Failure, Prediction>> call({
    required PredictionPayload payload,
  }) async {
    if (!payload.valid()) {
      return Left(InvalidPredictionPayloadError());
    }

    try {
      final p = await predictionsService.predictDisease(payload: payload);
      return p.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
    } on InvalidPredictionPayloadError {
      return Left(InvalidPredictionPayloadError());
    } on Failure {
      return Left(Failure());
    } catch (e) {
      return Left(Failure());
    }
  }
}
