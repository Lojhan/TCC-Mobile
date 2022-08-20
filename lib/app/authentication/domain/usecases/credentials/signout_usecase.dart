import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobile/app/authentication/domain/models/credentials_payload.dart';
import 'package:mobile/app/authentication/domain/usecases/abstract.dart';
import 'package:mobile/app/authentication/infra/services/credentials_auth_service.dart';
import 'package:mobile/errors/errors.dart';

class SignOutCredentialsUseCase extends ISignOutUseCase {
  CredentialsAuthenticationService authService;

  SignOutCredentialsUseCase({required this.authService});

  FutureOr<Either<Failure, void>> call(CredentialsPayload payload) async {
    try {
      final user = await authService.signOut();
      return user.fold(
        (l) => Left(l),
        (r) => const Right(null),
      );
    } on Failure {
      return Left(Failure());
    } catch (e) {
      return Left(Failure());
    }
  }
}
