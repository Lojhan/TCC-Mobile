import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/presentation/BloC/main/list_predictions/list_predictions_bloc.dart';
import 'package:mobile/app/presentation/BloC/main/predict_disease/predict_disease_bloc.dart';
import 'package:mobile/app/presentation/components/prediction/prediction_failure.dart';
import 'package:mobile/app/presentation/components/prediction/prediction_success.dart';

FutureOr showPrediction(
  BuildContext context,
  Prediction prediction,
) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    anchorPoint: Offset(100, MediaQuery.of(context).viewInsets.bottom),
    builder: (_) => PredictionWrapper(prediction),
  );
}

class PredictionWrapper extends StatelessWidget {
  final PredictDiseaseBloc predictDiseaseBloc = Modular.get();
  final ListPredictionsBloc listPredictionsBloc = Modular.get();
  final Prediction prediction;

  PredictionWrapper(this.prediction, {Key? key}) : super(key: key);

  Widget decideFromState(Prediction prediction) {
    bool predicted = prediction.predicted;

    if (predicted) {
      return PredictionSuccess(prediction);
    }
    return PredictionFailure(prediction);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListPredictionsBloc, ListPredictionsState>(
        bloc: listPredictionsBloc,
        builder: (context, state) {
          List<Prediction> predictions = state.predictions;
          int predIndex = predictions.indexWhere(
            (pred) => pred.localImagePath == prediction.localImagePath,
          );

          Prediction? pred;

          if (predIndex != -1) {
            pred = predictions[predIndex];
          } else {
            pred = prediction;
          }

          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(12.0),
            child: decideFromState(pred),
          );
        });
  }
}
