import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart';

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
          'DefaultFirebaseOptions have not been configured for Linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDyReQXCTErmUqjyG0RI0ryR-OysGF19ns',
    appId: '1:833991184752:web:a9f3c94dbefdc2a277bfb5',
    messagingSenderId: '833991184752',
    projectId: 'listato-66ad7',
    authDomain: 'listato-66ad7.firebaseapp.com',
    storageBucket: 'listato-66ad7.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB30cF3W44q1vV3cxfvx3aZvgWM7JYYDKI',
    appId: '1:833991184752:android:0bbb3c03883b47af77bfb5',
    messagingSenderId: '833991184752',
    projectId: 'listato-66ad7',
    storageBucket: 'listato-66ad7.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIsY8aPeYtHflVxeTYE1N5O7ngNEWaNJ0',
    appId: '1:833991184752:ios:ac33b429f1f7127177bfb5',
    messagingSenderId: '833991184752',
    projectId: 'listato-66ad7',
    storageBucket: 'listato-66ad7.appspot.com',
    iosBundleId: 'com.example.simpleTodo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIsY8aPeYtHflVxeTYE1N5O7ngNEWaNJ0',
    appId: '1:833991184752:ios:ac33b429f1f7127177bfb5',
    messagingSenderId: '833991184752',
    projectId: 'listato-66ad7',
    storageBucket: 'listato-66ad7.appspot.com',
    iosBundleId: 'com.example.simpleTodo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDyReQXCTErmUqjyG0RI0ryR-OysGF19ns',
    appId: '1:833991184752:web:c14e52cfe20289d577bfb5',
    messagingSenderId: '833991184752',
    projectId: 'listato-66ad7',
    authDomain: 'listato-66ad7.firebaseapp.com',
    storageBucket: 'listato-66ad7.appspot.com',
  );
}

