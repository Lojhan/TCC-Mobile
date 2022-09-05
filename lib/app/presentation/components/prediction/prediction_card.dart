import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/domain/entities/retry_prediction_payload.dart';
import 'package:mobile/app/presentation/BloC/main/predict_disease/predict_disease_bloc.dart';
import 'package:mobile/app/presentation/components/misc/image_provider.dart';

class PredictionCard extends StatelessWidget {
  final Prediction prediction;
  const PredictionCard({
    Key? key,
    required this.prediction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PredictDiseaseBloc predictDiseaseBloc = Modular.get<PredictDiseaseBloc>();
    const titleStyle = TextStyle(fontSize: 20);
    const subtitleStyle = TextStyle(fontSize: 16);

    void retryPrediction() {
      RetryPredictionPayload payload =
          RetryPredictionPayload.fromPrediction(prediction);
      PredictDiseaseRetryEvent event =
          PredictDiseaseRetryEvent(payload: payload);
      return predictDiseaseBloc.add(event);
    }

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
        ),
        leading: InkWell(
          onTap: retryPrediction,
          child: const CircleAvatar(
            child: Icon(Icons.redo),
          ),
        ),
        trailing: SizedBox(
          height: 300,
          child: Image(
            image: getImageProvider(prediction.image),
            fit: BoxFit.cover,
            width: 100,
          ),
        ),
        title: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(prediction.diseaseName, style: titleStyle),
              Text(prediction.dx, style: subtitleStyle),
            ],
          ),
        ),
      ),
    );
  }
}
