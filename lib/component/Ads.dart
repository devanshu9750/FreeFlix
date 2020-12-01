import 'package:firebase_admob/firebase_admob.dart';

class Ads {
  static BannerAd myBanner;

  static void showBannerAd() {
    myBanner = BannerAd(
        adUnitId: "ca-app-pub-1508391904647076/5158206189",
        size: AdSize.fullBanner,
        targetingInfo: MobileAdTargetingInfo(
          childDirected: false,
          testDevices: <String>[],
        ),
        listener: (MobileAdEvent event) {
          print("BannerAd event is $event");
        });

    myBanner
      ..load()
      ..show(
        anchorOffset: 55.0,
        anchorType: AnchorType.bottom,
      );
  }

  static void disposeBannerAd() async {
    bool check = await myBanner.isLoaded();
    if (check) {
      myBanner.dispose();
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
