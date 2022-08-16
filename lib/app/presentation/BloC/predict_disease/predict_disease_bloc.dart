import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/app/domain/entities/prediction_payload.dart';
import 'package:mobile/app/domain/errors/errors.dart';
import 'package:mobile/app/domain/usecases/predict_disease.usecase.dart';

part 'predict_disease_event.dart';
part 'predict_disease_state.dart';

class PredictDiseaseBloc
    extends Bloc<PredictDiseaseEvent, PredictDiseaseState> {
  final PredictDisease usecase;
  PredictDiseaseBloc({
    required this.usecase,
  }) : super(PredictDiseaseState.initial()) {
    on<PredictDiseaseEvent>(predict);
  }

  FutureOr<void> predict(
    PredictDiseaseEvent event,
    Emitter<PredictDiseaseState> emit,
  ) async {
    emit(state.copyWith(
      prediction: null,
      failure: null,
    ));
    try {
      final result = await usecase(payload: event.payload);
      result.fold((l) => emit(state.copyWith(prediction: null, failure: l)),
          (r) => emit(state.copyWith(prediction: r, failure: null)));
    } on Failure catch (failure) {
      emit(state.copyWith(
        prediction: null,
        failure: failure,
      ));
    }
  }
}
