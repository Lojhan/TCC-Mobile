import 'package:equatable/equatable.dart';
import 'package:mobile/app/domain/entities/prediction_payload.dart';
import 'package:mobile/helpers/valid_datestring.dart';

class Prediction extends Equatable {
  final String id;
  final String localImagePath;
  final String remoteImagePath;
  final String dx;
  final String diseaseName;
  final DateTime createdAt;
  final bool predicted;

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
  });

  factory Prediction.fromRemote(Map<String, dynamic> json) {
    return Prediction(
      id: json['id'],
      remoteImagePath: json['remoteImagePath'],
      dx: json['dx'],
      diseaseName: json['diseaseName'],
      createdAt: formatDate(json['createdAt']),
      predicted: json['predicted'],
    );
  }

  factory Prediction.fromLocal(Map<String, dynamic> payload) {
    Prediction prediction = Prediction(
      id: payload['id'],
      localImagePath: payload['localImagePath'],
      dx: payload['dx'],
      diseaseName: payload['diseaseName'],
      createdAt: formatDate(payload['createdAt']),
      predicted: formatPredicted(payload['predicted']),
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
    return Prediction(
      id: json['id'],
      localImagePath: json['localImagePath'],
      remoteImagePath: json['remoteImagePath'],
      dx: json['dx'],
      diseaseName: json['diseaseName'],
      createdAt: formatDate(json['createdAt']),
      predicted: formatPredicted(json['predicted']),
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

  static bool formatPredicted(dynamic prediction) {
    var predicted = prediction;

    predicted ??= false;

    if (predicted is String) {
      predicted = predicted == 'true';
    }

    return predicted;
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
