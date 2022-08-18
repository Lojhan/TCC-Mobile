import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/domain/errors/errors.dart';
import 'package:mobile/app/presentation/BloC/predict_disease/predict_disease_bloc.dart';
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
      await initPrediting(context, bloc);
    } on NoCamerasAvailableException {
      showNoCamerasToast(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final PredictDiseaseBloc predictDiseaseBloc = Modular.get();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: BlocListener<PredictDiseaseBloc, PredictDiseaseState>(
        bloc: predictDiseaseBloc,
        listener: (context, state) {
          if (state.failure != null) {
            showPredictionFailureDialog(context, state.failure!);
          } else if (state.prediction != null) {
            showPrediction(context, state.prediction!);
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
