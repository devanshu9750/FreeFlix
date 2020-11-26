import 'package:FreeFlix/component/Ads.dart';
import 'package:FreeFlix/screens/Search.dart';
import 'package:FreeFlix/data/SearchData.dart';
import 'package:FreeFlix/screens/drawer/Report.dart';
import 'package:FreeFlix/screens/drawer/Request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../component/HomeBodyItems.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  int _currentIndex = 0;
  List<TabBar> tabBarItems;
  List<Widget> homeBodyItems;
  TabController anime;
  TabController movies;
  TabController series;

  @override
  void initState() {
    super.initState();
    Ads.showBannerAd();
    movies = TabController(length: 2, vsync: this);
    anime = TabController(length: 3, vsync: this);
    series = TabController(length: 1, vsync: this);
    homeBodyItems = [
      Movies(
        controller: movies,
      ),
      Series(
        controller: series,
      ),
      Anime(
        controller: anime,
      ),
    ];
    tabBarItems = [
      TabBar(
        controller: movies,
        tabs: [
          Tab(
            text: "Hollywood",
          ),
          Tab(
            text: "Bollywood",
          ),
        ],
      ),
      TabBar(controller: series, tabs: [
        Tab(
          text: "Series",
        )
      ]),
      TabBar(
        controller: anime,
        tabs: [
          Tab(
            text: "Dubbed",
          ),
          Tab(
            text: "Subbed",
          ),
          Tab(
            text: "Movies",
          ),
        ],
      )
    ];
  }

  @override
  void dispose() {
    anime.dispose();
    series.dispose();
    movies.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              SizedBox(
                child: Image.asset("assets/icon1.PNG"),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white, width: 1)),
                color: Colors.black54,
                child: ListTile(
                  title: "Request".text.bold.make(),
                ).onInkTap(() {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Request(),
                  ));
                }),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Colors.white, width: 1)),
                color: Colors.black54,
                child: ListTile(
                  title: "Report a Problem".text.bold.make(),
                ).onInkTap(() {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Report(),
                  ));
                }),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: "FreeFlix".text.make(),
        centerTitle: true,
        bottom: tabBarItems[_currentIndex],
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search());
              if (_currentIndex == 0) {
                SearchData.collection = "movies";
                FirebaseFirestore.instance
                    .collection("movies")
                    .get()
                    .then((QuerySnapshot snapshot) {
                  SearchData.data = snapshot;
                });
              } else if (_currentIndex == 1) {
                SearchData.collection = "series";
                FirebaseFirestore.instance
                    .collection("series")
                    .get()
                    .then((QuerySnapshot snapshot) {
                  SearchData.data = snapshot;
                });
              } else {
                SearchData.collection = "anime";
                FirebaseFirestore.instance
                    .collection("anime")
                    .get()
                    .then((QuerySnapshot snapshot) {
                  SearchData.data = snapshot;
                });
              }
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
            movies.animateTo(0);
            series.animateTo(0);
            anime.animateTo(0);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies),
            label: "Movies",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Series"),
          BottomNavigationBarItem(
              icon: Icon(Icons.movie_filter_sharp), label: "Anime")
        ],
      ),
      body: homeBodyItems[_currentIndex],
    );
  }
}
