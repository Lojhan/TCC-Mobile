import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/main/domain/usecases/display_predictions.usecase.dart';
import 'package:mobile/app/main/domain/usecases/list_predictions.usecase.dart';
import 'package:mobile/app/main/domain/usecases/predict_disease.usecase.dart';
import 'package:mobile/app/main/external/datasources/prediction_remote_datasource.dart';
import 'package:mobile/app/main/infra/interfaces/datasources/i_predict_service.dart';
import 'package:mobile/app/main/infra/interfaces/i_predictions_repository.dart';
import 'package:mobile/app/main/infra/repositories/predictions_repository.dart';
import 'package:mobile/app/main/infra/services/predict_disease_service.dart';
import 'package:mobile/app/main/infra/services/predictions_service.dart';
import 'package:mobile/app/presentation/BloC/main/list_predictions/list_predictions_bloc.dart';
import 'package:mobile/app/presentation/BloC/main/predict_disease/predict_disease_bloc.dart';
import 'package:mobile/app/presentation/screens/home_page.dart';

class MainModule extends Module {
  String predictionsBaseUrl = 'http://192.168.15.10:3000/predictions';

  MainModule() {
    print(predictionsBaseUrl);
  }

  @override
  List<Bind> get binds => [
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
        Bind.singleton((inject) => PredictDiseaseBloc(
              usecase: inject<PredictDisease>(),
              listPredictionsBloc: inject<ListPredictionsBloc>(),
            )),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
