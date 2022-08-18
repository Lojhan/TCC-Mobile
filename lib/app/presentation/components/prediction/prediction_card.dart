import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/app/domain/entities/prediction.dart';

class PredictionCard extends StatelessWidget {
  final Prediction prediction;
  const PredictionCard({
    Key? key,
    required this.prediction,
  }) : super(key: key);

  ImageProvider getImageProvider(String path) {
    File f = File(path);

    if (f.path.startsWith('http')) {
      return NetworkImage(f.path);
    }

    if (f.path.startsWith('assets')) {
      return AssetImage(f.path);
    }

    if (f.existsSync()) {
      return FileImage(f);
    }

    return const AssetImage('assets/images/no_image.jpeg');
  }

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
          child: Image(
            image: getImageProvider(
              prediction.image,
            ),
            fit: BoxFit.cover,
            width: 100,
          ),
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
