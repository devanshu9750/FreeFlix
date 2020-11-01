import 'package:flutter/material.dart';

class MovieComponent extends StatefulWidget {
  final bool type;
  MovieComponent({this.type});

  @override
  _MovieComponentState createState() => _MovieComponentState();
}

class _MovieComponentState extends State<MovieComponent> {
  Map data;
  bool _loading = true;
  getData() async {}

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return (_loading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container();
  }
}
