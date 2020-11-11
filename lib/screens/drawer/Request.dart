import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:math';

class Request extends StatelessWidget {
  String movie = "", anime = "", series = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Request ".text.make(),
      ),
      body: SafeArea(
        child: Container(
          child: VStack([
            "Movies"
                .text
                .textStyle(Theme.of(context).textTheme.headline6)
                .bold
                .make()
                .pOnly(left: 20, top: 20),
            TextFormField(
              onChanged: (value) {
                movie = value;
              },
              maxLines: 5,
              scrollPhysics: ScrollPhysics(),
              decoration: InputDecoration(
                  labelText: "Movies",
                  hintText: "Movies Name",
                  contentPadding: EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 20,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ).p(20),
            "Series"
                .text
                .textStyle(Theme.of(context).textTheme.headline6)
                .bold
                .make()
                .pOnly(left: 20, top: 20),
            TextFormField(
              onChanged: (value) {
                series = value;
              },
              maxLines: 5,
              scrollPhysics: ScrollPhysics(),
              decoration: InputDecoration(
                  labelText: "Series",
                  hintText: "Series Name",
                  contentPadding: EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 20,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ).p(20),
            "Anime"
                .text
                .textStyle(Theme.of(context).textTheme.headline6)
                .bold
                .make()
                .pOnly(left: 20, top: 20),
            TextFormField(
              onChanged: (value) {
                anime = value;
              },
              maxLines: 5,
              scrollPhysics: ScrollPhysics(),
              decoration: InputDecoration(
                  labelText: "Anime",
                  hintText: "Anime Name",
                  contentPadding: EdgeInsets.all(10),
                  enabledBorder: OutlineInputBorder(
                    gapPadding: 20,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ).p(20),
            Center(
              child: RaisedButton(
                onPressed: () {
                  const _chars =
                      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                  Random _rnd = Random();

                  String getRandomString(int length) =>
                      String.fromCharCodes(Iterable.generate(
                          length,
                          (_) =>
                              _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
                  FirebaseDatabase.instance
                      .reference()
                      .child("request")
                      .child(getRandomString(20))
                      .update(
                          {"movies": movie, "series": series, "anime": anime});

                  Navigator.of(context).pop();
                },
                child: "Submit".text.make(),
                color: Colors.black45,
                elevation: 20,
                splashColor: Colors.red,
                padding:
                    EdgeInsets.only(left: 60, right: 60, top: 10, bottom: 10),
              ).pOnly(top: 20),
            )
          ]).scrollVertical(),
        ),
      ),
    );
  }
}
