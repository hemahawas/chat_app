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
    apiKey: 'AIzaSyBbFC4qE9LTXirzITrHVedUTbQTNAFgf08',
    appId: '1:947610105866:web:6439ba500394e175cf47f3',
    messagingSenderId: '947610105866',
    projectId: 'chat-app-e5cb1',
    authDomain: 'chat-app-e5cb1.firebaseapp.com',
    storageBucket: 'chat-app-e5cb1.firebasestorage.app',
    measurementId: 'G-K3PC98MY9P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDKwRJ8fhcWON-Unfnfzoi91ytJ3-2ed0s',
    appId: '1:947610105866:android:4aaee9abc50bebb2cf47f3',
    messagingSenderId: '947610105866',
    projectId: 'chat-app-e5cb1',
    storageBucket: 'chat-app-e5cb1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCI8B9JtMO86Zrd1-Qz1zSCSRZv-UNFXis',
    appId: '1:947610105866:ios:e9134ccaacff57f2cf47f3',
    messagingSenderId: '947610105866',
    projectId: 'chat-app-e5cb1',
    storageBucket: 'chat-app-e5cb1.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCI8B9JtMO86Zrd1-Qz1zSCSRZv-UNFXis',
    appId: '1:947610105866:ios:e9134ccaacff57f2cf47f3',
    messagingSenderId: '947610105866',
    projectId: 'chat-app-e5cb1',
    storageBucket: 'chat-app-e5cb1.firebasestorage.app',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBbFC4qE9LTXirzITrHVedUTbQTNAFgf08',
    appId: '1:947610105866:web:3b780d07a71b8100cf47f3',
    messagingSenderId: '947610105866',
    projectId: 'chat-app-e5cb1',
    authDomain: 'chat-app-e5cb1.firebaseapp.com',
    storageBucket: 'chat-app-e5cb1.firebasestorage.app',
    measurementId: 'G-9MZEPL6YRV',
  );
}
