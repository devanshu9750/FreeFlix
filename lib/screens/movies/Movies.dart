import 'package:FreeFlix/components/MovieComponent.dart';
import 'package:flutter/material.dart';

class Movies extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        MovieComponent(
          type: "hollywood",
        ),
        MovieComponent(
          type: "bollywood",
        )
      ],
    );
  }
}
