import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile/app/main/domain/usecases/list_predictions.usecase.dart';
import 'package:mobile/app/main/domain/usecases/predict_disease.usecase.dart';
import 'package:mobile/app/presentation/BloC/authentication/authentication_bloc.dart';
import 'package:mobile/app/presentation/BloC/blocs.dart';

import '../../authentication/domain/usecases/credentials/credentials_auth_usecases.dart';
import '../../authentication/domain/usecases/google/google_auth_usecases.dart';

export './main/predict_disease/predict_disease_bloc.dart';
export './main/list_predictions/list_predictions_bloc.dart';

List<Bind> _authBlocBinds = [
  Bind.singleton(
    (inject) => AuthenticationBloc(
      signInCredentialsUseCase: inject<SignInCredentialsUseCase>(),
      signOutCredentialsUseCase: inject<SignOutCredentialsUseCase>(),
      signUpCredentialsUseCase: inject<SignUpCredentialsUseCase>(),
      getAuthCredentialsUseCase: inject<GetAuthCredentialsUseCase>(),
      signInGoogleUseCase: inject<SignInGoogleUseCase>(),
      signOutGoogleUseCase: inject<SignOutGoogleUseCase>(),
      signUpGoogleUseCase: inject<SignUpGoogleUseCase>(),
      getAuthGoogleUseCase: inject<GetAuthGoogleUseCase>(),
    ),
  ),
];

List<Bind> _mainBlocBinds = [
  Bind.singleton((inject) => ListPredictionsBloc(
        usecase: inject<ListPredictions>(),
      )),
  Bind.singleton((inject) => PredictDiseaseBloc(
        usecase: inject<PredictDisease>(),
        listPredictionsBloc: inject<ListPredictionsBloc>(),
      )),
];

List<Bind> get blocBinds => [
      ..._authBlocBinds,
      ..._mainBlocBinds,
    ];
