import 'package:FreeFlix/screens/videoplayer/PlayVideo.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AnimeEpisodeList extends StatelessWidget {
  final Map data;
  final String title;

  AnimeEpisodeList({this.data, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: title.text.make(),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PlayVideo(
                id: data["Episode - " +
                    (((index + 1) < 10)
                        ? "0" + (index + 1).toString()
                        : (index + 1).toString())],
              ),
            ));
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios),
              leading: Icon(Icons.play_circle_outline),
              title: Text("Episode - " +
                  (((index + 1) < 10)
                      ? '0' + (index + 1).toString()
                      : (index + 1).toString())),
            ),
          ),
        ),
      ).p12(),
    );
  }
}
