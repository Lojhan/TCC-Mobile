import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/domain/usecases/display_predictions.usecase.dart';
import 'package:mobile/app/domain/usecases/list_predictions.usecase.dart';
import 'package:mobile/app/domain/usecases/predict_disease.usecase.dart';
import 'package:mobile/app/external/datasources/prediction_local_datasource.dart';
import 'package:mobile/app/external/datasources/prediction_remote_datasource.dart';
import 'package:mobile/app/infra/interfaces/datasources/I_predict_service.dart';
import 'package:mobile/app/infra/interfaces/i_predictions_repository.dart';
import 'package:mobile/app/infra/repositories/predictions_repository.dart';
import 'package:mobile/app/infra/services/predict_disease_service.dart';
import 'package:mobile/app/infra/services/predictions_service.dart';
import 'package:mobile/app/presentation/screens/home_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => Dio()),
        Bind.singleton((i) => PredictionLocalDataSource()),
        Bind.singleton((i) => PredictionRemoteDatasource(
              dioInstance: i<Dio>(),
              baseUrl: 'localhost:8080/predictions',
            )),
        Bind.singleton((i) => PredictionsRepository(
              localDatasource: i<PredictionLocalDataSource>(),
              remoteDatasource: i<PredictionRemoteDatasource>(),
            )),
        Bind.singleton((i) => PredictDiseaseService(
              dioInstance: i<Dio>(),
              baseUrl: 'localhost:8080/predictions',
            )),
        Bind.singleton((i) => PredictionsService(
              predictionsRepository: i<IPredictionsRepository>(),
              predictService: i<IPredictDiseaseService>(),
            )),
        Bind.factory((i) => PredictDisease(
              predictionsService: i<PredictionsService>(),
            )),
        Bind.factory((i) => DisplayPrediction(
              predictionsService: i<PredictionsService>(),
            )),
        Bind.factory((i) => ListPredictions(
              predictionsService: i<PredictionsService>(),
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
