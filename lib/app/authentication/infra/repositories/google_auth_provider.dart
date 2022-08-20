import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobile/app/authentication/domain/entities/user.dart';
import 'dart:async';

import 'package:mobile/app/authentication/domain/interfaces/repositories/auth_provider.dart';

class GoogleAuthenticationProvider extends AuthProvider<void> {
  GoogleSignIn googleSignIn;
  FirebaseAuth firebaseAuth;

  GoogleAuthenticationProvider({
    required this.googleSignIn,
    required this.firebaseAuth,
  });

  @override
  FutureOr<UserModel> getAuth() {
    var user = firebaseAuth.currentUser;
    return getUser(user);
  }

  @override
  FutureOr<UserModel> signIn(params) async {
    UserCredential credential = await _googleSignIn();
    return getUser(credential.user);
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
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception('GoogleAuth is null');
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
  }
}
