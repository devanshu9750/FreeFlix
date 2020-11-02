import 'package:FreeFlix/components/BodyComponents.dart';
import 'package:FreeFlix/components/DrawerComponent.dart';
import 'package:FreeFlix/components/TabBarComponents.dart';
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
              onPressed: () {},
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
