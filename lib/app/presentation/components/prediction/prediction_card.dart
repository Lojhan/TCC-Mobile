import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile/app/domain/entities/prediction.dart';

class PredictionCard extends StatelessWidget {
  final Prediction prediction;
  const PredictionCard({
    Key? key,
    required this.prediction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 18,
        ),
        trailing: SizedBox(
          height: 300,
          child: prediction.image,
        ),
        title: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(prediction.diseaseName),
              Text(prediction.dx),
            ],
          ),
        ),
      ),
    );
  }
}
