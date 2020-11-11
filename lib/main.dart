import 'package:FreeFlix/screens/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  _firebaseMessaging.requestNotificationPermissions();
  _firebaseMessaging.configure(
    onLaunch: (message) {
      print("on launch");
    },
    onResume: (message) {
      print("on resume");
    },
    onMessage: (message) {
      print("on message");
    },
  );
  runApp(MaterialApp(
    home: App(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
    ),
  ));
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error !!"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Home();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
