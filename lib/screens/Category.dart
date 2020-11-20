import 'package:FreeFlix/screens/detail/MDetailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'detail/SDetailPage.dart';

class Category extends StatelessWidget {
  final List<QueryDocumentSnapshot> data;
  final String category;
  final String collection;
  Category({this.data, this.category, this.collection});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: category.text.make(),
      ),
      body: VStack([
        SizedBox(
          height: 20,
        ),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          childAspectRatio: 0.5,
          children: data
              .map((document) => GestureDetector(
                    onTap: () {
                      if (document.data().containsKey("seasons")) {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SDetailPage(
                            data: document,
                          ),
                        ));
                        return;
                      }
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MDetailPage(
                          data: document,
                        ),
                      ));
                    },
                    child: Column(
                      children: [
                        Card(
                          shape: Vx.withRounded(20),
                          child: Container(
                            width: (context.mq.size.width / 3) - 10,
                            height: 180,
                            child: Hero(
                              tag: document.id,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  document.data()['posterurl'],
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: (context.mq.size.width / 3) - 10,
                          child:
                              (collection == "movies" || collection == "series")
                                  ? document.id.text.bold.center.make()
                                  : document.id
                                      .substring(6)
                                      .text
                                      .center
                                      .bold
                                      .make(),
                        ).pOnly(top: 10)
                      ],
                    ),
                  ))
              .toList(),
        )
      ]).scrollVertical(),
    );
  }
}
