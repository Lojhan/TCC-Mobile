import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/domain/entities/prediction_payload.dart';
import 'package:mobile/app/main/domain/entities/retry_prediction_payload.dart';
import 'package:mobile/app/main/domain/usecases/predict_disease.usecase.dart';
import 'package:mobile/app/main/domain/usecases/retry_prediction.usecase.dart';
import 'package:mobile/errors/errors.dart';
import 'package:mobile/app/presentation/BloC/main/list_predictions/list_predictions_bloc.dart';

part 'predict_disease_event.dart';
part 'predict_disease_state.dart';

class PredictDiseaseBloc extends Bloc<PDEvent, PredictDiseaseState> {
  final PredictDisease usecase;
  final RetryPredictDisease retryUsecase;

  final ListPredictionsBloc listPredictionsBloc;
  PredictDiseaseBloc({
    required this.usecase,
    required this.retryUsecase,
    required this.listPredictionsBloc,
  }) : super(PredictDiseaseState.initial()) {
    on<PredictDiseaseEvent>(predict);
    on<PredictDiseaseFailureEvent>(failure);
    on<PredictDiseaseSuccessEvent>(success);
    on<PredictDiseaseRetryEvent>(retry);
    on<PredictDiseaseRetrySuccessEvent>(retrySuccess);
    on<PredictDiseaseRetryFailureEvent>(retryFailure);
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

  FutureOr<void> retry(
    PredictDiseaseRetryEvent event,
    Emitter<PredictDiseaseState> emit,
  ) async {
    emit(PredictDiseaseState.loading());
    try {
      final result = await retryUsecase(payload: event.payload);
      result.fold(
        (l) => add(PredictDiseaseRetryFailureEvent(
          payload: event.payload.toPayload(),
          failure: l,
        )),
        (r) => add(PredictDiseaseRetrySuccessEvent(
          payload: event.payload,
          prediction: r,
        )),
      );
    } on Failure catch (failure) {
      add(PredictDiseaseFailureEvent(
        payload: event.payload.toPayload(),
        failure: failure,
      ));
    } on Exception {
      emit(PredictDiseaseState.failure(Failure()));
    }
  }

  void sendToPredictions({
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
    emit(PredictDiseaseState.initial());
    sendToPredictions(payload: event.payload);
  }

  FutureOr<void> success(
    PredictDiseaseSuccessEvent event,
    Emitter<PredictDiseaseState> emit,
  ) async {
    Prediction prediction = event.prediction;

    if (!prediction.predicted) {
      emit(PredictDiseaseState.failure(NotPredictedFailure()));
    } else {
      emit(PredictDiseaseState.success(event.prediction));
    }
    emit(PredictDiseaseState.initial());
    sendToPredictions(payload: event.payload, prediction: event.prediction);
  }

  FutureOr<void> retrySuccess(
    PredictDiseaseRetrySuccessEvent event,
    Emitter<PredictDiseaseState> emit,
  ) {
    listPredictionsBloc.add(
      UpdatePredictionEvent(
        prediction: event.prediction,
        predictionId: event.payload.predictionId,
      ),
    );
    emit(PredictDiseaseState.retrySuccess(event.prediction));
    emit(PredictDiseaseState.initial());
  }

  FutureOr<void> retryFailure(
    PredictDiseaseRetryFailureEvent event,
    Emitter<PredictDiseaseState> emit,
  ) {
    // TODO: implement retryFailure
  }
}
