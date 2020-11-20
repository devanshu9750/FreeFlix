import 'package:FreeFlix/screens/Player.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class EpisodeList extends StatelessWidget {
  final String title;
  final Map data;
  EpisodeList({this.title, this.data});
  @override
  Widget build(BuildContext context) {
    List<String> keys = data.keys.toList();
    keys.sort();
    return Scaffold(
      appBar: AppBar(
        title: title.text.make(),
      ),
      body: VStack(keys
              .map((key) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Player(
                          id: data[key],
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
                          title: key.toString().text.make(),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  ))
              .toList())
          .pOnly(top: 10, bottom: 20)
          .scrollVertical(),
    );
  }
}
