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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAhy9fVcauIYHKRB5hdkZokq-XClUbQJPU',
    appId: '1:148173754814:web:cf63cb31510ab6e5c829ef',
    messagingSenderId: '148173754814',
    projectId: 'justbuy8-89f3b',
    authDomain: 'justbuy8-89f3b.firebaseapp.com',
    storageBucket: 'justbuy8-89f3b.appspot.com',
    measurementId: 'G-4XC8VRY97L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBbiKzPukzTDq7F7UCtphMb98eP2RBOG0',
    appId: '1:148173754814:android:f8075486c419bc0cc829ef',
    messagingSenderId: '148173754814',
    projectId: 'justbuy8-89f3b',
    storageBucket: 'justbuy8-89f3b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSE4YgEP3oU7fBGm75LC1MeqBhDKdXGf8',
    appId: '1:148173754814:ios:9173d18744ba463ec829ef',
    messagingSenderId: '148173754814',
    projectId: 'justbuy8-89f3b',
    storageBucket: 'justbuy8-89f3b.appspot.com',
    iosBundleId: 'com.sat.justbuyeight',
  );
}
