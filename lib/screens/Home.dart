import 'package:FreeFlix/component/MainBody.dart';
import 'package:FreeFlix/screens/Search.dart';
import 'package:FreeFlix/data/SearchData.dart';
import 'package:FreeFlix/screens/drawer/Report.dart';
import 'package:FreeFlix/screens/drawer/Request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

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
  MobileAdTargetingInfo targetingInfo;
  BannerAd myBanner;

  @override
  void initState() {
    super.initState();
    targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['wallpaper'],
      childDirected: false,
      testDevices: <String>[],
    );
    myBanner = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
    myBanner
      ..load()
      ..show(
        anchorOffset: 60.0,
        horizontalCenterOffset: 10.0,
        anchorType: AnchorType.bottom,
      );
    movies = TabController(length: 2, vsync: this);
    anime = TabController(length: 3, vsync: this);
    series = TabController(length: 1, vsync: this);
    homeBodyItems = [
      TabBarView(
        controller: movies,
        children: [
          MainBody(
            collection: "movies",
            type: 1,
          ),
          MainBody(
            collection: "movies",
            type: 0,
          )
        ],
      ),
      TabBarView(
        controller: series,
        children: [
          MainBody(
            collection: "series",
            type: 0,
          )
        ],
      ),
      TabBarView(
        controller: anime,
        children: [
          MainBody(
            collection: "anime",
            type: 0,
          ),
          Container(),
          Container()
        ],
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
    myBanner?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            children: [
              Divider(
                color: Vx.white,
              ),
              ListTile(
                title: "Request".text.bold.make(),
              ).onInkTap(() {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Request(),
                ));
              }),
              Divider(
                color: Vx.white,
              ),
              ListTile(
                title: "Report a Problem".text.bold.make(),
              ).onInkTap(() {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Report(),
                ));
              }),
              Divider(
                color: Vx.white,
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
