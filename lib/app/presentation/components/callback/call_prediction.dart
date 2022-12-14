import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/app/main/domain/entities/prediction_payload.dart';
import 'package:mobile/app/presentation/BloC/main/predict_disease/predict_disease_bloc.dart';

FutureOr<void> initPrediting(
  BuildContext context,
  PredictDiseaseBloc bloc,
  ImageSource source,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  final ImagePicker picker = ImagePicker();

  final XFile? file = await picker.pickImage(source: source);

  if (file == null) {
    return;
  }

  PredictionPayload p = await PredictionPayload.fromImageFilePath(file.path);
  return bloc.add(PredictDiseaseEvent(payload: p));
}
