import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/domain/entities/prediction_payload.dart';

abstract class IPredictDiseaseService {
  Future<Prediction> call({
    required PredictionPayload payload,
  });
}
