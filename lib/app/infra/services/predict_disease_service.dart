import 'package:dio/dio.dart';
import 'package:mobile/app/domain/entities/prediction_payload.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/app/infra/interfaces/datasources/i_predict_service.dart';

class PredictDiseaseService implements IPredictDiseaseService {
  Dio dioInstance;
  String baseUrl;
  PredictDiseaseService({required this.dioInstance, required this.baseUrl});

  @override
  Future<Prediction> call({required PredictionPayload payload}) async {
    Response<Map<String, dynamic>> response =
        await dioInstance.post('$baseUrl/predict', data: payload.toJson());
    return Prediction.fromRemote(response.data!);
  }
}
