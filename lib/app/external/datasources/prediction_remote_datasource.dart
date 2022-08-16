import 'package:dio/dio.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/app/infra/interfaces/datasources/i_remote_datasource.dart';

class PredictionRemoteDatasource implements IRemoteDatasource {
  Dio dioInstance;
  String baseUrl;

  PredictionRemoteDatasource({
    required this.dioInstance,
    required this.baseUrl,
  });

  @override
  Future delete(String id) {
    return dioInstance.delete('baseUrl/$id');
  }

  @override
  Future getById(String id) {
    return dioInstance.get('baseUrl/$id');
  }

  @override
  Future<List<Prediction>> list() {
    return dioInstance.get('baseUrl').then((response) => response.data);
  }

  @override
  Future save(model) {
    return dioInstance.post('baseUrl', data: model);
  }

  @override
  Future update(model) {
    return dioInstance.put('baseUrl', data: model);
  }
}
