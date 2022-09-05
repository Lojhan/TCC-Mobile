import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/domain/entities/prediction_payload.dart';

class RetryPredictionPayload extends Equatable {
  final File payload;
  final String predictionId;
  final String remoteImagePath;

  const RetryPredictionPayload(
      {required this.payload,
      required this.remoteImagePath,
      required this.predictionId});

  factory RetryPredictionPayload.fromPrediction(Prediction prediction) {
    return RetryPredictionPayload(
      remoteImagePath: prediction.remoteImagePath,
      payload: File(prediction.localImagePath),
      predictionId: prediction.id,
    );
  }

  PredictionPayload toPayload() {
    return PredictionPayload(payload: payload);
  }

  @override
  List<Object?> get props => [payload, predictionId, remoteImagePath];

  bool get isValid => payload.existsSync();
  bool get isAvailableRemotely => remoteImagePath.isNotEmpty;
}
