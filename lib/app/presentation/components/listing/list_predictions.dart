import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/presentation/BloC/list_predictions/list_predictions_bloc.dart';
import 'package:mobile/app/presentation/components/misc/loading.dart';

class ListPredictionsComponent extends StatelessWidget {
  ListPredictionsComponent({Key? key}) : super(key: key);

  final ListPredictionsBloc bloc = Modular.get<ListPredictionsBloc>();

  Widget failure(BuildContext context) {
    return const Center(
      child: Text('Failed to load predictions'),
    );
  }

  Widget initial(BuildContext context) {
    return const Center(
      child: Text('Predict disease 2'),
    );
  }

  bool shouldRenderImage(String? image) {
    if (image == null) {
      return false;
    }

    if (image.isEmpty) {
      return false;
    }

    return true;
  }

  Widget getImageBase64(String? imageBase64) {
    const Base64Codec base64 = Base64Codec();
    if (imageBase64 == null) return Container();
    final bytes = base64.decode(imageBase64);
    return Image.memory(
      bytes.isNotEmpty ? bytes : Uint8List.fromList([]),
      fit: BoxFit.cover,
      width: 120,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListPredictionsBloc, ListPredictionsState>(
      bloc: bloc,
      listener: (context, state) {},
      child: BlocBuilder<ListPredictionsBloc, ListPredictionsState>(
        bloc: bloc,
        builder: (context, state) {
          if (state.isLoading) {
            return const Loading();
          } else if (state.failure != null) {
            return failure(context);
          } else if (state.predictions.isEmpty) {
            return initial(context);
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: state.predictions.length,
            itemBuilder: (context, index) {
              final prediction = state.predictions[index];
              return Card(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 18,
                  ),
                  trailing: SizedBox(
                    height: 300,
                    child: getImageBase64(prediction.image),
                  ),
                  title: SizedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(prediction.diseaseName),
                          Text(prediction.dx),
                        ]),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
