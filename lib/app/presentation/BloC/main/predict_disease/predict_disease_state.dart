part of 'predict_disease_bloc.dart';

class PredictDiseaseState extends Equatable {
  final Prediction? prediction;
  final Failure? failure;
  final bool isLoading;

  const PredictDiseaseState({
    required this.prediction,
    required this.failure,
    required this.isLoading,
  });

  factory PredictDiseaseState.initial() {
    return const PredictDiseaseState(
      prediction: null,
      failure: null,
      isLoading: false,
    );
  }

  factory PredictDiseaseState.loading() {
    return const PredictDiseaseState(
      prediction: null,
      failure: null,
      isLoading: true,
    );
  }

  factory PredictDiseaseState.success(Prediction prediction) {
    return PredictDiseaseState(
      prediction: prediction,
      failure: null,
      isLoading: false,
    );
  }

  factory PredictDiseaseState.failure(Failure failure) {
    return PredictDiseaseState(
      prediction: null,
      failure: failure,
      isLoading: false,
    );
  }

  @override
  List<Object?> get props => [prediction, failure];

  PredictDiseaseState copyWith({
    Prediction? prediction,
    Failure? failure,
    bool isLoading = false,
  }) {
    return PredictDiseaseState(
      prediction: prediction ?? this.prediction,
      failure: failure ?? this.failure,
      isLoading: isLoading,
    );
  }
}
