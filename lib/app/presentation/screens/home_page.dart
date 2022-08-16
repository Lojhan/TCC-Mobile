import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/domain/entities/prediction_payload.dart';
import 'package:mobile/app/presentation/BloC/predict_disease/predict_disease_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  Widget failure(BuildContext context) {
    return const Center(
      child: Text('Failed to predict'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PredictDiseaseBloc predictDiseaseBloc =
        context.watch<PredictDiseaseBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: StreamBuilder(
          stream: predictDiseaseBloc.stream,
          builder: (
            context,
            AsyncSnapshot<PredictDiseaseState> snapshot,
          ) {
            if (snapshot.data?.failure != null) {
              return failure(context);
            }

            return const Center(
              child: Text('Loading'),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          predictDiseaseBloc.add(PredictDiseaseEvent(
              payload: PredictionPayload(
                  payload: File.fromRawPath(Uint8List.fromList([2])))));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
