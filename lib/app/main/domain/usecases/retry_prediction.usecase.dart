import 'package:dartz/dartz.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/domain/entities/retry_prediction_payload.dart';
import 'package:mobile/app/main/domain/interfaces/services/i_predictions_service.dart';
import 'package:mobile/errors/errors.dart';

class RetryPredictDisease {
  final IPredictionsService predictionsService;

  RetryPredictDisease({required this.predictionsService});

  Future<Either<Failure, Prediction>> call({
    required RetryPredictionPayload payload,
  }) async {
    if (!payload.isValid) {
      return Left(InvalidPredictionPayloadError());
    }

    try {
      final p = await predictionsService.retry(payload: payload);
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
