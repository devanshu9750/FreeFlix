import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class PlayVideo extends StatefulWidget {
  final String id;
  PlayVideo({this.id});
  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  bool _loading = true;
  String url;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    url = "https://drive.google.com/file/d/" + widget.id + "/view?usp=sharing";
  }

  @override
  void dispose() {
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
        builder: (context) => SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                InAppWebView(
                  initialOptions: InAppWebViewGroupOptions(
                      crossPlatform:
                          InAppWebViewOptions(useOnDownloadStart: true)),
                  initialUrl: url,
                  onDownloadStart: (controller, url) async {
                    Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                      "Download is not available !!",
                    )));
                  },
                  onLoadStop: (controller, url) {
                    setState(() {
                      _loading = false;
                    });
                  },
                ),
                (_loading)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Stack()
              ],
            )),
      ),
    );
  }
}
