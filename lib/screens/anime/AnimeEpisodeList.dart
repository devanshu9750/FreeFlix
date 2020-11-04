import 'package:FreeFlix/screens/videoplayer/PlayVideo.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AnimeEpisodeList extends StatelessWidget {
  final Map data;
  final String title;

  AnimeEpisodeList({this.data, this.title});

  @override
  Widget build(BuildContext context) {
    List<Map> finalData = [];
    data.forEach((key, value) {
      finalData.add({"title": key, "id": value});
    });
    finalData.sort((a, b) => a['title'].compareTo(b["title"]));
    return Scaffold(
      appBar: AppBar(
        title: title.text.make(),
      ),
      body: VStack(finalData
              .map((e) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlayVideo(
                          id: e['id'],
                        ),
                      ));
                    },
                    child: Card(
                      color: Color.fromRGBO(31, 31, 31, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),side: BorderSide(color: Colors.white,width: 1)),
                      child: ListTile(
                        title: Text(e['title']),
                        leading: Icon(
                          Icons.play_circle_outline,
                          size: 30,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ))
              .toList())
          .scrollVertical()
          .p12(),
    );
  }
}
