import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/app/authentication/domain/entities/user.dart';
import 'package:mobile/app/authentication/domain/models/providers_enum.dart';
import 'package:mobile/app/authentication/domain/usecases/google/google_auth_usecases.dart';
import 'package:mobile/app/presentation/BloC/authentication/authentication_bloc.dart';
import 'package:mobile/errors/errors.dart';
import 'package:mobile/app/presentation/BloC/main/predict_disease/predict_disease_bloc.dart';
import 'package:mobile/app/presentation/components/alert_dialog/prediction_failure.dart';
import 'package:mobile/app/presentation/components/bottom_sheet/no_cameras_available.dart';
import 'package:mobile/app/presentation/components/bottom_sheet/show_prediction.dart';
import 'package:mobile/app/presentation/components/callback/call_prediction.dart';
import 'package:mobile/app/presentation/components/listing/list_predictions.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  FutureOr<void> prediction(
      BuildContext context, PredictDiseaseBloc bloc) async {
    try {
      await initPrediting(context, bloc, ImageSource.camera);
    } on NoCamerasAvailableException {
      showNoCamerasToast(context);
    } on CameraPremissionException {
      // TODO: show permission dialog
    } on Exception catch (_) {
      // TODO: show error dialog
    }
  }

  FutureOr<UserModel?> getUserOrLogin(
    GetAuthGoogleUseCase getAuth,
    SignInGoogleUseCase signIn,
  ) async {
    UserModel? user;
    final res = await signIn();
    final usermaybe = res.fold((l) => l, (r) => r);

    if (usermaybe is UserModel) {
      user = usermaybe;
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    final PredictDiseaseBloc predictDiseaseBloc = Modular.get();
    final AuthenticationBloc authenticationBloc = Modular.get();

    const event =
        AuthenticationSignInEvent(provider: AuthenticationProvider.google);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Skin Cancer Predictor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => authenticationBloc.add(event),
          ),
        ],
      ),
      body: BlocListener<PredictDiseaseBloc, PredictDiseaseState>(
        bloc: predictDiseaseBloc,
        listener: (context, state) {
          if (state.failure != null) {
            showPredictionFailureDialog(context, state.failure!);
          } else if (state.prediction != null) {
            showPrediction(context, state.prediction!);
          }
        },
        child: ListPredictionsComponent(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'defaultIcon',
        onPressed: () async => await prediction(context, predictDiseaseBloc),
        icon: const Icon(Icons.camera_alt),
        label: const Text('Predict'),
      ),
    );
  }
}
