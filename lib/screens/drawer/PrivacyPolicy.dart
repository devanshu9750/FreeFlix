import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Privacy Policy".text.make(),
      ),
      body:
          "If you want any content that is provided in our app to be removed then kindly mail us at freeflixdev@gmail.com. That is if you find your content in our app and you have copyright to that content then kindly email us and we will have it removed as soon as possible."
              .text
              .justify
              .textStyle(Theme.of(context).textTheme.headline6)
              .make()
              .p(15),
    );
  }
}
