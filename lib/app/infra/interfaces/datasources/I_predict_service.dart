import 'package:mobile/app/domain/entities/prediction_payload.dart';
import 'package:mobile/app/domain/entities/prediction.dart';

abstract class IPredictDiseaseService {
  Future<Prediction> call({
    required PredictionPayload payload,
  });
}
