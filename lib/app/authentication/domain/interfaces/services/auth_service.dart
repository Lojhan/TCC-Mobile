import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:mobile/app/authentication/domain/entities/user.dart';
import 'package:mobile/errors/errors.dart';

abstract class AuthService<T> {
  FutureOr<Either<Failure, UserModel>> signIn(T? params);
  FutureOr<Either<Failure, UserModel>> signUp(T? params);
  FutureOr<Either<Failure, void>> signOut();
  FutureOr<Either<Failure, UserModel>> getAuth();
}
