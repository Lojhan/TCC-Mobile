import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/app/authentication/domain/usecases/credentials/credentials_auth_usecases.dart';
import 'package:mobile/app/authentication/domain/usecases/google/get_auth_usecase.dart';
import 'package:mobile/app/authentication/domain/usecases/google/signin_usecase.dart';
import 'package:mobile/app/authentication/domain/usecases/google/signout_usecase.dart';
import 'package:mobile/app/authentication/domain/usecases/google/signup_usecase.dart';
import 'package:mobile/app/authentication/infra/repositories/credentials_auth_provider.dart';
import 'package:mobile/app/authentication/infra/repositories/google_auth_provider.dart';
import 'package:mobile/app/authentication/infra/services/credentials_auth_service.dart';
import 'package:mobile/app/authentication/infra/services/google_auth_service.dart';
import 'package:mobile/app/presentation/BloC/authentication/authentication_bloc.dart';

class AuthenticationModule {
  static List<Bind> get _credentialsBinds => [
        Bind.singleton((inject) => SignInCredentialsUseCase(
              authService: inject<CredentialsAuthenticationService>(),
            )),
        Bind.singleton((inject) => SignUpCredentialsUseCase(
              authService: inject<CredentialsAuthenticationService>(),
            )),
        Bind.singleton((inject) => GetAuthCredentialsUseCase(
              authService: inject<CredentialsAuthenticationService>(),
            )),
        Bind.singleton((inject) => SignOutCredentialsUseCase(
              authService: inject<CredentialsAuthenticationService>(),
            )),
      ];

  static List<Bind> get _googleBinds => [
        Bind.singleton((inject) => SignInGoogleUseCase(
              authService: inject<GoogleAuthenticationService>(),
            )),
        Bind.singleton((inject) => SignUpGoogleUseCase(
              authService: inject<GoogleAuthenticationService>(),
            )),
        Bind.singleton((inject) => GetAuthGoogleUseCase(
              authService: inject<GoogleAuthenticationService>(),
            )),
        Bind.singleton((inject) => SignOutGoogleUseCase(
              authService: inject<GoogleAuthenticationService>(),
            )),
      ];

  static List<Bind> get binds => [
        Bind.singleton((_) => FirebaseAuth.instance),
        Bind.singleton((_) => GoogleSignIn(scopes: [
              'email',
              'profile',
            ], signInOption: SignInOption.standard)),
        Bind.singleton((inject) => GoogleAuthenticationProvider(
              googleSignIn: inject<GoogleSignIn>(),
              firebaseAuth: inject<FirebaseAuth>(),
            )),
        Bind.singleton((inject) => CredentialsAuthProvider(
              firebaseAuth: inject<FirebaseAuth>(),
            )),
        Bind.singleton((inject) => GoogleAuthenticationService(
              authProvider: inject<GoogleAuthenticationProvider>(),
            )),
        Bind.singleton((inject) => CredentialsAuthenticationService(
              authProvider: inject<CredentialsAuthProvider>(),
            )),
        ..._credentialsBinds,
        ..._googleBinds,
        Bind.singleton((inject) => AuthenticationBloc(
              signInCredentialsUseCase: inject<SignInCredentialsUseCase>(),
              signOutCredentialsUseCase: inject<SignOutCredentialsUseCase>(),
              signUpCredentialsUseCase: inject<SignUpCredentialsUseCase>(),
              getAuthCredentialsUseCase: inject<GetAuthCredentialsUseCase>(),
              signInGoogleUseCase: inject<SignInGoogleUseCase>(),
              signOutGoogleUseCase: inject<SignOutGoogleUseCase>(),
              signUpGoogleUseCase: inject<SignUpGoogleUseCase>(),
              getAuthGoogleUseCase: inject<GetAuthGoogleUseCase>(),
            )),
      ];
}
