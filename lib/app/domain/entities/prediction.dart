import 'dart:convert';
import 'dart:io';

import 'package:mobile/app/domain/entities/prediction_payload.dart';
import 'package:mobile/helpers/valid_datestring.dart';

class Prediction {
  final String id;
  final String localImagePath;
  final String remoteImagePath;
  final String dx;
  final String diseaseName;
  final DateTime createdAt;
  final bool predicted;

  String get image =>
      localImagePath.isNotEmpty ? localImagePath : remoteImagePath;

  Prediction({
    required this.id,
    this.localImagePath = '',
    this.remoteImagePath = '',
    required this.dx,
    required this.diseaseName,
    required this.createdAt,
    required this.predicted,
  });

  factory Prediction.fromRemote(Map<String, dynamic> json) {
    String dateString = json['createdAt'];
    return Prediction(
      id: json['id'],
      remoteImagePath: json['remoteImagePath'],
      dx: json['dx'],
      diseaseName: json['diseaseName'],
      createdAt: validDateString(dateString)
          ? DateTime.parse(dateString)
          : DateTime.now(),
      predicted: json['predicted'],
    );
  }

  factory Prediction.fromLocal(Map<String, dynamic> payload) {
    String dateString = payload['createdAt'];
    String? predictedString = payload['predicted'];
    Prediction prediction = Prediction(
      id: payload['id'],
      localImagePath: payload['localImagePath'],
      dx: payload['dx'],
      diseaseName: payload['diseaseName'],
      createdAt: validDateString(dateString)
          ? DateTime.parse(dateString)
          : DateTime.now(),
      predicted: predictedString != null ? predictedString == 'true' : false,
    );
    return prediction;
  }

  factory Prediction.fromPayload(PredictionPayload payload) {
    return Prediction(
      id: DateTime.now().toString(),
      localImagePath: payload.payload.path,
      remoteImagePath: 'not uploaded',
      dx: 'undetermined',
      diseaseName: 'undetermined',
      createdAt: DateTime.now(),
      predicted: false,
    );
  }

  factory Prediction.fromJson(Map<String, dynamic> json) {
    var predicted = json['predicted'];

    predicted ??= false;

    if (predicted is String) {
      predicted = predicted == 'true';
    }
    return Prediction(
      id: json['id'],
      localImagePath: json['localImagePath'],
      remoteImagePath: json['remoteImagePath'],
      dx: json['dx'],
      diseaseName: json['diseaseName'],
      createdAt: DateTime.parse(json['createdAt']),
      predicted: predicted,
    );
  }

  factory Prediction.mergeResponsePayload(
    Prediction prediction,
    PredictionPayload payload,
  ) {
    return Prediction(
      id: prediction.id,
      localImagePath: payload.payload.path,
      remoteImagePath: prediction.remoteImagePath,
      dx: prediction.dx,
      diseaseName: prediction.diseaseName,
      createdAt: prediction.createdAt,
      predicted: prediction.predicted,
    );
  }

  Map<String, dynamic> get toJson => {
        'id': id,
        'localImagePath': localImagePath,
        'remoteImagePath': remoteImagePath,
        'dx': dx,
        'diseaseName': diseaseName,
        'createdAt': createdAt.toIso8601String(),
        'predicted': predicted.toString(),
      };

  bool renderable() {
    if (id.isEmpty) {
      return false;
    }

    if (dx.isEmpty) {
      return false;
    }

    if (diseaseName.isEmpty) {
      return false;
    }

    if (localImagePath.isEmpty && remoteImagePath.isEmpty) {
      return false;
    }

    return true;
  }
}
