import 'package:FreeFlix/component/Ads.dart';
import 'package:FreeFlix/component/Grid.dart';
import 'package:FreeFlix/screens/Category.dart';
import 'package:FreeFlix/screens/detail/MDetailPage.dart';
import 'package:FreeFlix/screens/detail/SDetailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class MainBody extends StatelessWidget {
  final String collection;
  final int type;
  final List<String> categories = [
    "Action",
    "Adventure",
    "Comedy",
    "Drama",
    "Fantasy",
    "Horror",
    "Mystery",
    "Romance",
    "Thriller",
  ];

  ScrollController controller = ScrollController();
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
          return Center(
              child: "Something went wrong restart your app !!".text.make());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return VStack([
          FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection("flags")
                .doc("nativead")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.data()['value']) {
                  return Container(
                    height: 80,
                    width: context.mq.size.width,
                    decoration: BoxDecoration(color: Vx.white),
                    child: NativeAdmob(
                      adUnitID: "ca-app-pub-1508391904647076/5230012897",
                      loading: "Ads".text.bold.black.make(),
                      type: NativeAdmobType.banner,
                    ),
                  );
                }
                return Container();
              }
              return Container();
            },
          ),
          ((collection == "movies") ? "Latest Movies" : "Top rated")
              .text
              .textStyle(Theme.of(context).textTheme.headline6)
              .make()
              .pOnly(top: 15, left: 15),
          HStack(snapshot.data.docs
                  .sublist(0, 10)
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
                                  : (type == 2)
                                      ? (document.id[1] == "D")
                                          ? ("(Dub) " +
                                                  document.id.substring(6))
                                              .text
                                              .center
                                              .bold
                                              .make()
                                          : ("(Sub) " +
                                                  document.id.substring(6))
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
                        onTap: () {
                          Ads.disposeBannerAd();
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
          Grid(
              collection: collection,
              type: type,
              total: snapshot.data.docs.length,
              controller: controller,
              data: snapshot.data.docs),
          SizedBox(
            height: AdSize.banner.height.toDouble() - 5,
          )
        ]).scrollVertical(controller: controller);
      },
    );
  }
}
