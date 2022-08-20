import 'package:dartz/dartz.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/domain/interfaces/services/i_predictions_service.dart';
import 'package:mobile/errors/errors.dart';

class ListPredictions {
  final IPredictionsService predictionsService;

  ListPredictions({required this.predictionsService});

  Future<Either<Failure, List<Prediction>>> call() async {
    try {
      final predictions = await predictionsService.listPredictions();
      return predictions.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
    } on Failure {
      return Left(Failure());
    } catch (e) {
      return Left(Failure());
    }
  }
}
