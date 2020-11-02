import 'package:FreeFlix/screens/movies/MovieCategory.dart';
import 'package:FreeFlix/screens/movies/MoviesDetails.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieComponent extends StatefulWidget {
  final int type;

  MovieComponent({this.type});

  @override
  _MovieComponentState createState() => _MovieComponentState();
}

class _MovieComponentState extends State<MovieComponent> {
  List<Map> data;
  bool _loading = true;
  getdata() async {
    if (widget.type == 1) {
      FirebaseDatabase.instance
          .reference()
          .child("movies")
          .orderByChild("type")
          .equalTo(1)
          .onValue
          .listen((event) {
        data = [];
        event.snapshot.value.forEach((key, value) {
          value['title'] = key;
          data.add(value);
          data.sort((a, b) => (a['release'].compareTo(b['release']) == 1)
              ? -1
              : (a['release'].compareTo(b['release']) == 0)
                  ? 0
                  : 1);
        });

        setState(() {
          _loading = false;
        });
      });
    }
    if (widget.type == 0) {
      FirebaseDatabase.instance
          .reference()
          .child("movies")
          .orderByChild("type")
          .equalTo(0)
          .onValue
          .listen((event) {
        data = [];
        event.snapshot.value.forEach((key, value) {
          value["title"] = key;
          data.add(value);

          data.sort((a, b) => (a['release'].compareTo(b['release']) == 1)
              ? -1
              : (a['release'].compareTo(b['release']) == 0)
                  ? 0
                  : 1);
        });
        setState(() {
          _loading = false;
        });
      });
    }
  }

  List<String> categories = [
    "Action",
    "Comedy",
    "Drama",
    "Romance",
    "Fantasy",
    "Thriller"
  ];
  @override
  void initState() {
    super.initState();
    getdata();
    setState(() {
      _loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_loading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : VStack([
            "Latest Movies"
                .text
                .textStyle(Theme.of(context).textTheme.headline6)
                .bold
                .make()
                .pOnly(left: 20, top: 20),
            HStack(data
                    .sublist(0, 10)
                    .map((e) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MoviesDetails(
                                          data: e,
                                        )));
                          },
                          child: Column(
                            children: [
                              Hero(
                                tag: e['title'],
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(25),
                                    child: Image.network(
                                      e['posterurl'],
                                      fit: BoxFit.cover,
                                      height: 190,
                                      width: 140,
                                    ),
                                  ).px8(),
                                ),
                              ),
                              SizedBox(
                                height: 100,
                                width: 130,
                                child: Column(
                                  children: [
                                    Text(e['title'],
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))
                                        .pOnly(top: 3),
                                    Text(
                                      e['genre'],
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(fontSize: 12),
                                    )
                                        .opacity(value: 0.5)
                                        .box
                                        .width(100)
                                        .make()
                                        .pOnly(top: 5)
                                  ],
                                ),
                              ).pOnly(top: 4),
                            ],
                          ),
                        ))
                    .toList())
                .scrollHorizontal()
                .pOnly(top: 15),
            "Categories"
                .text
                .textStyle(Theme.of(context).textTheme.headline6)
                .bold
                .make()
                .pOnly(
                  left: 20,
                ),
            HStack(categories
                    .map((e) => GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MovieCategory(
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
                          ).pOnly(left: 10),
                        ))
                    .toList())
                .scrollHorizontal()
                .pOnly(top: 15),
            "Movies"
                .text
                .textStyle(Theme.of(context).textTheme.headline6)
                .bold
                .make()
                .pOnly(top: 25, left: 20),
            GridView.builder(
              itemCount: data.sublist(10).length,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.58),
              itemBuilder: (context, i) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MoviesDetails(
                                      data: data[i + 10],
                                    )));
                      },
                      child: Hero(
                        tag: data[i + 10]['title'],
                        child: Container(
                          child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.network(
                                      data[i + 10]['posterurl'],
                                      fit: BoxFit.cover,
                                      height: 190,
                                      width: 140))
                              .px8(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 130,
                      child: Column(
                        children: [
                          Text(data[i + 10]['title'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              .pOnly(top: 3),
                          Text(
                            data[i + 10]['genre'],
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontSize: 12),
                          )
                              .opacity(value: 0.5)
                              .box
                              .width(100)
                              .make()
                              .pOnly(top: 5)
                        ],
                      ),
                    ).pOnly(top: 4),
                  ],
                );
              },
            ).pOnly(top: 20)
          ]).scrollVertical();
  }
}
