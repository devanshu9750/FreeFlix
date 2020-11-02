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
            child: Container(
              height: 230,
              width: 150,
              child: Hero(
                tag: data['title'],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    data['posterurl'],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ).pOnly(top: 30),
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
              Column(
                children: [
                  Text(data['imdb']),
                  "IMDB rating".text.make().pOnly(top: 5)
                ],
              ),
              Column(
                children: [
                  Text(data['seasons'].toString()),
                  "Seasons".text.make().pOnly(top: 5)
                ],
              )
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
                        .bold
                        .textStyle(Theme.of(context).textTheme.headline6)
                        .make(),
                    Text(
                      data['description'],
                      textAlign: TextAlign.justify,
                    ).pOnly(top: 10)
                  ],
                ),
              ).p16(),
            ),
          ).pOnly(top: 30),
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
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  title: Text('Season ' + (index + 1).toString()),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
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
