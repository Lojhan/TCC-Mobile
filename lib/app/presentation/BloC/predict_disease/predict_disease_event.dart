part of 'predict_disease_bloc.dart';

abstract class PDEvent extends Equatable {
  const PDEvent();

  @override
  List<Object> get props => [];
}

class PredictDiseaseEvent extends PDEvent {
  final PredictionPayload payload;

  const PredictDiseaseEvent({
    required this.payload,
  });
}

class PredictDiseaseFailureEvent extends PDEvent {
  final PredictionPayload payload;
  final Failure failure;
  const PredictDiseaseFailureEvent({
    required this.payload,
    required this.failure,
  });
}

class PredictDiseaseSuccessEvent extends PDEvent {
  final Prediction prediction;
  final PredictionPayload payload;

  const PredictDiseaseSuccessEvent({
    required this.payload,
    required this.prediction,
  });
}
