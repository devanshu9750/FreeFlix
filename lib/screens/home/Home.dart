import 'package:FreeFlix/backend/AnimeSearchDelegate.dart';
import 'package:FreeFlix/components/BodyComponents.dart';
import 'package:FreeFlix/components/DrawerComponent.dart';
import 'package:FreeFlix/components/TabBarComponents.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: (_currentIndex == 0)
          ? 2
          : (_currentIndex == 1)
              ? 0
              : 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("FreeFlix"),
          centerTitle: true,
          bottom: TabBarComponents.tabBarComponents[_currentIndex],
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                if (_currentIndex == 0) {
                } else if (_currentIndex == 2) {
                  if (AnimeSearchDelegate.data.isEmpty) {
                    FirebaseDatabase.instance
                        .reference()
                        .child("anime")
                        .onValue
                        .listen((event) {
                      AnimeSearchDelegate.data = event.snapshot.value;
                    });
                  }
                  showSearch(context: context, delegate: AnimeSearchDelegate());
                } else {}
              },
            )
          ],
        ),
        drawer: DrawerComponent(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Movies"),
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Series"),
            BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "Anime")
          ],
        ),
        body: BodyComponents.bodyComponent[_currentIndex],
      ),
    );
  }
}
