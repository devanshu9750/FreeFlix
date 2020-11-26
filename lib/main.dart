import 'package:FreeFlix/screens/Home.dart';
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
              indicator: UnderlineTabIndicator(borderSide: BorderSide(
                color: Colors.white
              ))),
          brightness: Brightness.dark,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedIconTheme: IconThemeData(
                color: Colors.white,
              ),
              selectedItemColor: Colors.white,
              unselectedIconTheme: IconThemeData(color: Color(0xff616161))))));
}

class App extends StatelessWidget {
  Future<void> initialize() async {
    await FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-1508391904647076~4705628668");
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
          return Home();
        }

        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
