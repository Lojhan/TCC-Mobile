import 'package:flutter/material.dart';
import 'package:mobile/app/main/domain/entities/prediction.dart';

import '../misc/image_provider.dart';

class PredictionSuccess extends StatelessWidget {
  final Prediction prediction;

  const PredictionSuccess(this.prediction, {Key? key}) : super(key: key);

  String humanizeDate(DateTime date) {
    List<String> day = date.toString().split(' ')[0].split('-');
    return '${day[2]}/${day[1]}/${day[0]}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(prediction.diseaseName,
              style: const TextStyle(fontSize: 40)),
          subtitle: Text("predicted at ${humanizeDate(prediction.createdAt)}"),
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
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(2),
            children: const [
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Melanocytic nevi are benign neoplasms or hamartomas composed of melanocytes, the pigment-producing cells that constitutively colonize the epidermis. Melanocytes are derived from the neural crest and migrate during embryogenesis to selected ectodermal sites (primarily the skin and the CNS), but also to the eyes and the ears. Ectopic melanocytes have been identified at autopsy in the gastrointestinal and genitourinary tracts. Congenital melanocytic nevi are thought to represent an anomaly in embryogenesis and, as such, could be considered, at least in a sense, malformations or hamartomas. [2] In contrast, most acquired melanocytic nevi are considered benign neoplasms. Compare the images below. Melanocytic nevi occur in all mammalian species and are especially common in humans, dogs, and horses.',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Melanocytic nevi are benign neoplasms or hamartomas composed of melanocytes, the pigment-producing cells that constitutively colonize the epidermis. Melanocytes are derived from the neural crest and migrate during embryogenesis to selected ectodermal sites (primarily the skin and the CNS), but also to the eyes and the ears. Ectopic melanocytes have been identified at autopsy in the gastrointestinal and genitourinary tracts. Congenital melanocytic nevi are thought to represent an anomaly in embryogenesis and, as such, could be considered, at least in a sense, malformations or hamartomas. [2] In contrast, most acquired melanocytic nevi are considered benign neoplasms. Compare the images below. Melanocytic nevi occur in all mammalian species and are especially common in humans, dogs, and horses.',
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
