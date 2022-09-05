import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobile/app/authentication/domain/entities/user.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/domain/usecases/list_predictions.usecase.dart';
import 'package:mobile/app/presentation/BloC/authentication/authentication_bloc.dart';
import 'package:mobile/errors/errors.dart';
import 'package:mobile/app/presentation/components/misc/decide_from_state.dart';

part 'list_predictions_event.dart';
part 'list_predictions_state.dart';

class ListPredictionsBloc extends HydratedBloc<LPEvent, ListPredictionsState> {
  final ListPredictions usecase;
  late AuthenticationBloc authenticationBloc;

  ListPredictionsBloc({
    required this.usecase,
    required this.authenticationBloc,
  }) : super(ListPredictionsState.initial()) {
    on<ListPredictionsEvent>(list);
    on<PushNewPredictionEvent>(push);
    on<UpdatePredictionEvent>(update);
    on<ResetPredictionsEvent>(reset);
    authenticationBloc.stream.listen((
      AuthenticationState state,
    ) {
      if (state.failure is Failure) {
        return add(ResetPredictionsEvent());
      }
      if (state.user == null) {
        return add(ResetPredictionsEvent());
      }
      if (state.user is UserModel) {
        return add(ListPredictionsEvent());
      }
    });
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

  FutureOr<void> update(
    UpdatePredictionEvent event,
    Emitter<ListPredictionsState> emit,
  ) {
    ListPredictionsState newState = ListPredictionsState.updatePrediction(
      state.predictions,
      event.prediction,
      event.predictionId,
    );
    emit(newState);
  }

  FutureOr<void> reset(
    ResetPredictionsEvent event,
    Emitter<ListPredictionsState> emit,
  ) {
    emit(ListPredictionsState.initial());
  }
}
