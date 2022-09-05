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

class UpdatePredictionEvent extends LPEvent {
  final Prediction prediction;
  final String predictionId;
  const UpdatePredictionEvent({
    required this.prediction,
    required this.predictionId,
  });

  @override
  List<Object> get props => [prediction];
}

class DeletePredictionEvent extends LPEvent {
  final String predictionId;
  const DeletePredictionEvent({required this.predictionId});
}

class ResetPredictionsEvent extends LPEvent {}
