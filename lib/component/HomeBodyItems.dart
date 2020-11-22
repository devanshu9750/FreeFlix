import 'package:FreeFlix/component/MainBody.dart';
import 'package:flutter/material.dart';

class Anime extends StatelessWidget {
  final TabController controller;
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
        MainBody(
          collection: "anime",
          type: 1,
        ),
        MainBody(
          collection: "anime",
          type: 2,
        )
      ],
    );
  }
}

class Series extends StatelessWidget {
  final TabController controller;
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

class Movies extends StatelessWidget {
  final TabController controller;
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
