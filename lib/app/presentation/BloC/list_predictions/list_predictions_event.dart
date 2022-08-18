part of 'list_predictions_bloc.dart';

abstract class LPEvent extends Equatable {
  const LPEvent();

  @override
  List<Object> get props => [];
}

class ListPredictionsEvent extends LPEvent {
  final List<Prediction> predictions;

  const ListPredictionsEvent({
    required this.predictions,
  });

  @override
  List<Object> get props => [predictions];
}

class LoadRemotePredictionsEvent extends LPEvent {}

class PushNewPredictionEvent extends LPEvent {
  final Prediction prediction;
  const PushNewPredictionEvent({required this.prediction});

  @override
  List<Object> get props => [prediction];
}
