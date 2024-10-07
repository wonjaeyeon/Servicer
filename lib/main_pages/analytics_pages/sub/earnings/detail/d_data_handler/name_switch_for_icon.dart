import 'package:flutter/material.dart';

import '../../../../../../servicer_modules/shopping_mall_master.dart';

mixin IconSwitcher {
  dynamic iconSwitcher(String name) {
    switch (name) {
      case '지그재그':
        return mallMaster.smallImgOf(Mall.Zigzag);
      case '룩핀':
        return mallMaster.smallImgOf(Mall.Lookpin);
      case '네이버 스마트스토어':
        return mallMaster.smallImgOf(Mall.NaverSmartStore);
      case '스마트 스토어':
        return mallMaster.smallImgOf(Mall.NaverSmartStore);
      case '11번가':
        return mallMaster.smallImgOf(Mall.ElevenStreet);
      case '옥션':
        return mallMaster.smallImgOf(Mall.Auction);
      case 'G마켓':
        return mallMaster.smallImgOf(Mall.Gmarket);
      case '위메프':
        return mallMaster.smallImgOf(Mall.Wemakeprice);
      case '쿠팡':
        return mallMaster.smallImgOf(Mall.Coupang);
      case '텐바이텐':
        return mallMaster.smallImgOf(Mall.TenByTen);
      case '티몬':
        return mallMaster.smallImgOf(Mall.Tmon);
      case '에이블리':
        return mallMaster.smallImgOf(Mall.Ably);
      case '브랜디':
        return mallMaster.smallImgOf(Mall.Brandi);
      case '하이버':
        return mallMaster.smallImgOf(Mall.Hiver);
      case '카카오쇼핑':
        return mallMaster.smallImgOf(Mall.KakaoShopping);
      default:
        return Icon(Icons.shopping_cart);
    }
  }
}
