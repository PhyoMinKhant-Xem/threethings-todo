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
    apiKey: 'AIzaSyA2dOGYa4bud8BFsdgRZXi-6fEeHUyWRsY',
    appId: '1:984158775162:web:4ab0898e889ab478f518c3',
    messagingSenderId: '984158775162',
    projectId: 'three-things-todo',
    authDomain: 'three-things-todo.firebaseapp.com',
    storageBucket: 'three-things-todo.firebasestorage.app',
    measurementId: 'G-RF03EHP6EW',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCOSO7vQGRMmw6KSpzSEsXUFBi0RJEZKZU',
    appId: '1:984158775162:android:beaea7b8a21a24aaf518c3',
    messagingSenderId: '984158775162',
    projectId: 'three-things-todo',
    storageBucket: 'three-things-todo.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBHNRJ1baLVLmjNd4o5ZvKbYzslwNhJtSQ',
    appId: '1:984158775162:ios:53ef69a083816208f518c3',
    messagingSenderId: '984158775162',
    projectId: 'three-things-todo',
    storageBucket: 'three-things-todo.firebasestorage.app',
    iosBundleId: 'com.example.threethings',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBHNRJ1baLVLmjNd4o5ZvKbYzslwNhJtSQ',
    appId: '1:984158775162:ios:53ef69a083816208f518c3',
    messagingSenderId: '984158775162',
    projectId: 'three-things-todo',
    storageBucket: 'three-things-todo.firebasestorage.app',
    iosBundleId: 'com.example.threethings',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA2dOGYa4bud8BFsdgRZXi-6fEeHUyWRsY',
    appId: '1:984158775162:web:f7a29108c05ddd81f518c3',
    messagingSenderId: '984158775162',
    projectId: 'three-things-todo',
    authDomain: 'three-things-todo.firebaseapp.com',
    storageBucket: 'three-things-todo.firebasestorage.app',
    measurementId: 'G-P7XB32TBYE',
  );

}