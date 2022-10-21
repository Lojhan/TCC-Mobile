import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/main/domain/entities/retry_prediction_payload.dart';
import 'package:mobile/app/presentation/BloC/blocs.dart';
import 'package:mobile/app/presentation/components/misc/image_provider.dart';

class PredictionFailure extends StatefulWidget {
  final Prediction prediction;

  const PredictionFailure(this.prediction, {Key? key}) : super(key: key);

  @override
  State<PredictionFailure> createState() => _PredictionFailureState();
}

class _PredictionFailureState extends State<PredictionFailure> {
  final PredictDiseaseBloc predictDiseaseBloc = Modular.get();
  late Prediction prediction;

  @override
  void initState() {
    prediction = widget.prediction;
    super.initState();
  }

  void setRetriedPrediction(Prediction prediction) {
    setState(() {
      this.prediction = prediction;
    });
  }

  void retryPrediction() {
    RetryPredictionPayload payload =
        RetryPredictionPayload.fromPrediction(prediction);
    PredictDiseaseRetryEvent event = PredictDiseaseRetryEvent(payload: payload);
    return predictDiseaseBloc.add(event);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PredictDiseaseBloc, PredictDiseaseState>(
      listener: (context, state) {
        Prediction? retriedPrediction = state.retriedPrediction;
        if (retriedPrediction != null) {
          setRetriedPrediction(retriedPrediction);
        }
      },
      bloc: predictDiseaseBloc,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ListTile(
            title: Text(
              "Unpredicted disease",
              style: TextStyle(fontSize: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image(
              image: getImageProvider(prediction.image),
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: 200,
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: retryPrediction,
                child: const Text("Retry"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
