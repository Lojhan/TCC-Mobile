import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobile/app/authentication/domain/entities/user.dart';
import 'package:mobile/app/authentication/infra/services/google_auth_service.dart';
import 'package:mobile/errors/errors.dart';

class GetAuthGoogleUseCase {
  GoogleAuthenticationService authService;

  GetAuthGoogleUseCase({required this.authService});

  FutureOr<Either<Failure, UserModel>> call() async {
    try {
      final user = await authService.getAuth();
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
