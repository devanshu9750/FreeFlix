import 'package:FreeFlix/screens/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: App(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(brightness: Brightness.dark),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                "Something went wrong !!",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return Home();
        }

        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
