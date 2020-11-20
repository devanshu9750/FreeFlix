import 'package:FreeFlix/screens/Player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MDetailPage extends StatelessWidget {
  final QueryDocumentSnapshot data;
  MDetailPage({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.9),
            borderRadius: BorderRadius.circular(50),
            border: Border(
                top: BorderSide(color: Colors.red, width: 1),
                bottom: BorderSide(color: Colors.red, width: 1),
                left: BorderSide(color: Colors.red, width: 1),
                right: BorderSide(color: Colors.red, width: 1))),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Player(
                id: data.data()['id'],
              ),
            ));
          },
          backgroundColor: Colors.black,
          child: Icon(Icons.play_arrow, color: Colors.red),
        ),
      ),
      body: VStack([
        Center(
          child: Hero(
            tag: data.id,
            child: Container(
              height: 200,
              width: (context.mq.size.width / 3),
              child: ClipRRect(
                child: Image.network(data.data()['posterurl']),
                borderRadius: BorderRadius.circular(20),
              ),
            ).pOnly(top: 30),
          ),
        ),
        Center(
          child: SizedBox(
            width: 250,
            child: data.id.text.bold.center
                .textStyle(Theme.of(context).textTheme.headline6)
                .make()
                .pOnly(top: 20),
          ),
        ),
        Center(
          child: SizedBox(
            width: 250,
            child: Text(
              data['genre'],
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ).pOnly(top: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.yellow, width: 1)),
                  elevation: 10,
                  color: Color.fromRGBO(31, 31, 31, 1),
                  child: Container(
                    height: 80,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.data()['imdb'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Text(
                          "IMDb",
                          textAlign: TextAlign.center,
                        ).pOnly(top: 5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.green, width: 1)),
                  elevation: 10,
                  color: Color.fromRGBO(31, 31, 31, 1),
                  child: Container(
                      height: 80,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.data()['duration'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "Duration",
                            textAlign: TextAlign.center,
                          ).pOnly(top: 5),
                        ],
                      )),
                ),
              ],
            ),
          ],
        ).pOnly(top: 20),
        Center(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.blue, width: 1)),
            elevation: 10,
            color: Color.fromRGBO(31, 31, 31, 1),
            child: Container(
              width: MediaQuery.of(context).size.width - 50,
              child: Column(
                children: [
                  "Plot"
                      .text
                      .textStyle(Theme.of(context).textTheme.headline6)
                      .color(Colors.blue)
                      .center
                      .bold
                      .make()
                      .pOnly(top: 10),
                  Text(
                    data.data()['plot'],
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16),
                  ).p16()
                ],
              ),
            ),
          ).pOnly(left: 15, right: 15, top: 20, bottom: 0),
        ),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.deepPurpleAccent, width: 1)),
          elevation: 10,
          color: Color.fromRGBO(31, 31, 31, 1),
          child: Container(
            width: 180,
            child: Column(
              children: [
                "Release Date"
                    .text
                    .textStyle(Theme.of(context).textTheme.headline6)
                    .color(Colors.deepPurpleAccent)
                    .center
                    .bold
                    .make()
                    .pOnly(top: 10),
                Text(
                  data.data()['release'].split('-')[2] +
                      "-" +
                      data.data()['release'].split('-')[1] +
                      "-" +
                      data.data()['release'].split('-')[0],
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ).p16()
              ],
            ),
          ),
        ).pOnly(left: 25, right: 15, top: 20, bottom: 20)
      ]).scrollVertical(),
    );
  }
}
