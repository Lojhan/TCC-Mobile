import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobile/app/authentication/domain/entities/user.dart';
import 'package:mobile/app/authentication/domain/models/credentials_payload.dart';
import 'package:mobile/app/authentication/infra/services/credentials_auth_service.dart';
import 'package:mobile/errors/errors.dart';

class GetAuthCredentialsUseCase {
  CredentialsAuthenticationService authService;

  GetAuthCredentialsUseCase({required this.authService});

  FutureOr<Either<Failure, UserModel>> call(CredentialsPayload payload) async {
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
