import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobile/app/domain/entities/prediction.dart';
import 'package:mobile/app/domain/errors/errors.dart';
import 'package:mobile/app/domain/usecases/list_predictions.usecase.dart';
import 'package:mobile/app/presentation/components/misc/decide_from_state.dart';

part 'list_predictions_event.dart';
part 'list_predictions_state.dart';

class ListPredictionsBloc extends HydratedBloc<LPEvent, ListPredictionsState> {
  final ListPredictions usecase;
  late StreamSubscription subscription;

  ListPredictionsBloc({required this.usecase})
      : super(ListPredictionsState.initial()) {
    on<ListPredictionsEvent>(list);
    on<PushNewPredictionEvent>(push);
  }

  FutureOr<void> push(
    PushNewPredictionEvent event,
    Emitter<ListPredictionsState> emit,
  ) {
    ListPredictionsState newState = ListPredictionsState.copyWith(
      state.predictions,
      event.prediction,
    );
    emit(newState);
  }

  FutureOr<void> list(
    ListPredictionsEvent event,
    Emitter<ListPredictionsState> emit,
  ) async {
    emit(ListPredictionsState.loading());
    try {
      final result = await usecase();
      result.fold(
        (l) => emit(ListPredictionsState.failure(l)),
        (r) => emit(ListPredictionsState.success(r)),
      );
    } on Failure catch (failure) {
      emit(ListPredictionsState.failure(failure));
    } on Exception {
      emit(ListPredictionsState.failure(Failure()));
    }
  }

  @override
  ListPredictionsState? fromJson(Map<String, dynamic> json) {
    List<Prediction> predictions = [];

    if (json.containsKey('predictions')) {
      predictions = (json['predictions'] as List)
          .map((e) => Prediction.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return ListPredictionsState.success(predictions);
  }

  @override
  Map<String, dynamic>? toJson(ListPredictionsState state) {
    final jsonPredictions = state.predictions.map((e) => e.toJson).toList();
    return {
      'predictions': jsonPredictions,
    };
  }
}
