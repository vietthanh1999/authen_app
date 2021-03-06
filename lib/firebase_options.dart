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
    apiKey: 'AIzaSyBgn5yD0ngX7ZqQ90hczmEW-h1ybr48CLo',
    appId: '1:855967719874:web:972ba4f4b356a72cbab65b',
    messagingSenderId: '855967719874',
    projectId: 'authenapp-5a3de',
    authDomain: 'authenapp-5a3de.firebaseapp.com',
    databaseURL: 'https://authenapp-5a3de-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'authenapp-5a3de.appspot.com',
    measurementId: 'G-YDW2EEVNBJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfoGaeHqWV36Yedr3QgN-dtN0VHyg08YY',
    appId: '1:855967719874:android:d3cf58999bd6fa3dbab65b',
    messagingSenderId: '855967719874',
    projectId: 'authenapp-5a3de',
    databaseURL: 'https://authenapp-5a3de-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'authenapp-5a3de.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCbCrZY2rJxBku56ATxq6Uy6y9dTZBCnJo',
    appId: '1:855967719874:ios:dea2f4225feb0f39bab65b',
    messagingSenderId: '855967719874',
    projectId: 'authenapp-5a3de',
    databaseURL: 'https://authenapp-5a3de-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'authenapp-5a3de.appspot.com',
    iosClientId: '855967719874-rgac7tqortoehk3ujsf7a29mu6puru0u.apps.googleusercontent.com',
    iosBundleId: 'com.example.authenApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCbCrZY2rJxBku56ATxq6Uy6y9dTZBCnJo',
    appId: '1:855967719874:ios:dea2f4225feb0f39bab65b',
    messagingSenderId: '855967719874',
    projectId: 'authenapp-5a3de',
    databaseURL: 'https://authenapp-5a3de-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'authenapp-5a3de.appspot.com',
    iosClientId: '855967719874-rgac7tqortoehk3ujsf7a29mu6puru0u.apps.googleusercontent.com',
    iosBundleId: 'com.example.authenApp',
  );
}
