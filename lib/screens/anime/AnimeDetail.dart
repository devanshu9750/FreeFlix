import 'dart:convert';
import 'package:FreeFlix/backend/Data.dart';
import 'package:FreeFlix/screens/anime/AnimeEpisodeList.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AnimeDetail extends StatefulWidget {
  final Map data;

  AnimeDetail({this.data});

  @override
  _AnimeDetailState createState() => _AnimeDetailState();
}

class _AnimeDetailState extends State<AnimeDetail> {
  bool _check;

  @override
  void initState() {
    super.initState();
    Map tempData = Data.data;
    _check = tempData.containsKey(widget.data['title']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          (_check)
              ? Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.star,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Data.data.removeWhere(
                          (key, value) => (key == widget.data['title']));
                      Data.prefs.setString("starred", jsonEncode(Data.data));
                      Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Color.fromRGBO(31, 31, 31, 1),
                          duration: Duration(seconds: 1),
                          content: Text("Removed from Starred !!")
                              .text
                              .white
                              .make()));
                      setState(() {
                        _check = false;
                      });
                    },
                  ),
                )
              : Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.star_border),
                    onPressed: () {
                      Data.data[widget.data['title']] = widget.data;
                      Data.prefs.setString("starred", jsonEncode(Data.data));
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text("Added to Starred !!").text.white.make(),
                        backgroundColor: Color.fromRGBO(31, 31, 31, 1),
                        duration: Duration(seconds: 1),
                      ));
                      setState(() {
                        _check = true;
                      });
                    },
                  ),
                )
        ],
      ),
      body: SafeArea(
        child: VStack([
          Center(
            child: Hero(
              tag: widget.data['title'],
              child: Container(
                height: 230,
                width: 150,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.data['posterurl'],
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
                widget.data['title'],
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6,
              ).pOnly(top: 20),
            ),
          ),
          Center(
            child: SizedBox(
                width: 250,
                child: Text(
                  widget.data['genre'],
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
                color: Color.fromRGBO(31, 31, 31, 1),
                child: Container(
                  height: 80,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.data['imdb'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
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
                color: Color.fromRGBO(31, 31, 31, 1),
                child: Container(
                  height: 80,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.data['seasons'].toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
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
                      widget.data['description'],
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
            itemCount: widget.data['seasons'],
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AnimeEpisodeList(
                    data: widget.data['Season ' + (index + 1).toString()],
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
