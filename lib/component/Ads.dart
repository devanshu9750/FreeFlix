import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';

class Ads {
  static BannerAd myBanner = BannerAd(
      adUnitId: "ca-app-pub-1508391904647076/5158206189",
      size: AdSize.banner,
      targetingInfo: MobileAdTargetingInfo(
        childDirected: false,
        testDevices: <String>[],
      ),
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      });

  static bool flag = true;

  static void showBannerAd() async {
    if ((await FirebaseFirestore.instance
            .collection("flags")
            .doc("banner")
            .get())
        .data()['value']) {
      myBanner
        ..load()
        ..show(
          anchorOffset: 55.0,
          anchorType: AnchorType.bottom,
        );
    }
  }

  static void disposeBannerAd() async {
    if ((await FirebaseFirestore.instance
            .collection("flags")
            .doc("banner")
            .get())
        .data()['value']) {
      if (flag) {
        Timer.periodic(Duration(milliseconds: 500), (timer) async {
          bool check = await myBanner.isLoaded();
          if (check) {
            myBanner.dispose().then((value) {
              if (value == true) {
                timer.cancel();
                flag = false;
              }
            });
          }
        });
      }
    }
  }

  static void showInterstitialAd() async {
    InterstitialAd myInterstitial = InterstitialAd(
      adUnitId: "ca-app-pub-1508391904647076/3021576558",
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
    myInterstitial
      ..load()
      ..show();
  }
}
