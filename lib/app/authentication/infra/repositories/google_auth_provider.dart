import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/app/authentication/domain/entities/user.dart';
import 'dart:async';

import 'package:mobile/app/authentication/domain/interfaces/repositories/auth_provider.dart';
import 'package:mobile/errors/authentication_errors.dart';

class GoogleAuthenticationProvider extends AuthProvider<void> {
  GoogleSignIn googleSignIn;
  FirebaseAuth firebaseAuth;

  GoogleAuthenticationProvider({
    required this.googleSignIn,
    required this.firebaseAuth,
  });

  @override
  FutureOr<UserModel?> getAuth() {
    var user = firebaseAuth.currentUser;

    return getUser(user);
  }

  @override
  FutureOr<UserModel> signIn(params) async {
    UserModel? user = await getAuth();
    if (user is UserModel) {
      return user;
    }
    UserCredential credential = await _googleSignIn();

    UserModel? userModel = await getUser(credential.user)!;

    if (userModel is UserModel) {
      return userModel;
    } else {
      throw Exception('User not found');
    }
  }

  @override
  FutureOr<void> signOut() async {
    await googleSignIn.disconnect();
    await firebaseAuth.signOut();
  }

  @override
  FutureOr<UserModel> signUp(params) async {
    return signIn(null);
  }

  FutureOr<UserCredential> _googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw GoogleAuthFailure();
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      return userCredential;
    } on Exception catch (e) {
      throw FirebaseAuthFailure();
    }
  }
}
