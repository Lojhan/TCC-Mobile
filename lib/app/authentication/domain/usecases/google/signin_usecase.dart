import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobile/app/authentication/domain/entities/user.dart';
import 'package:mobile/app/authentication/domain/usecases/abstract.dart';
import 'package:mobile/app/authentication/infra/services/google_auth_service.dart';
import 'package:mobile/errors/errors.dart';

class SignInGoogleUseCase extends ISignInUseCase {
  GoogleAuthenticationService authService;

  SignInGoogleUseCase({required this.authService});

  FutureOr<Either<Failure, UserModel>> call() async {
    try {
      final user = await authService.signIn();
      return user.fold(
        (l) => Left(l),
        (r) => Right(r),
      );
    } on Failure {
      return Left(Failure());
    } catch (e) {
      return Left(Failure());
    }
  }
}
