import 'package:flutter/material.dart';

class TabBarComponents {
  static List<TabBar> tabBarComponents = [
    TabBar(
      tabs: [
        Tab(
          text: "Hollywood",
        ),
        Tab(
          text: "Bollywood",
        ),
      ],
    ),
    null,
    TabBar(
      tabs: [
        Tab(
          text: "Subbed",
        ),
        Tab(
          text: "Dubbed",
        ),
        Tab(
          text: "Movies",
        ),
      ],
    )
  ];
}
