import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/domain/usecases/display_predictions.usecase.dart';
import 'package:mobile/app/domain/usecases/list_predictions.usecase.dart';
import 'package:mobile/app/domain/usecases/predict_disease.usecase.dart';
import 'package:mobile/app/external/datasources/prediction_remote_datasource.dart';
import 'package:mobile/app/infra/interfaces/datasources/i_predict_service.dart';
import 'package:mobile/app/infra/interfaces/i_predictions_repository.dart';
import 'package:mobile/app/infra/repositories/predictions_repository.dart';
import 'package:mobile/app/infra/services/predict_disease_service.dart';
import 'package:mobile/app/infra/services/predictions_service.dart';
import 'package:mobile/app/presentation/screens/home_page.dart';

import 'presentation/BloC/blocs.dart';

class AppModule extends Module {
  String predictionsBaseUrl = 'http://10.131.128.217:8080/predict';

  @override
  List<Bind> get binds => [
        Bind.factory((inject) => Dio()),
        // Bind.singleton((inject) => PredictionLocalDataSource()),
        Bind.singleton((inject) => PredictionRemoteDatasource(
              dioInstance: inject<Dio>(),
              baseUrl: predictionsBaseUrl,
            )),
        Bind.singleton((inject) => PredictionsRepository(
              remoteDatasource: inject<PredictionRemoteDatasource>(),
            )),
        Bind.singleton((inject) => PredictDiseaseService(
              dioInstance: inject<Dio>(),
              baseUrl: predictionsBaseUrl,
            )),
        Bind.singleton((inject) => PredictionsService(
              predictionsRepository: inject<IPredictionsRepository>(),
              predictService: inject<IPredictDiseaseService>(),
            )),
        Bind.singleton((inject) => PredictDisease(
              predictionsService: inject<PredictionsService>(),
            )),
        Bind.singleton((inject) => DisplayPrediction(
              predictionsService: inject<PredictionsService>(),
            )),
        Bind.singleton((inject) => ListPredictions(
              predictionsService: inject<PredictionsService>(),
            )),
        Bind.singleton((inject) => ListPredictionsBloc(
              usecase: inject<ListPredictions>(),
            )),
        Bind.singleton(
          (inject) => PredictDiseaseBloc(
            usecase: inject<PredictDisease>(),
            listPredictionsBloc: inject<ListPredictionsBloc>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
