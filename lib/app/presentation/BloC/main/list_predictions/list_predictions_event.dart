part of 'list_predictions_bloc.dart';

abstract class LPEvent extends Equatable {
  const LPEvent();

  @override
  List<Object> get props => [];
}

class ListPredictionsEvent extends LPEvent {}

class LoadRemotePredictionsEvent extends LPEvent {}

class PushNewPredictionEvent extends LPEvent {
  final Prediction prediction;
  const PushNewPredictionEvent({required this.prediction});

  @override
  List<Object> get props => [prediction];
}
