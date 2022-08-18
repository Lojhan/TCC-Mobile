import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/presentation/BloC/blocs.dart';
import 'package:mobile/app/presentation/components/misc/decide_from_state.dart';
import 'package:mobile/app/presentation/components/misc/failure.dart';
import 'package:mobile/app/presentation/components/misc/loading.dart';
import 'package:mobile/app/presentation/components/prediction/prediction_card.dart';

class ListPredictionsComponent extends StatelessWidget {
  final ListPredictionsBloc bloc = Modular.get<ListPredictionsBloc>();
  ListPredictionsComponent({Key? key}) : super(key: key);

  Widget failure(BuildContext context) => FailureComponent(onRetry: () {
        bloc.add(ListPredictionsEvent());
      });

  Widget initial(BuildContext context, ListPredictionsState state) => Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/neural.png',
            width: 200,
          ),
        ],
      ));

  Widget loading(BuildContext context, ListPredictionsState state) =>
      const LoadingComponent();

  Widget success(BuildContext context, ListPredictionsState state) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              isThreeLine: true,
              contentPadding: const EdgeInsets.all(12),
              dense: true,
              leading: Image.asset(
                'assets/images/neural.png',
                width: 200,
                height: 200,
              ),
              title: Text('Predictions: ${state.predictions.length}'),
              subtitle: Text(
                '''Awaiting retry: ${state.awaitingRetry.length}\nUnconfirmed: ${state.predictions.where((p) => p.predicted).length}''',
                maxLines: 2,
                style: const TextStyle(fontSize: 12, height: 1.5),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.predictions.length,
                itemBuilder: (context, index) => PredictionCard(
                  prediction: state.predictions[index],
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<ListPredictionsBloc, ListPredictionsState>(
      bloc: bloc,
      listener: (context, state) {},
      child: BlocBuilder<ListPredictionsBloc, ListPredictionsState>(
        bloc: bloc,
        builder: (context, state) {
          return decideFromState<ListPredictionsState>(
            state: state,
            context: context,
            initial: initial(context, state),
            loading: loading(context, state),
            success: success(context, state),
            failure: failure(context),
          );
        },
      ),
    );
  }
}
