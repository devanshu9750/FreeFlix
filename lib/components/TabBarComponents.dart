import 'package:flutter/material.dart';

class TabBarComponents {
  static List<TabBar> tabBarComponents = [
    TabBar(
      tabs: [
        Tab(
          text: "Bollywood",
        ),
        Tab(
          text: "Hollywood",
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
