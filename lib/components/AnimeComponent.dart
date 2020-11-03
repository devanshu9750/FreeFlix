import 'package:FreeFlix/screens/anime/AnimeCategory.dart';
import 'package:FreeFlix/screens/anime/AnimeDetail.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AnimeComponent extends StatefulWidget {
  final int type;

  AnimeComponent({this.type});

  @override
  _AnimeComponentState createState() => _AnimeComponentState();
}

class _AnimeComponentState extends State<AnimeComponent> {
  bool _loading = true;
  List<Map> data;
  int total = 10;
  List<String> categories = [
    "Action",
    "Comedy",
    "Drama",
    "Romance",
    "Sci-Fi",
    "Fantasy",
    "Thriller"
  ];

  getData() async {
    if (widget.type == 0) {
      FirebaseDatabase.instance
          .reference()
          .child("anime")
          .orderByChild("type")
          .equalTo(0)
          .onValue
          .listen((event) {
        data = [];
        event.snapshot.value.forEach((key, value) {
          value['title'] = key;
          data.add(value);
        });
        data.sort((a, b) => (a['imdb'].compareTo(b['imdb']) == 1)
            ? -1
            : (a['imdb'].compareTo(b['imdb']) == 0)
                ? 0
                : 1);
        setState(() {
          _loading = false;
        });
      });
    } else if (widget.type == 1) {
      FirebaseDatabase.instance
          .reference()
          .child("anime")
          .orderByChild("type")
          .equalTo(1)
          .onValue
          .listen((event) {
        data = [];
        event.snapshot.value.forEach((key, value) {
          value['title'] = key;
          data.add(value);
        });
        data.sort((a, b) => (a['imdb'].compareTo(b['imdb']) == 1)
            ? -1
            : (a['imdb'].compareTo(b['imdb']) == 0)
                ? 0
                : 1);
        setState(() {
          _loading = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    categories.sort();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return (_loading)
        ? Center(child: CircularProgressIndicator())
        : VStack([
            "Highly Rated"
                .text
                .textStyle(Theme.of(context).textTheme.headline6)
                .bold
                .make()
                .pOnly(left: 20, top: 20),
            HStack(data
                    .sublist(0, 10)
                    .map((e) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AnimeDetail(
                                data: e,
                              ),
                            ));
                          },
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Hero(
                                  tag: e['title'],
                                  child: Container(
                                    height: 180,
                                    width: 125,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        e['posterurl'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width: 130,
                                  height: 78,
                                  child: Text(
                                    e['title'].substring(6),
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ).pOnly(top: 6))
                            ],
                          ).pOnly(left: 5, right: 5),
                        ))
                    .toList())
                .scrollHorizontal()
                .pOnly(top: 15),
            "Categories"
                .text
                .textStyle(Theme.of(context).textTheme.headline6)
                .bold
                .make()
                .pOnly(left: 20),
            HStack(categories
                    .map((e) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AnimeCategory(
                                category: e,
                                data: data,
                              ),
                            ));
                          },
                          child: Column(
                            children: [
                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  child: e[0].text.bold.makeCentered(),
                                ),
                              ),
                              e.text.center.make().pOnly(top: 5)
                            ],
                          ).pOnly(left: 15),
                        ))
                    .toList())
                .scrollHorizontal()
                .pOnly(top: 15),
            "Other Anime"
                .text
                .textStyle(Theme.of(context).textTheme.headline6)
                .bold
                .make()
                .pOnly(top: 25, left: 20),
            GridView.builder(
              itemCount: data.sublist(10).length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  maxCrossAxisExtent: 150,
                  childAspectRatio: 0.49),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AnimeDetail(
                      data: data.sublist(10)[index],
                    ),
                  ));
                },
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        height: 180,
                        width: 125,
                        child: Hero(
                          tag: data[index + 10]['title'],
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              data[index + 10]['posterurl'],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 130,
                        height: 78,
                        child: Text(
                          data[index + 10]['title'].substring(6),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ).pOnly(top: 6))
                  ],
                ).pOnly(left: 5, right: 5),
              ),
            ).pOnly(top: 20, bottom: 20)
          ]).scrollVertical();
  }
}
