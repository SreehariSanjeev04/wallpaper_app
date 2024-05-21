// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: '[API_KEY]',
    appId: '1:367846291400:web:3ee6e22b3fd2c48b88f2fd',
    messagingSenderId: '367846291400',
    projectId: 'project-55e05',
    authDomain: 'project-55e05.firebaseapp.com',
    storageBucket: 'project-55e05.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: '[API_KEY]',
    appId: '1:367846291400:android:a008b9e481ddca4988f2fd',
    messagingSenderId: '367846291400',
    projectId: 'project-55e05',
    storageBucket: 'project-55e05.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '[API_KEY]',
    appId: '1:367846291400:ios:e7ca86c04261dbb688f2fd',
    messagingSenderId: '367846291400',
    projectId: 'project-55e05',
    storageBucket: 'project-55e05.appspot.com',
    iosBundleId: 'com.example.project',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '[API_KEY]',
    appId: '1:367846291400:ios:e7ca86c04261dbb688f2fd',
    messagingSenderId: '367846291400',
    projectId: 'project-55e05',
    storageBucket: 'project-55e05.appspot.com',
    iosBundleId: 'com.example.project',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: '[API_KEY]',
    appId: '1:367846291400:web:3ee6e22b3fd2c48b88f2fd',
    messagingSenderId: '367846291400',
    projectId: 'project-55e05',
    authDomain: 'project-55e05.firebaseapp.com',
    storageBucket: 'project-55e05.appspot.com',
  );

}
