import 'package:FreeFlix/component/Ads.dart';
import 'package:FreeFlix/screens/detail/MDetailPage.dart';
import 'package:FreeFlix/screens/detail/SDetailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Grid extends StatefulWidget {
  final String collection;
  final int type;
  final int total;
  final List<QueryDocumentSnapshot> data;
  ScrollController controller;
  Grid({this.collection, this.type, this.total, this.data, this.controller});
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  int limit;
  @override
  void initState() {
    super.initState();
    if (widget.total > 22) {
      limit = 22;
    } else {
      limit = widget.total;
    }
    widget.controller.addListener(() {
      if (widget.controller.position.atEdge) {
        if (widget.controller.position.pixels == 0) {
        } else {
          if ((limit + 12) > widget.total) {
            setState(() {
              limit = widget.total;
            });
          } else {
            setState(() {
              limit = limit + 12;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: ScrollPhysics(),
      childAspectRatio: 0.5,
      children: widget.data
          .sublist(10, limit)
          .map((document) => GestureDetector(
                onTap: () {
                  Ads.disposeBannerAd();
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
                      height: 60,
                      child: (widget.collection == "movies" ||
                              widget.collection == "series")
                          ? document.id.text.bold.center.make()
                          : (widget.type == 2)
                              ? (document.id[1] == "D")
                                  ? ("(Dub) " + document.id.substring(6))
                                      .text
                                      .center
                                      .bold
                                      .make()
                                  : ("(Sub) " + document.id.substring(6))
                                      .text
                                      .center
                                      .bold
                                      .make()
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
    ).pOnly(top: 20);
  }
}
