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
    apiKey: 'AIzaSyCevYqcDyalWLwKzrrc3BF3wI78AnUNcSE',
    appId: '1:536359759001:web:2280d5864f7900395a9c08',
    messagingSenderId: '536359759001',
    projectId: 'fir-5e4de',
    authDomain: 'fir-5e4de.firebaseapp.com',
    storageBucket: 'fir-5e4de.firebasestorage.app',
    measurementId: 'G-RWKWXCBH9M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC6EhWdXXZmIJtZ3b3IKEsgouN66mOF9Gc',
    appId: '1:536359759001:android:d2d60862e94545bc5a9c08',
    messagingSenderId: '536359759001',
    projectId: 'fir-5e4de',
    storageBucket: 'fir-5e4de.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyByCg63fdx2sw-eMWY0QDJ0_wQS7ngf5Y0',
    appId: '1:536359759001:ios:4711ae1323c9f62f5a9c08',
    messagingSenderId: '536359759001',
    projectId: 'fir-5e4de',
    storageBucket: 'fir-5e4de.firebasestorage.app',
    iosClientId: '536359759001-1thlujgqmath66a2qkvi1d1ggasuobm4.apps.googleusercontent.com',
    iosBundleId: 'com.example.notesappwithfirebase',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyByCg63fdx2sw-eMWY0QDJ0_wQS7ngf5Y0',
    appId: '1:536359759001:ios:4711ae1323c9f62f5a9c08',
    messagingSenderId: '536359759001',
    projectId: 'fir-5e4de',
    storageBucket: 'fir-5e4de.firebasestorage.app',
    iosClientId: '536359759001-1thlujgqmath66a2qkvi1d1ggasuobm4.apps.googleusercontent.com',
    iosBundleId: 'com.example.notesappwithfirebase',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCevYqcDyalWLwKzrrc3BF3wI78AnUNcSE',
    appId: '1:536359759001:web:488379ea001da9e05a9c08',
    messagingSenderId: '536359759001',
    projectId: 'fir-5e4de',
    authDomain: 'fir-5e4de.firebaseapp.com',
    storageBucket: 'fir-5e4de.firebasestorage.app',
    measurementId: 'G-N07KR9J579',
  );

}