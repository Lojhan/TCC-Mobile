import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/domain/entities/prediction_payload.dart';
import 'package:mobile/app/domain/errors/errors.dart';
import 'package:mobile/app/presentation/BloC/predict_disease/predict_disease_bloc.dart';
import 'package:mobile/app/presentation/screens/camera_page.dart';

FutureOr<void> initPrediting(
  BuildContext context,
  PredictDiseaseBloc bloc,
) async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    final cameras = await availableCameras();

    String? file = await Modular.to.push(
      MaterialPageRoute(
        builder: (context) => TakePictureScreen(camera: cameras.first),
      ),
    );

    if (file == null) {
      return;
    }

    PredictionPayload payload = await PredictionPayload.fromImageFilePath(file);

    return bloc.add(PredictDiseaseEvent(payload: payload));
  } on Failure {
    return;
  } on Exception {
    return;
  }
}
