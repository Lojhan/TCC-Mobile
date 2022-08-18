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
    final file = payload.payload;
    String fileName = file.path.split('/').last;
    String path = file.path;

    final multipart = await MultipartFile.fromFile(path, filename: fileName);

    FormData data = FormData.fromMap({"payload": multipart});
    Response response = await dioInstance.post(baseUrl, data: data);

    return Prediction.fromRemote(response.data!);
  }
}
