import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobile/app/authentication/domain/entities/user.dart';
import 'package:mobile/app/authentication/domain/models/credentials_payload.dart';
import 'package:mobile/app/authentication/infra/repositories/credentials_auth_provider.dart';
import 'package:mobile/errors/errors.dart';

class CredentialsAuthenticationService {
  CredentialsAuthProvider authProvider;

  CredentialsAuthenticationService({
    required this.authProvider,
  });

  FutureOr<Either<Failure, UserModel>> getAuth() async {
    try {
      final user = await authProvider.getAuth();

      if (user is UserModel) {
        return Right(user);
      } else {
        return Left(Failure());
      }
    } on Exception {
      return Left(Failure());
    }
  }

  FutureOr<Either<Failure, UserModel>> signIn(
      CredentialsPayload payload) async {
    try {
      final user = await authProvider.signIn(payload);
      return Right(user);
    } on Exception {
      return Left(Failure());
    }
  }

  FutureOr<Either<Failure, void>> signOut() async {
    try {
      await authProvider.signOut();
      return const Right(null);
    } on Exception {
      return Left(Failure());
    }
  }

  FutureOr<Either<Failure, UserModel>> signUp(
      CredentialsPayload payload) async {
    try {
      final user = await authProvider.signUp(payload);
      return Right(user);
    } on Exception {
      return Left(Failure());
    }
  }
}
