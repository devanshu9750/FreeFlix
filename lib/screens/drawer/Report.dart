import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:velocity_x/velocity_x.dart';

class Report extends StatelessWidget {
  String prb = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Report".text.make(),
      ),
      body: VStack([
        TextFormField(
          onChanged: (value) {
            prb = value;
          },
          maxLines: 10,
          scrollPhysics: ScrollPhysics(),
          decoration: InputDecoration(
              labelText: "Problems",
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              hintText:
                  "Eg.  Anime- (Dubbed) My hero acaademia Season 2  episode 1 ",
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
              color: Colors.black45,
              elevation: 20,
              padding: EdgeInsets.only(left: 60, right: 60),
              child: "Submit".text.white.make(),
              splashColor: Colors.red,
              onPressed: () {
                 const _chars =
                      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
                  Random _rnd = Random();

                  String getRandomString(int length) =>
                      String.fromCharCodes(Iterable.generate(
                          length,
                          (_) =>
                              _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
                
                FirebaseDatabase.instance.reference().child("report").child(getRandomString(20)).update({"problems":prb});
                Navigator.of(context).pop();
              }),
        )
      ]).scrollVertical(),
    );
  }
}
