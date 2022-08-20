import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/domain/entities/prediction_payload.dart';
import 'package:mobile/app/main/domain/usecases/predict_disease.usecase.dart';
import 'package:mobile/errors/errors.dart';
import 'package:mobile/app/presentation/BloC/main/list_predictions/list_predictions_bloc.dart';

part 'predict_disease_event.dart';
part 'predict_disease_state.dart';

class PredictDiseaseBloc extends Bloc<PDEvent, PredictDiseaseState> {
  final PredictDisease usecase;
  final ListPredictionsBloc listPredictionsBloc;
  PredictDiseaseBloc({
    required this.usecase,
    required this.listPredictionsBloc,
  }) : super(PredictDiseaseState.initial()) {
    on<PredictDiseaseEvent>(predict);
    on<PredictDiseaseFailureEvent>(failure);
    on<PredictDiseaseSuccessEvent>(success);
  }

  FutureOr<void> predict(
    PredictDiseaseEvent event,
    Emitter<PredictDiseaseState> emit,
  ) async {
    emit(PredictDiseaseState.loading());
    try {
      final result = await usecase(payload: event.payload);
      result.fold(
        (l) => add(PredictDiseaseFailureEvent(
          payload: event.payload,
          failure: l,
        )),
        (r) => add(PredictDiseaseSuccessEvent(
          payload: event.payload,
          prediction: r,
        )),
      );
    } on Failure catch (failure) {
      add(PredictDiseaseFailureEvent(
        payload: event.payload,
        failure: failure,
      ));
    } on Exception {
      emit(PredictDiseaseState.failure(Failure()));
    }
  }

  sendToPredictions({
    PredictionPayload? payload,
    Prediction? prediction,
  }) {
    if (prediction != null || payload != null) {
      listPredictionsBloc.add(PushNewPredictionEvent(
        prediction: Prediction.mergeResponsePayload(prediction, payload),
      ));
    } else {
      throw Exception('No payload or prediction');
    }
  }

  FutureOr<void> failure(
    PredictDiseaseFailureEvent event,
    Emitter<PredictDiseaseState> emit,
  ) async {
    emit(PredictDiseaseState.failure(Failure()));
    sendToPredictions(payload: event.payload);
  }

  FutureOr<void> success(
    PredictDiseaseSuccessEvent event,
    Emitter<PredictDiseaseState> emit,
  ) async {
    emit(PredictDiseaseState.success(event.prediction));
    sendToPredictions(payload: event.payload, prediction: event.prediction);
  }
}
