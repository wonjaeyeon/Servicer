import 'package:flutter/material.dart';

Widget? getSmallBanner(String key) {
  try {
    return Image.asset('assets/banner_small/$key.png');
  } catch (e) {
    return null;
  }
}

Widget? getSmallBannerWithSize(String key, double? width, double? height, bool showBox) {
  try {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Container(
        color: showBox ? Colors.amber : Colors.transparent,
        width: width,
        height: height,
        child: Image.asset('assets/banner_small/$key.png'),
      ),
    );
  } catch (e) {
    return null;
  }
}
