part of 'predict_disease_bloc.dart';

class PredictDiseaseState extends Equatable {
  final Prediction? prediction;
  final Failure? failure;

  const PredictDiseaseState({
    required this.prediction,
    required this.failure,
  });

  factory PredictDiseaseState.initial() {
    return const PredictDiseaseState(
      prediction: null,
      failure: null,
    );
  }

  @override
  List<Object?> get props => [prediction, failure];

  PredictDiseaseState copyWith({
    Prediction? prediction,
    Failure? failure,
  }) {
    return PredictDiseaseState(
      prediction: prediction ?? this.prediction,
      failure: failure ?? this.failure,
    );
  }
}
