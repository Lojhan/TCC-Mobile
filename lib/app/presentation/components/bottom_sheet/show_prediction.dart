import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile/app/domain/entities/prediction.dart';

FutureOr showPrediction(
  BuildContext context,
  Prediction prediction,
) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            ListTile(
              title: Text(prediction.diseaseName,
                  style: const TextStyle(fontSize: 40)),
              subtitle: Text(prediction.dx.toString()),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  'Melanocytic nevi are benign neoplasms or hamartomas composed of melanocytes, the pigment-producing cells that constitutively colonize the epidermis. Melanocytes are derived from the neural crest and migrate during embryogenesis to selected ectodermal sites (primarily the skin and the CNS), but also to the eyes and the ears. Ectopic melanocytes have been identified at autopsy in the gastrointestinal and genitourinary tracts. Congenital melanocytic nevi are thought to represent an anomaly in embryogenesis and, as such, could be considered, at least in a sense, malformations or hamartomas. [2] In contrast, most acquired melanocytic nevi are considered benign neoplasms. Compare the images below. Melanocytic nevi occur in all mammalian species and are especially common in humans, dogs, and horses.'),
            )
          ],
        ),
      );
    },
  );
}
