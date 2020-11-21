import 'package:FreeFlix/screens/Category.dart';
import 'package:FreeFlix/screens/detail/MDetailPage.dart';
import 'package:FreeFlix/screens/detail/SDetailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Ads.dart';

class MainBody extends StatelessWidget {
  final String collection;
  final int type;
  final List<String> categories = [
    "Action",
    "Adventure",
    "Comedy",
    "Drama",
    "Fantasy",
    "Romance"
  ];
  MainBody({this.collection, this.type});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: (collection == "series")
          ? FirebaseFirestore.instance
              .collection(collection)
              .orderBy("imdb", descending: true)
              .snapshots()
          : (collection == "movies")
              ? FirebaseFirestore.instance
                  .collection(collection)
                  .where("type", isEqualTo: type)
                  .orderBy("release", descending: true)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection(collection)
                  .where("type", isEqualTo: type)
                  .orderBy("imdb", descending: true)
                  .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return VStack([
          ((collection == "movies") ? "Latest Movies" : "Top rated")
              .text
              .textStyle(Theme.of(context).textTheme.headline6)
              .make()
              .pOnly(top: 15, left: 15),
          HStack(snapshot.data.docs
                  .sublist(0, 10)
                  .map((document) => GestureDetector(
                        onTap: () {
                          Ads.disposeAd();
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
                                width: (context.mq.size.width / 3) - 12,
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
                              width: (context.mq.size.width / 3) - 12,
                              height: 60,
                              child: (collection == "movies" ||
                                      collection == "series")
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
                  .toList())
              .scrollHorizontal()
              .pOnly(top: 10),
          "Categories"
              .text
              .textStyle(Theme.of(context).textTheme.headline6)
              .make()
              .pOnly(left: 15),
          HStack(categories
                  .map((category) => GestureDetector(
                        onTap: () async {
                          Ads.disposeAd();
                          List<QueryDocumentSnapshot> data = [];
                          snapshot.data.docs.forEach((document) {
                            if (document
                                .data()['genre']
                                .toLowerCase()
                                .contains(category.toLowerCase())) {
                              data.add(document);
                            }
                          });
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Category(
                              data: data,
                              category: category,
                              collection: collection,
                            ),
                          ));
                        },
                        child: Column(
                          children: [
                            Card(
                              shape: Vx.withRounded(20),
                              child: SizedBox(
                                height: 60,
                                width: 60,
                                child: category[0].text.makeCentered(),
                              ),
                            ),
                            category.text.bold.makeCentered().pOnly(top: 5)
                          ],
                        ),
                      ))
                  .toList())
              .scrollHorizontal()
              .pOnly(top: 15),
          ((collection == "movies")
                  ? "Other Movies"
                  : (collection == "series")
                      ? "Other Series"
                      : "Other Anime")
              .text
              .textStyle(Theme.of(context).textTheme.headline6)
              .make()
              .pOnly(left: 15, top: 30),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            childAspectRatio: 0.5,
            children: snapshot.data.docs
                .sublist(10)
                .map((document) => GestureDetector(
                      onTap: () {
                        Ads.disposeAd();
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
                            child: (collection == "movies" ||
                                    collection == "series")
                                ? document.id.text.center.bold.make()
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
          ).pOnly(top: 20)
        ]).scrollVertical();
      },
    );
  }
}