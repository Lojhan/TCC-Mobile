import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobile/app/authentication/infra/services/google_auth_service.dart';
import 'package:mobile/errors/errors.dart';

class SignOutGoogleUseCase {
  GoogleAuthenticationService authService;

  SignOutGoogleUseCase({required this.authService});

  FutureOr<Either<Failure, void>> call() async {
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
