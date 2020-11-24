import 'package:firebase_admob/firebase_admob.dart';

class Ads {
  static BannerAd myBanner;

  static void showBannerAd() {
    myBanner = BannerAd(
        adUnitId: "ca-app-pub-1508391904647076/5158206189",
        size: AdSize.banner,
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
        anchorOffset: 60.0,
        anchorType: AnchorType.bottom,
      );
  }

  static void disposeBannerAd() {
    try {
      myBanner.dispose();
    } catch (e) {}
  }

  static Future<void> showInterstitialAd() async {
    InterstitialAd myInterstitial = InterstitialAd(
      adUnitId: "ca-app-pub-1508391904647076/3021576558",
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );
    await myInterstitial.load();
    await myInterstitial.show();
  }
}
