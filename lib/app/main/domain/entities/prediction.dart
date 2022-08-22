import 'package:equatable/equatable.dart';
import 'package:mobile/app/main/domain/entities/prediction_payload.dart';
import 'package:mobile/helpers/valid_datestring.dart';

class Prediction extends Equatable {
  final String id;
  final String localImagePath;
  final String remoteImagePath;
  final String dx;
  final String diseaseName;
  final DateTime createdAt;
  final bool predicted;
  final bool validated;

  String get image =>
      localImagePath.isNotEmpty ? localImagePath : remoteImagePath;

  const Prediction({
    required this.id,
    this.localImagePath = '',
    this.remoteImagePath = '',
    required this.dx,
    required this.diseaseName,
    required this.createdAt,
    required this.predicted,
    required this.validated,
  });

  factory Prediction.fromRemote(Map<String, dynamic> json) {
    return Prediction(
      id: json['id'],
      localImagePath: '',
      remoteImagePath: json['remoteImagePath'],
      dx: json['dx'],
      diseaseName: json['diseaseName'],
      createdAt: formatDate(json['createdAt']),
      predicted: formatBool(json['predicted']),
      validated: formatBool(json['validated']),
    );
  }

  factory Prediction.fromLocal(Map<String, dynamic> payload) {
    Prediction prediction = Prediction(
      id: payload['id'],
      localImagePath: payload['localImagePath'],
      dx: payload['dx'],
      diseaseName: payload['diseaseName'],
      createdAt: formatDate(payload['createdAt']),
      predicted: formatBool(payload['predicted']),
      validated: formatBool(payload['validated']),
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
      validated: false,
    );
  }

  factory Prediction.fromJson(Map<String, dynamic> json) {
    return Prediction(
      id: json['id'],
      localImagePath: json['localImagePath'],
      remoteImagePath: json['remoteImagePath'],
      dx: json['dx'],
      diseaseName: json['diseaseName'],
      createdAt: formatDate(json['createdAt']),
      predicted: formatBool(json['predicted']),
      validated: formatBool(json['validated']),
    );
  }

  factory Prediction.mergeResponsePayload(
    Prediction? prediction,
    PredictionPayload? payload,
  ) {
    return Prediction(
      id: prediction?.id ?? payload?.payload.hashCode.toString() ?? '',
      localImagePath: payload?.payload.path ?? '',
      remoteImagePath: prediction?.remoteImagePath ?? '',
      dx: prediction?.dx ?? 'undetermined',
      diseaseName: prediction?.diseaseName ?? 'undetermined',
      createdAt: formatDate(prediction?.createdAt),
      predicted: formatBool(prediction?.predicted),
      validated: formatBool(prediction?.validated),
    );
  }

  Map<String, dynamic> get toJson => {
        'id': id,
        'localImagePath': localImagePath,
        'remoteImagePath': remoteImagePath,
        'dx': dx,
        'diseaseName': diseaseName,
        'createdAt': createdAt.toIso8601String(),
        'predicted': predicted,
      };

  @override
  List<Object?> get props => [
        id,
        localImagePath,
        remoteImagePath,
        dx,
        diseaseName,
        createdAt,
        predicted
      ];

  static bool formatBool(dynamic boolean) {
    var res = boolean;
    if (res == null) {
      return false;
    }
    res ??= boolean;

    if (res is String) {
      res = res == 'true';
    }

    return res;
  }

  static DateTime formatDate(dynamic date) {
    if (date is DateTime) {
      return date;
    }
    bool valid = validDateString(date);
    if (valid) {
      return DateTime.parse(date);
    }
    return DateTime.now();
  }
}
