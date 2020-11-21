import 'package:firebase_admob/firebase_admob.dart';

class Ads {
  static BannerAd myBanner;

  static void showAd() {
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['wallpaper'],
      childDirected: false,
      testDevices: <String>[],
    );
    myBanner = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.banner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
    myBanner
      ..load()
      ..show(
        anchorOffset: 60.0,
        horizontalCenterOffset: 10.0,
        anchorType: AnchorType.bottom,
      );
  }

  static void disposeAd() {
    myBanner?.dispose();
  }
}
