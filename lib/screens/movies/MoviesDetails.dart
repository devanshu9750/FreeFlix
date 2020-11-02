import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MoviesDetails extends StatelessWidget {
  final data;
  MoviesDetails({this.data});
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.black,
        child: IconButton(
            icon: Icon(Icons.play_arrow, color: Colors.red), onPressed: () {}),
      ),
      appBar: AppBar(
      ),
      body: SafeArea(
        child: VStack([
          Center(
            child: Hero(
              tag: data['title'],
              child: Container(
                height: 230,
                width: 150,
                child: ClipRRect(
                  child: Image.network(data['posterurl']),
                  borderRadius: BorderRadius.circular(25),
                ),
              ).pOnly(top: 30),
            ),
          ),
          Center(
            child: SizedBox(
              width: 250,
              child: Text(
                data['title'],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ).pOnly(top: 20),
            ),
          ),
          Center(
            child: SizedBox(
              width: 250,
              child: Text(
                data['genre'],
                textAlign: TextAlign.center,
              ),
            ),
          ).pOnly(top: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Container(
                      color: Colors.black.withOpacity(0.9),
                      height: 80,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['imdb'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "IMDB rating",
                            textAlign: TextAlign.center,
                          ).pOnly(top: 5),
                        ],
                      )),
                ],
              ),
              Column(
                children: [
                  Container(
                      color: Colors.black.withOpacity(0.9),
                      height: 80,
                      width: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data['duration'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            "Duration",
                            textAlign: TextAlign.center,
                          ).pOnly(top: 5),
                        ],
                      )),
                ],
              ),
            ],
          ).pOnly(top: 30),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                child: Column(
                  children: [
                    "Plot"
                        .text
                        .textStyle(Theme.of(context).textTheme.headline6)
                        .center
                        .bold
                        .make()
                        .pOnly(top: 10),
                    Text(
                      data['description'],
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ).p16()
                  ],
                ),
              ),
            ).pOnly(top: 22),
          )
        ]).scrollVertical(),
      ),
    );
  }
}
