import 'package:FreeFlix/component/MainBody.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Anime extends StatelessWidget {
  TabController controller;
  Anime({this.controller});
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: [
        MainBody(
          collection: "anime",
          type: 0,
        ),
        Container(),
        Container()
      ],
    );
  }
}

// ignore: must_be_immutable
class Series extends StatelessWidget {
  TabController controller;
  Series({this.controller});
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: [
        MainBody(
          collection: "series",
          type: 0,
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class Movies extends StatelessWidget {
  TabController controller;
  Movies({this.controller});
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: [
        MainBody(
          collection: "movies",
          type: 1,
        ),
        MainBody(
          collection: "movies",
          type: 0,
        )
      ],
    );
  }
}
