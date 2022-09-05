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
  final Prediction? prediction;
  const PredictDiseaseFailureEvent({
    required this.payload,
    required this.failure,
    this.prediction,
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

class PredictDiseaseRetryEvent extends PDEvent {
  final RetryPredictionPayload payload;

  const PredictDiseaseRetryEvent({
    required this.payload,
  });
}

class PredictDiseaseRetrySuccessEvent extends PDEvent {
  final Prediction prediction;
  final RetryPredictionPayload payload;
  const PredictDiseaseRetrySuccessEvent({
    required this.payload,
    required this.prediction,
  });
}

class PredictDiseaseRetryFailureEvent extends PDEvent {
  final Failure failure;
  final PredictionPayload payload;
  const PredictDiseaseRetryFailureEvent({
    required this.payload,
    required this.failure,
  });
}
