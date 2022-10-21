import 'package:flutter/material.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';
import 'package:mobile/app/presentation/components/bottom_sheet/show_prediction.dart';
import 'package:mobile/app/presentation/components/misc/image_provider.dart';

class PredictionCard extends StatelessWidget {
  final Prediction prediction;
  const PredictionCard({
    Key? key,
    required this.prediction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(fontSize: 20);
    const subtitleStyle = TextStyle(fontSize: 16);

    return Card(
      child: ListTile(
        onTap: () => showPrediction(context, prediction),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
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
