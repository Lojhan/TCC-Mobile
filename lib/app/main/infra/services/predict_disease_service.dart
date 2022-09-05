import 'package:dio/dio.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/domain/entities/prediction_payload.dart';
import 'package:mobile/app/main/domain/entities/retry_prediction_payload.dart';
import 'package:mobile/app/main/infra/interfaces/datasources/i_predict_service.dart';
import 'package:mobile/errors/errors.dart';
import 'package:mobile/helpers/extended_multipart.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class PredictDiseaseService implements IPredictDiseaseService {
  Dio dioInstance;
  String baseUrl;
  PredictDiseaseService({required this.dioInstance, required this.baseUrl});

  @override
  Future<Prediction> call({
    required PredictionPayload payload,
  }) async {
    if (!payload.valid()) {
      throw InvalidPredictionPayloadError();
    }
    final file = payload.payload;
    String fileName = file.path.split('/').last;
    String path = file.path;

    final multipart = MultipartFileExtended.fromFileSync(
      path,
      filename: fileName,
      contentType: MediaType('image', 'png'),
    );

    FormData data = FormData.fromMap({"payload": multipart});
    Response response = await dioInstance.post('$baseUrl/predict', data: data);
    final prediction = Prediction.fromRemote(response.data);
    return Prediction.mergeResponsePayload(prediction, payload);
  }

  @override
  Future<Prediction> retry({
    required RetryPredictionPayload payload,
  }) async {
    if (!payload.isValid) {
      throw InvalidPredictionPayloadError();
    }

    final file = payload.payload;
    String fileName = file.path.split('/').last;
    String path = file.path;

    Map<String, dynamic> data = <String, dynamic>{};

    if (payload.isAvailableRemotely) {
      data.addAll({
        "remoteImagePath": payload.remoteImagePath,
        "id": payload.predictionId,
      });
    } else {
      final multipart = MultipartFileExtended.fromFileSync(
        path,
        filename: fileName,
        contentType: MediaType('image', 'png'),
      );
      data.addAll({"payload": multipart});
    }

    FormData formData = FormData.fromMap(data);

    Response response = await dioInstance.post(
      '$baseUrl/retry',
      data: formData,
    );
    final prediction = Prediction.fromRemote(response.data);
    return Prediction.mergeResponsePayload(prediction, payload.toPayload());
  }
}
