import 'package:dio/dio.dart';
import 'package:mobile/app/domain/entities/prediction_payload.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/app/infra/interfaces/datasources/I_predict_service.dart';

class PredictDiseaseService implements IPredictDiseaseService {
  Dio dioInstance;
  String baseUrl;
  PredictDiseaseService({required this.dioInstance, required this.baseUrl});

  @override
  Future<Prediction> call({required PredictionPayload payload}) {
    return dioInstance.post('/predict', data: payload).then((response) {
      return Prediction.fromRemote(response.data);
    });
  }
}
