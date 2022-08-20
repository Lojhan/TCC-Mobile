import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/infra/interfaces/datasources/i_remote_datasource.dart';

class PredictionRemoteDatasource implements IRemoteDatasource<Prediction> {
  Dio dioInstance;
  String baseUrl;

  PredictionRemoteDatasource({
    required this.dioInstance,
    required this.baseUrl,
  });

  @override
  Future<Prediction?> getById(String id) {
    return dioInstance
        .get('$baseUrl/$id')
        .then((response) => response.data)
        .then((data) => Prediction.fromRemote(data));
  }

  @override
  Future<List<Prediction>?> list() {
    return dioInstance
        .get(baseUrl)
        .then((response) => response.data)
        .then((data) {
      final decoded = jsonDecode(data);
      final mapped = decoded.map((item) => Prediction.fromRemote(item));

      List<Prediction> list = [];

      for (var item in mapped) {
        list.add(item);
      }
      return list;
    });
  }

  @override
  Future<Prediction?> save(Prediction model) {
    return dioInstance
        .post(baseUrl, data: model.toJson)
        .then((res) => Prediction.fromRemote(res.data));
  }

  @override
  Future<Prediction?> update(Prediction model) {
    return dioInstance
        .put('$baseUrl/id', data: model.toJson)
        .then((res) => Prediction.fromRemote(jsonDecode(res.data)));
  }

  @override
  Future<Prediction?> delete(String id) {
    return dioInstance
        .delete('$baseUrl/$id')
        .then((res) => Prediction.fromRemote(res.data));
  }
}
