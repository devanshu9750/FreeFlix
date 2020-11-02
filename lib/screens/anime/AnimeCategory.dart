import 'package:FreeFlix/screens/anime/AnimeDetail.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class AnimeCategory extends StatefulWidget {
  final String category;
  final List<Map> data;
  AnimeCategory({this.category, this.data});

  @override
  _AnimeCategoryState createState() => _AnimeCategoryState();
}

class _AnimeCategoryState extends State<AnimeCategory> {
  bool _loading = true;
  List<Map> finalData;

  filterData() {
    finalData = [];
    widget.data.forEach((element) {
      if (element['genre']
          .toLowerCase()
          .contains(widget.category.toLowerCase())) {
        finalData.add(element);
      }
    });
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    filterData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.category.text.center.make(),
      ),
      body: (_loading)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: finalData.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  maxCrossAxisExtent: 130,
                  childAspectRatio: 0.5),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AnimeDetail(
                      data: finalData[index],
                    ),
                  ));
                },
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Hero(
                        tag: finalData[index]['title'],
                        child: Container(
                          height: 180,
                          width: 125,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              finalData[index]['posterurl'],
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 130,
                        height: 60,
                        child: Text(
                          finalData[index]['title'].substring(6),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ).pOnly(top: 6))
                  ],
                ).pOnly(left: 5, right: 5),
              ),
            ).pOnly(top: 20),
    );
  }
}
