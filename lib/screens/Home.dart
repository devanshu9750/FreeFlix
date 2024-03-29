import 'package:FreeFlix/component/Ads.dart';
import 'package:FreeFlix/screens/Search.dart';
import 'package:FreeFlix/data/SearchData.dart';
import 'package:FreeFlix/screens/drawer/Report.dart';
import 'package:FreeFlix/screens/drawer/Request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import '../component/HomeBodyItems.dart';
import 'drawer/ContentNotice.dart';

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
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Image.asset("assets/icon1.png")),
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
                  title: "Request".text.bold.size(16).make(),
                ).onInkTap(() {
                  Ads.disposeBannerAd();
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
                  title: "Report a Problem".text.bold.size(16).make(),
                ).onInkTap(() {
                  Ads.disposeBannerAd();
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Report(),
                  ));
                }),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Vx.white, width: 1)),
                color: Colors.black54,
                child: ListTile(
                  title: "Content Notice".text.bold.size(16).make(),
                ).onInkTap(() {
                  Ads.disposeBannerAd();
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ContentNotice(),
                  ));
                }),
              ),
              SizedBox(
                height: 10,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: Vx.white, width: 1)),
                color: Colors.black54,
                child: ListTile(
                  title: "Update".text.bold.size(16).make(),
                ).onInkTap(() async {
                  Navigator.of(context).pop();
                  Ads.disposeBannerAd();
                  PackageInfo info = await PackageInfo.fromPlatform();
                  if (info.version !=
                      (await FirebaseFirestore.instance
                              .collection("texts")
                              .doc("version")
                              .get())
                          .data()['value']) {
                    launch((await FirebaseFirestore.instance
                            .collection("texts")
                            .doc("update")
                            .get())
                        .data()['value']);
                  } else {
                    context.showToast(
                        msg: "Your app is already upto date !!",
                        bgColor: Vx.black,
                        textColor: Vx.white,
                        showTime: 3000);
                  }
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
              FirebaseFirestore.instance
                  .collection("movies")
                  .get()
                  .then((QuerySnapshot snapshot) {
                SearchData.data = snapshot.docs;
                FirebaseFirestore.instance
                    .collection("series")
                    .get()
                    .then((QuerySnapshot snapshot) {
                  SearchData.data.addAll(snapshot.docs);
                  FirebaseFirestore.instance
                      .collection("anime")
                      .get()
                      .then((QuerySnapshot snapshot) {
                    SearchData.data.addAll(snapshot.docs);
                  });
                });
              });
              showSearch(context: context, delegate: Search());
              Ads.disposeBannerAd();
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
