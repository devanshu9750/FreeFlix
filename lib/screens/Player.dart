import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:velocity_x/velocity_x.dart';

class Player extends StatefulWidget {
  final String id;
  Player({this.id});

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: [
            InAppWebView(
              initialUrl:
                  "https://drive.google.com/file/d/" + widget.id + "/preview",
            ),
            Positioned(
                right: 5,
                top: 5,
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(color: Colors.black),
                  child: Icon(Icons.clear),
                ).onTap(() {
                  Navigator.of(context).pop();
                })),
          ],
        ),
      ),
    );
  }
}
