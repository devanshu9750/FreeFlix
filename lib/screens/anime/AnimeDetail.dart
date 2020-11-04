import 'package:FreeFlix/screens/anime/AnimeEpisodeList.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AnimeDetail extends StatelessWidget {
  final Map data;

  AnimeDetail({this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: VStack([
          Center(
            child: Hero(
              tag: data['title'],
              child: Container(
                height: 230,
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    data['posterurl'],
                    fit: BoxFit.fill,
                  ),
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
                )),
          ).pOnly(top: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.yellow, width: 1)),
                elevation: 10,
                color: Color.fromRGBO(31,31,31,1),
                child: Container(
                  height: 80,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data['imdb'],style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),),
                      "IMDB rating".text.make().pOnly(top: 5)
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.green, width: 1)),
                elevation: 10,
                color: Color.fromRGBO(31,31,31,1),
                child: Container(
                  height: 80,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(data['seasons'].toString(),style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),),
                      "Seasons".text.make().pOnly(top: 5)
                    ],
                  ),
                ),
              )
            ],
          ).pOnly(top: 30),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.blue)),
              elevation: 10,
              color: Color.fromRGBO(31,31,31,1),
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
                      data['description'],
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 16),
                    ).p16()
                  ],
                ),
              ),
            ).pOnly(left: 15, right: 15, top: 30, bottom: 0),
          ),
          "Seasons"
              .text
              .textStyle(Theme.of(context).textTheme.headline6)
              .bold
              .make()
              .pOnly(left: 20, top: 20),
          ListView.builder(
            itemCount: data['seasons'],
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AnimeEpisodeList(
                    data: data['Season ' + (index + 1).toString()],
                    title: 'Season ' + (index + 1).toString(),
                  ),
                ));
              },
              child: Container(
                child: Card(
                  color: Colors.black45,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white)),
                  child: ListTile(
                    title: Text('Season ' + (index + 1).toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ),
          ).pOnly(left: 15, right: 15, top: 10, bottom: 20)
        ]).scrollVertical(),
      ),
    );
  }
}
