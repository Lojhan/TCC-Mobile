import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/app/presentation/components/misc/app_bar.dart';
import 'package:mobile/errors/errors.dart';
import 'package:mobile/app/presentation/BloC/main/predict_disease/predict_disease_bloc.dart';
import 'package:mobile/app/presentation/components/alert_dialog/prediction_failure.dart';
import 'package:mobile/app/presentation/components/bottom_sheet/no_cameras_available.dart';
import 'package:mobile/app/presentation/components/bottom_sheet/show_prediction.dart';
import 'package:mobile/app/presentation/components/callback/call_prediction.dart';
import 'package:mobile/app/presentation/components/listing/list_predictions.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  FutureOr<void> prediction(
      BuildContext context, PredictDiseaseBloc bloc) async {
    try {
      await initPrediting(context, bloc, ImageSource.camera);
    } on NoCamerasAvailableException {
      showNoCamerasToast(context);
    } on CameraPremissionException {
      // TODO: show permission dialog
    } on Exception catch (_) {
      // TODO: show error dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    final PredictDiseaseBloc predictDiseaseBloc = Modular.get();

    return Scaffold(
      appBar: const ApplicationBar(),
      body: BlocListener<PredictDiseaseBloc, PredictDiseaseState>(
        bloc: predictDiseaseBloc,
        listener: (context, state) async {
          if (state.failure != null) {
            return showPredictionFailureDialog(context, state.failure!);
          } else if (state.retriedPrediction != null) {
            return showPrediction(context, state.retriedPrediction!);
          } else if (state.prediction != null) {
            return showPrediction(context, state.prediction!);
          }
        },
        child: ListPredictionsComponent(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'defaultIcon',
        onPressed: () async => await prediction(context, predictDiseaseBloc),
        icon: const Icon(Icons.camera_alt),
        label: const Text('Predict'),
      ),
    );
  }
}
