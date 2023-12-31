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
    apiKey: 'AIzaSyA5vQh43IhwkSJiBNTN77G2nEFmGCEDmvo',
    appId: '1:459602922073:web:bd7ce18aad4e833a087f48',
    messagingSenderId: '459602922073',
    projectId: 'fir-demo-534bb',
    authDomain: 'fir-demo-534bb.firebaseapp.com',
    storageBucket: 'fir-demo-534bb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSzN05N8e3lYgmQzIeJzB5TP70-Y1dEdQ',
    appId: '1:459602922073:android:33342d113f5c566b087f48',
    messagingSenderId: '459602922073',
    projectId: 'fir-demo-534bb',
    storageBucket: 'fir-demo-534bb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA42BPlBXTTIMPmOdLQVJn5QUvlUeDWuJE',
    appId: '1:459602922073:ios:861e388db7f13bfd087f48',
    messagingSenderId: '459602922073',
    projectId: 'fir-demo-534bb',
    storageBucket: 'fir-demo-534bb.appspot.com',
    iosClientId: '459602922073-9hsic99rc0mco3obusefe8gvaa71di6u.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseAToz',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA42BPlBXTTIMPmOdLQVJn5QUvlUeDWuJE',
    appId: '1:459602922073:ios:6667903ca4aeb8f5087f48',
    messagingSenderId: '459602922073',
    projectId: 'fir-demo-534bb',
    storageBucket: 'fir-demo-534bb.appspot.com',
    iosClientId: '459602922073-55mnaavoco9s1m7famr7r89ts52irsh5.apps.googleusercontent.com',
    iosBundleId: 'com.example.firebaseAToz.RunnerTests',
  );
}
