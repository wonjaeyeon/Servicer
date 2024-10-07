import 'package:flutter/material.dart';

enum ShoppingMall {
  coupang,
  naverSmartStore,
  elevenStreet,
  gMarket,
  lookpin,
}

Color getColorFromShoppingMall(ShoppingMall mall) {
  switch (mall) {
    case ShoppingMall.coupang:
      return Colors.red;
    case ShoppingMall.naverSmartStore:
      return Colors.lightGreen;
    case ShoppingMall.elevenStreet:
      return Colors.orange;
    case ShoppingMall.gMarket:
      return Colors.greenAccent;
    case ShoppingMall.lookpin:
      return Colors.indigo;
    default:
      return Colors.black;
  }
}

String getNameFromShoppingMall(ShoppingMall mall) {
  switch (mall) {
    case ShoppingMall.coupang:
      return '쿠팡';
    case ShoppingMall.naverSmartStore:
      return '네이버 스마트스토어';
    case ShoppingMall.elevenStreet:
      return '11번가';
    case ShoppingMall.gMarket:
      return '지마켓';
    case ShoppingMall.lookpin:
      return '룩핀';
    default:
      return '알 수 없음';
  }
}
