import 'package:dartz/dartz.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/app/domain/errors/errors.dart';
import 'package:mobile/app/domain/interfaces/services/i_predictions_service.dart';

class DisplayPrediction {
  final IPredictionsService predictionsService;

  DisplayPrediction({required this.predictionsService});

  Future<Either<Failure, Prediction>> call(String id) async {
    try {
      final prediction = await predictionsService.getPrediction(id: id);
      return prediction.fold(
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
