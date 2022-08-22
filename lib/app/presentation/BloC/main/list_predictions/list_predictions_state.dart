part of 'list_predictions_bloc.dart';

class ListPredictionsState extends Equatable implements StatePayload {
  final List<Prediction> predictions;
  final Failure? failure;
  final bool isLoading;

  const ListPredictionsState({
    required this.predictions,
    required this.failure,
    required this.isLoading,
  });

  factory ListPredictionsState.copyWith(
      List<Prediction> preds, Prediction prediction) {
    List<Prediction> newPreds = List.from(preds)..add(prediction);
    return ListPredictionsState(
      predictions: newPreds,
      failure: null,
      isLoading: false,
    );
  }

  factory ListPredictionsState.initial() {
    return const ListPredictionsState(
      predictions: [],
      failure: null,
      isLoading: false,
    );
  }

  factory ListPredictionsState.loading() {
    return const ListPredictionsState(
      predictions: [],
      failure: null,
      isLoading: true,
    );
  }

  factory ListPredictionsState.success(List<Prediction> predictions) {
    return ListPredictionsState(
      predictions: predictions,
      failure: null,
      isLoading: false,
    );
  }

  factory ListPredictionsState.failure(Failure failure) {
    return ListPredictionsState(
      predictions: const [],
      failure: failure,
      isLoading: false,
    );
  }

  @override
  List<Object?> get props => [predictions, failure, isLoading];

  ListPredictionsState copyWith({
    required List<Prediction> predictions,
    Failure? failure,
    bool isLoading = false,
  }) {
    return ListPredictionsState(
      predictions: predictions,
      failure: failure ?? this.failure,
      isLoading: isLoading,
    );
  }

  get awaitingRetry => predictions.where((p) => !p.predicted).toList();

  @override
  get state => predictions;

  @override
  get hasData => predictions.isNotEmpty;

  @override
  bool? get failed => failure is Failure;

  @override
  bool get loading => isLoading;
}
