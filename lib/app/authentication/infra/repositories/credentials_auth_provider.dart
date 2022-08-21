import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/app/authentication/domain/entities/user.dart';
import 'package:mobile/app/authentication/domain/models/credentials_payload.dart';
import 'package:mobile/app/authentication/domain/interfaces/repositories/auth_provider.dart';

class CredentialsAuthProvider extends AuthProvider<CredentialsPayload> {
  final FirebaseAuth firebaseAuth;

  CredentialsAuthProvider({required this.firebaseAuth}) : super();

  @override
  FutureOr<UserModel?> getAuth() {
    var user = firebaseAuth.currentUser;
    return getUser(user);
  }

  @override
  FutureOr<UserModel> signIn(CredentialsPayload? params) async {
    validateNullParams(params);

    UserModel? user = await getAuth();
    if (user is UserModel) {
      return user;
    }

    final response = await firebaseAuth.signInWithEmailAndPassword(
      email: params!.email,
      password: params.password,
    );

    UserModel? userModel = await getUser(response.user)!;

    if (userModel is UserModel) {
      return userModel;
    } else {
      throw Exception('User not found');
    }
  }

  @override
  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  @override
  Future<UserModel> signUp(CredentialsPayload? params) async {
    validateNullParams(params);

    final response = await firebaseAuth.createUserWithEmailAndPassword(
      email: params!.email,
      password: params.password,
    );
    UserModel? userModel = await getUser(response.user)!;

    if (userModel is UserModel) {
      return userModel;
    } else {
      throw Exception('User not found');
    }
  }
}
