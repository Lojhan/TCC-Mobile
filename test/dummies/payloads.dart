import 'dart:io';

import 'package:mobile/app/main/domain/entities/prediction_payload.dart';

import 'files.dart';

PredictionPayload perfectPredictionPayload = PredictionPayload(
  payload: FileDummy.file,
);

PredictionPayload invalidPredictionPayload = PredictionPayload(
  payload: File(''),
);
