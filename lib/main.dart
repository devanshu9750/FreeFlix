import 'package:FreeFlix/screens/Home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      home: App(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          accentColor: Colors.white,
          tabBarTheme: TabBarTheme(
              indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: Colors.white))),
          brightness: Brightness.dark,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedIconTheme: IconThemeData(
                color: Colors.white,
              ),
              selectedItemColor: Colors.white,
              unselectedIconTheme: IconThemeData(color: Color(0xff616161))))));
}

class App extends StatelessWidget {
  Future<bool> initialize() async {
    await FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-1508391904647076~4705628668");
    await Firebase.initializeApp();
    bool beta =
        (await FirebaseFirestore.instance.collection("flags").doc("beta").get())
            .data()['value'];
    return beta;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: initialize(),
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
          if (!snapshot.data) {
            return Scaffold(
                body: Center(
              child: Text(
                "You need to get the latest apk !!\nEmail us at freeflixdev@gmail.com",
                style: TextStyle(color: Colors.white),
              ),
            ));
          }
          return Home();
        }

        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
