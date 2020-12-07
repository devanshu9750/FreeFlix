import 'package:FreeFlix/component/Ads.dart';
import 'package:FreeFlix/screens/EpisdoeList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SDetailPage extends StatelessWidget {
  final QueryDocumentSnapshot data;
  SDetailPage({this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: VStack([
        Center(
          child: Hero(
            tag: data.id,
            child: Container(
              height: 200,
              width: (context.mq.size.width / 3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  data.data()['posterurl'],
                  fit: BoxFit.fill,
                ),
              ),
            ).pOnly(top: 30),
          ),
        ),
        Center(
          child: SizedBox(
            width: 250,
            child: Text(
              data.id,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline6,
            ).pOnly(top: 20),
          ),
        ),
        Center(
          child: SizedBox(
              width: 250,
              child: Text(
                data.data()['genre'],
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              )),
        ).pOnly(top: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.yellow, width: 1)),
              elevation: 10,
              color: Color.fromRGBO(31, 31, 31, 1),
              child: Container(
                height: 80,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.data()['imdb'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    "IMDb".text.make().pOnly(top: 5)
                  ],
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.green, width: 1)),
              elevation: 10,
              color: Color.fromRGBO(31, 31, 31, 1),
              child: Container(
                height: 80,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.data()['seasons'].toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    "Seasons".text.make().pOnly(top: 5)
                  ],
                ),
              ),
            )
          ],
        ).pOnly(top: 25),
        Center(
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.blue)),
            elevation: 10,
            color: Color.fromRGBO(31, 31, 31, 1),
            child: Container(
              width: context.mq.size.width - 50,
              child: Column(
                children: [
                  "Plot"
                      .text
                      .textStyle(Theme.of(context).textTheme.headline6)
                      .color(Colors.blue)
                      .center
                      .bold
                      .make()
                      .pOnly(top: 10),
                  Text(
                    data.data()['plot'],
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16),
                  ).p16()
                ],
              ),
            ),
          ).pOnly(top: 20),
        ),
        "Seasons"
            .text
            .textStyle(Theme.of(context).textTheme.headline6)
            .bold
            .make()
            .pOnly(left: 20, top: 20),
        ListView(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: [
            ListView.builder(
              itemCount: data.data()['seasons'],
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // Ads.showInterstitialAd();
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => EpisodeList(
                      title: ('Season' +
                          " - " +
                          (((index + 1) < 10)
                              ? "0" + (index + 1).toString()
                              : (index + 1).toString())),
                      data: data.data()[('Season ' +
                          (((index + 1) < 10)
                              ? "0" + (index + 1).toString()
                              : (index + 1).toString()))],
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
                      title: ('Season' +
                              " - " +
                              (((index + 1) < 10)
                                  ? "0" + (index + 1).toString()
                                  : (index + 1).toString()))
                          .text
                          .make(),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ),
            ),
            (data.data().containsKey("Ova"))
                ? GestureDetector(
                    onTap: () {
                      // Ads.showInterstitialAd();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EpisodeList(
                          title: "Ova",
                          data: data.data()['Ova'],
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
                          title: "Ova".text.make(),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  )
                : Container(),
            (data.data().containsKey("Movies"))
                ? GestureDetector(
                    onTap: () {
                      // Ads.showInterstitialAd();
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EpisodeList(
                          title: "Movies",
                          data: data.data()['Movies'],
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
                          title: "Movies".text.make(),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ).pOnly(left: 15, right: 15, top: 10, bottom: 20),
      ]).scrollVertical(),
    );
  }
}
