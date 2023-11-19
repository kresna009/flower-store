import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyAaerJMbFJBwvqHLK1YVsokuzg_BiDeEtE',
    appId: '1:884898477587:web:6bb6e8f00d1d772e5871e6',
    messagingSenderId: '884898477587',
    projectId: 'flowers-app-1f211',
    authDomain: 'flowers-app-1f211.firebaseapp.com',
    storageBucket: 'flowers-app-1f211.appspot.com',
    measurementId: 'G-Y9DWHMY4RN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCMnwUZHorkKW8UfI71UYE839smIAc7bs',
    appId: '1:884898477587:android:7653c6f1704aa1665871e6',
    messagingSenderId: '884898477587',
    projectId: 'flowers-app-1f211',
    storageBucket: 'flowers-app-1f211.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDazKRu1AX7EQ2oQLrE3-YAzpSUxKWznP0',
    appId: '1:884898477587:ios:e6bb68bd388d6df25871e6',
    messagingSenderId: '884898477587',
    projectId: 'flowers-app-1f211',
    storageBucket: 'flowers-app-1f211.appspot.com',
    iosBundleId: 'com.example.flowerStore',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDazKRu1AX7EQ2oQLrE3-YAzpSUxKWznP0',
    appId: '1:884898477587:ios:3c824c312580a5065871e6',
    messagingSenderId: '884898477587',
    projectId: 'flowers-app-1f211',
    storageBucket: 'flowers-app-1f211.appspot.com',
    iosBundleId: 'com.example.flowerStore.RunnerTests',
  );
}
