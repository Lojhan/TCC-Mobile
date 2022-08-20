import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile/app/authentication/domain/entities/user.dart';

abstract class AuthProvider<T> {
  FutureOr<UserModel> signIn(T? params);
  FutureOr<UserModel> signUp(T? params);
  FutureOr<void> signOut();
  FutureOr<UserModel> getAuth();

  UserModel getUser(User? user) {
    if (user == null) {
      throw Exception();
    }
    return UserModel(
      id: user.uid,
      name: user.displayName ?? 'Mighty Hyena',
      email: user.email ?? 'mighty_hyena@app.com',
      photoUrl: user.photoURL ??
          // TODO: change to a default asset image
          'https://images.theconversation.com/files/260231/original/file-20190221-195864-2t43e7.jpg',
    );
  }

  validateNullParams(T? params) {
    if (params == null) {
      throw Exception('Params is null');
    }
  }
}
