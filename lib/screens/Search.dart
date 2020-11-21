import 'package:FreeFlix/data/SearchData.dart';
import 'package:FreeFlix/screens/detail/MDetailPage.dart';
import 'package:FreeFlix/screens/detail/SDetailPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../component/Ads.dart';

class Search extends SearchDelegate {
  @override
  TextStyle get searchFieldStyle => TextStyle(color: Colors.grey);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return super
        .appBarTheme(context)
        .copyWith(primaryColor: Color.fromRGBO(31, 31, 31, 1));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<QueryDocumentSnapshot> data = [];
    if (SearchData.data != null && query != "") {
      SearchData.data.docs.forEach((document) {
        if (document.id.toLowerCase().contains(query.toLowerCase())) {
          data.add(document);
        }
      });
    }
    return VStack(data
            .map((document) => GestureDetector(
                  onTap: () {
                    Ads.disposeAd();
                    if (document.data().containsKey("seasons")) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => SDetailPage(
                          data: document,
                        ),
                      ));
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => MDetailPage(
                          data: document,
                        ),
                      ));
                    }
                  },
                  child: Container(
                    child: Card(
                      color: Colors.black45,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.white)),
                      child: ListTile(
                        title: document.id.text.make(),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                ))
            .toList())
        .scrollVertical();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<QueryDocumentSnapshot> data = [];
    if ((SearchData.data != null) &&
        (SearchData.data.size != 0) &&
        (query != "")) {
      SearchData.data.docs.forEach((document) {
        if (document.id.toLowerCase().contains(query.toLowerCase())) {
          data.add(document);
        }
      });
    }
    return VStack(data
            .map((document) => GestureDetector(
                  onTap: () {
                    Ads.disposeAd();
                    if (document.data().containsKey("seasons")) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => SDetailPage(
                          data: document,
                        ),
                      ));
                    } else {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => MDetailPage(
                          data: document,
                        ),
                      ));
                    }
                  },
                  child: Container(
                    child: Card(
                      color: Colors.black45,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.white)),
                      child: ListTile(
                        title: document.id.text.make(),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ),
                  ),
                ))
            .toList())
        .scrollVertical();
  }
}
