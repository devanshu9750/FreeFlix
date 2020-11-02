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
          data.sort((a, b) => a['release'].compareTo(b['release']));
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

          data.sort((a, b) => a['release'].compareTo(b['release']));
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
                .p16(),
            HStack(data
                    .sublist(0, 1)
                    .map((e) => Column(
                          children: [
                            Container(
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
                            SizedBox(
                              height: 80,
                              child: Column(
                                children: [
                                  Text(
                                    e['title'],
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ).pOnly(top: 3),
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
                        ))
                    .toList())
                .pOnly(top: 5, left: 10)
                .scrollHorizontal(),
            "Categories"
                .text
                .textStyle(Theme.of(context).textTheme.headline6)
                .bold
                .make()
                .p16(),
            HStack(categories
                    .map((e) => GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => AnimeCategory(
                            //     category: e,
                            //     data: data,
                            //   ),
                            // ));
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
            "Movies"
                .text
                .textStyle(Theme.of(context).textTheme.headline6)
                .bold
                .make()
                .p16(),
            GridView.builder(
              itemCount: data.sublist(1).length,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.64),
              itemBuilder: (context, i) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => Details(navdata: data[i],)));
                      },
                      child: Container(
                        child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(data[i + 1]['posterurl'],
                                    fit: BoxFit.cover, height: 190, width: 140))
                            .px8(),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: Column(
                        children: [
                          Text(
                            data[i + 1]['title'],
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.bold),
                          ).pOnly(top: 3),
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
            )
          ]).scrollVertical();
  }
}
