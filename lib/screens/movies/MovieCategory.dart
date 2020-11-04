import 'package:FreeFlix/screens/movies/MoviesDetails.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MovieCategory extends StatefulWidget {
  final List<Map> data;
  final String category;
  MovieCategory({this.data, this.category});
  @override
  _MovieCategoryState createState() => _MovieCategoryState();
}

class _MovieCategoryState extends State<MovieCategory> {
  bool _loading = true;
  List<Map> finalData;
  filterData() async {
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
    // TODO: implement initState
    filterData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.category.text.center.make(),
      ),
      body: (_loading)
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 10,
                  maxCrossAxisExtent: 130,
                  childAspectRatio: 0.46),
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: finalData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MoviesDetails(
                        data: finalData[index],
                      ),
                    ));
                  },
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          height: 180,
                          width: 125,
                          child: Hero(
                            tag: finalData[index]['title'],
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
                          finalData[index]['title'],
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ).pOnly(top: 6))
                    ],
                  ).pOnly(left: 5, right: 5),
                );
              }),
    );
  }
}
