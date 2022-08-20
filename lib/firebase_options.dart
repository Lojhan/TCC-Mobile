// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC0DieF2xB2nMcXt9lZfY4qfwYFnrlzSBg',
    appId: '1:275195114381:web:9c9166fc6c63da9eedc3c4',
    messagingSenderId: '275195114381',
    projectId: 'skin-classification',
    authDomain: 'skin-classification.firebaseapp.com',
    storageBucket: 'skin-classification.appspot.com',
    measurementId: 'G-RH3L795CRE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBetEvnV31lmQl16W64DV7igpdUDZ6-YfE',
    appId: '1:275195114381:android:07c19e1367cf78b1edc3c4',
    messagingSenderId: '275195114381',
    projectId: 'skin-classification',
    storageBucket: 'skin-classification.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDJQxa3-c9jPVM6TyyBmASBDIbIHpSYUKw',
    appId: '1:275195114381:ios:de465f44ecb9443cedc3c4',
    messagingSenderId: '275195114381',
    projectId: 'skin-classification',
    storageBucket: 'skin-classification.appspot.com',
    iosClientId: '275195114381-6ef8o9eom4n27dr3b0135r3v1retr4ti.apps.googleusercontent.com',
    iosBundleId: 'com.tcc.mobile',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDJQxa3-c9jPVM6TyyBmASBDIbIHpSYUKw',
    appId: '1:275195114381:ios:de465f44ecb9443cedc3c4',
    messagingSenderId: '275195114381',
    projectId: 'skin-classification',
    storageBucket: 'skin-classification.appspot.com',
    iosClientId: '275195114381-6ef8o9eom4n27dr3b0135r3v1retr4ti.apps.googleusercontent.com',
    iosBundleId: 'com.tcc.mobile',
  );
}
