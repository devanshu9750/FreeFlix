import 'package:FreeFlix/backend/Data.dart';
import 'package:FreeFlix/screens/anime/AnimeDetail.dart';
import 'package:FreeFlix/screens/series/SeriesDetails.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Starred extends StatefulWidget {
  @override
  _StarredState createState() => _StarredState();
}

class _StarredState extends State<Starred> {
  List<Map> data = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Data.data.forEach((key, value) {
      data.add(value);
    });

    return Scaffold(
      appBar: AppBar(
        title: "Starred".text.make(),
      ),
      body: GridView.builder(
        itemCount: data.length,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            mainAxisSpacing: 0,
            crossAxisSpacing: 10,
            maxCrossAxisExtent: 150,
            childAspectRatio: 0.46),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            if (data[index]['title'].toString().substring(0, 2) == "(D" ||
                data[index]['title'].toString().substring(0, 2) == "(S") {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AnimeDetail(
                  data: data[index],
                ),
              ));
            } else if (data[index].containsKey("seasons")) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SeriesDetails(
                  data: data[index],
                ),
              ));
            }
          },
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Hero(
                  tag: data[index]['title'],
                  child: Container(
                    height: 180,
                    width: 125,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        data[index]['posterurl'],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: 130,
                  height: 78,
                  child: Text(data[index]['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ).pOnly(top: 6))
            ],
          ).pOnly(left: 5, right: 5),
        ),
      ).pOnly(top: 20, bottom: 20),
    );
  }
}
