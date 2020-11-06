import 'package:FreeFlix/components/AnimeComponent.dart';
import 'package:flutter/material.dart';

class Anime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        AnimeComponent(
          type: 1,
        ),
        AnimeComponent(
          type: 0,
        ),
        Container()
      ],
    );
  }
}
