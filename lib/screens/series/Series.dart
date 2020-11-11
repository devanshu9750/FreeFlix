import 'package:FreeFlix/screens/series/SeriesDetails.dart';
import 'package:FreeFlix/screens/series/Seriescategory.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Series extends StatefulWidget {
  @override
  _SeriesState createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
  bool _loading = true;
  List<Map> data;
  List<String> categories = [
    "Action",
    "Comedy",
    "Drama",
    "Fantasy",
    "Mystery",
    "Romance",
    "Sci-fi",
    "Thriller",
  ];
  getdata() async {
    FirebaseDatabase.instance
        .reference()
        .child("series")
        .orderByChild('release')
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
      print(data);

      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return (_loading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : VStack([
            "Top Series"
                .text
                .textStyle(Theme.of(context).textTheme.headline6)
                .bold
                .make()
                .pOnly(left: 20, top: 20),
            HStack(data
                    .map((e) => GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SeriesDetails(
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
                              builder: (context) => SeriesCategory(
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
            GridView.builder(
              itemCount: data.sublist(1).length,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  maxCrossAxisExtent: 150,
                  childAspectRatio: 0.8),
              itemBuilder: (context, i) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SeriesDetails(
                                      data: data[i + 1],
                                    )));
                      },
                      child: Hero(
                        tag: data[i + 1]['title'],
                        child: Container(
                          height: 180,
                          width: 125,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                data[i + 1]['posterurl'],
                                fit: BoxFit.cover,
                              )).px8(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      height: 86,
                      child: Column(
                        children: [
                          Text(data[i + 1]['title'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold))
                              .pOnly(top: 3),
                          Text(
                            data[i + 1]['genre'],
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
          ]);
  }
}
