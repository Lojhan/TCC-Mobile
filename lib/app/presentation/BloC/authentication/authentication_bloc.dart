import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mobile/app/authentication/domain/entities/user.dart';
import 'package:mobile/app/authentication/domain/models/credentials_payload.dart';
import 'package:mobile/app/authentication/domain/models/methods_enum.dart';
import 'package:mobile/app/authentication/domain/models/providers_enum.dart';
import 'package:mobile/app/authentication/domain/usecases/credentials/credentials_auth_usecases.dart';
import 'package:mobile/app/authentication/domain/usecases/google/google_auth_usecases.dart';
import 'package:mobile/app/presentation/BloC/authentication/add_token_interceptor.dart';
import 'package:mobile/app/presentation/BloC/authentication/retry_on_unauthorized_interceptor.dart';
import 'package:mobile/errors/errors.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  final SignInCredentialsUseCase signInCredentialsUseCase;
  final SignInGoogleUseCase signInGoogleUseCase;

  final SignUpCredentialsUseCase signUpCredentialsUseCase;
  final SignUpGoogleUseCase signUpGoogleUseCase;

  final SignOutCredentialsUseCase signOutCredentialsUseCase;
  final SignOutGoogleUseCase signOutGoogleUseCase;

  final GetAuthCredentialsUseCase getAuthCredentialsUseCase;
  final GetAuthGoogleUseCase getAuthGoogleUseCase;

  final Dio dioInstance;

  AuthenticationBloc({
    required this.signInCredentialsUseCase,
    required this.signInGoogleUseCase,
    required this.signUpCredentialsUseCase,
    required this.signUpGoogleUseCase,
    required this.signOutCredentialsUseCase,
    required this.signOutGoogleUseCase,
    required this.getAuthCredentialsUseCase,
    required this.getAuthGoogleUseCase,
    required this.dioInstance,
  }) : super(AuthenticationState.initial()) {
    on<AuthenticationSignInEvent>(_signIn);
    on<AuthenticationSignOutEvent>(_signOut);
    on<AuthenticationSignUpEvent>(_signUp);
    on<AuthenticationGetAuthEvent>(_getAuth);
    on<AddRequestInterceptorsEvent>(_addRequestInterceptors);
    on<AuthenticationRenewEvent>(_renewToken);
  }

  _success(
    AuthenticationProvider provider,
    UserModel user,
    Emitter<AuthenticationState> emit,
  ) {
    add(AddRequestInterceptorsEvent(provider: provider, token: user.token));
    emit(AuthenticationState.login(user, provider));
  }

  Future<void> _signIn(
    AuthenticationSignInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final provider = event.provider;
    final usecases = _getAuthUseCase(provider);

    CredentialsPayload? payload = event.credentialspPayload;

    Function signIn = usecases![AuthenticationMethods.signIn]!;

    Either<Failure, UserModel> result;

    if (payload is CredentialsPayload) {
      result = await signIn(payload);
    } else {
      result = await signIn();
    }

    return result.fold(
      (l) => emit(AuthenticationState.failure(l)),
      (r) => _success(provider, r, emit),
    );
  }

  Future<void> _signOut(
    AuthenticationSignOutEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final provider = event.provider;
    final usecases = _getAuthUseCase(provider);
    final signOut = usecases![AuthenticationMethods.signOut]!;
    final result = await signOut();
    return result.fold(
      (l) => emit(AuthenticationState.failure(l)),
      (r) => emit(AuthenticationState.initial()),
    );
  }

  FutureOr<void> _signUp(
    AuthenticationSignUpEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final provider = event.provider;
    final usecases = _getAuthUseCase(provider);
    CredentialsPayload? payload = event.credentialspPayload;

    final signUp = usecases![AuthenticationMethods.signUp]!;

    Either<Failure, UserModel> result;

    if (payload is CredentialsPayload) {
      result = await signUp(payload);
    } else {
      result = await signUp();
    }

    return result.fold(
      (l) => emit(AuthenticationState.failure(l)),
      (r) => _success(provider, r, emit),
    );
  }

  FutureOr<void> _getAuth(
    AuthenticationGetAuthEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    final provider = event.provider;
    final usecases = _getAuthUseCase(provider);
    final getAuth = usecases![AuthenticationMethods.getAuth]!;
    final result = await getAuth();
    return result.fold(
      (l) => emit(AuthenticationState.failure(l)),
      (r) => _success(provider, r, emit),
    );
  }

  Map<AuthenticationMethods, Function>? _getAuthUseCase(
    AuthenticationProvider provider,
  ) {
    return {
      AuthenticationProvider.credentials: {
        AuthenticationMethods.signIn: signInCredentialsUseCase.call,
        AuthenticationMethods.signUp: signUpCredentialsUseCase.call,
        AuthenticationMethods.signOut: signOutCredentialsUseCase.call,
        AuthenticationMethods.getAuth: getAuthCredentialsUseCase.call,
      },
      AuthenticationProvider.google: {
        AuthenticationMethods.signIn: signInGoogleUseCase.call,
        AuthenticationMethods.signUp: signUpGoogleUseCase.call,
        AuthenticationMethods.signOut: signOutGoogleUseCase.call,
        AuthenticationMethods.getAuth: getAuthGoogleUseCase.call,
      },
    }[provider];
  }

  FutureOr<void> _addRequestInterceptors(
    AddRequestInterceptorsEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    AuthenticationProvider provider = event.provider;
    final usecases = _getAuthUseCase(provider);
    final getAuth = usecases![AuthenticationMethods.getAuth]!;

    InterceptorsWrapper interceptor = InterceptorsWrapper(
      onRequest: addToken(event.token),
      onError: await retryOnUnautorized(
        dioInstance,
        event.provider,
        getAuth,
        add.call,
      ),
    );
    dioInstance.interceptors.add(interceptor);
  }

  FutureOr<void> _renewToken(
    AuthenticationRenewEvent event,
    Emitter<AuthenticationState> _,
  ) async {
    AuthenticationProvider provider = event.state.provider!;
    final usecases = _getAuthUseCase(provider);
    final getAuth = usecases![AuthenticationMethods.getAuth]!;
    InterceptorsWrapper interceptor = InterceptorsWrapper(
      onRequest: addToken(state.user!.token),
      onError: await retryOnUnautorized(
        dioInstance,
        provider,
        getAuth,
        add.call,
      ),
    );

    dioInstance.interceptors.first = interceptor;
    dioInstance.interceptors.add(interceptor);
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    return AuthenticationState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return {
      'state': state.toJson(),
    };
  }
}
