import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/app/authentication/domain/entities/user.dart';
import 'package:mobile/app/authentication/domain/interfaces/repositories/auth_provider.dart';

class AppleAuthProvider extends AuthProvider {
  final FirebaseAuth firebaseAuth;

  AppleAuthProvider({required this.firebaseAuth});

  @override
  Future<UserModel> getAuth() {
    // TODO: implement getAuth
    throw UnimplementedError();
  }

  @override
  FutureOr<UserModel> signIn(params) async {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<UserModel> signUp([params]) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
