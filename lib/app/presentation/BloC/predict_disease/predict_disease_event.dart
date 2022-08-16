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
