import 'package:flutter/material.dart';

enum Mall {
  ElevenStreet,
  NaverSmartStore,
  Auction,
  Coupang,
  TenByTen,
  Tmon,
  Gmarket,
  Wemakeprice,
  Ably,
  Brandi,
  Hiver,
  KakaoShopping,
  Lookpin,
  Zigzag,
}

/// TYPE OF IMAGES
///
/// 1. 아이콘: 소형 정사각형 [160x160]
///  - 사용되는 곳: 작은 아이콘, 인라인 쇼핑몰 이름 텍스트에 보조 용도로 사용. 이 이미지만으로는 쇼핑몰의 풀 네임이 확인되지 않을 것을 가정함. (즉, 쇼핑몰 풀네임 텍스트와 함께 사용되어야 함.)
///  - 특징: 배경색은 있는 것이 일반적이고, 로고의 소형화 버전이 있으면 그것을 사용함. (예: AUCTION의 소형화 버전은 A, ZIGZAG의 소형화 버전은 Z로 되어 있음.)
///  - 주의사항: 스마트폰 앱 로고와는 다름.
///
/// 2. 로고: 대형 정사각형 [400x400]
/// - 사용되는 곳: 큰 정사각형 로고, 이 이미지만으로 어떤 쇼핑몰인지 구체적으로 확인될 것을 권장하지만, 상/하단에 쇼핑몰 풀네임 텍스트와 함꼐 쓰일 수도 있음. 아이콘보다 큰 사이즈의 정사각형 이미지가 필요한 경우 사용.
/// - 특징: 배경색은 존재할 수도 없을 수도 있으며 이를 고려하여 사용해야 함. 긴 쇼핑몰의 풀 네임이 그대로 쓰이는 경우에도 가독성이 확보될 정도의 크기가 확보된 곳에 사용해야 함.
///
/// 3. 배너: 3:1 비율의 가로로 긴 사각형 [600x200]
/// - 사용되는 곳: 배너 이미지, 쇼핑몰의 풀 네임이 포함된 이미지가 필요한 경우 사용. 쇼핑몰 풀 네임 텍스트는 일반적으로 혼용되지 않음. 가로로 긴 사각형 이미지가 필요한 경우 사용.
/// - 특징: 일반적으로 배경 색은 없는 것이 권장되지만, 있는 경우에도 대응하도록 해야 함. 배너에 로고가 포함될 수도 있고 없을 수도 있음. 쇼핑몰들이 대외적으로 사용하는 구조를 따름.
///
/// 4. 컬러: 쇼핑몰마다 가진 테마 컬러.

class MallMaster {
  /// 1. 아이콘: 소형 정사각형 [160x160]
  ///  - 사용되는 곳: 작은 아이콘, 인라인 쇼핑몰 이름 텍스트에 보조 용도로 사용. 이 이미지만으로는 쇼핑몰의 풀 네임이 확인되지 않을 것을 가정함. (즉, 쇼핑몰 풀네임 텍스트와 함께 사용되어야 함.)
  ///  - 특징: 배경색은 있는 것이 일반적이고, 로고의 소형화 버전이 있으면 그것을 사용함. (예: AUCTION의 소형화 버전은 A, ZIGZAG의 소형화 버전은 Z로 되어 있음.)
  ///  - 주의사항: 스마트폰 앱 로고와는 다름.
  Image smallImgOf(Enum code) {
    return Image.asset(
        'assets/images/shopping_mall_master/${code.toString().split('.').last.replaceAll('.', '')}_Small.png');
  }

  /// 2. 로고: 대형 정사각형 [400x400]
  /// - 사용되는 곳: 큰 정사각형 로고, 이 이미지만으로 어떤 쇼핑몰인지 구체적으로 확인될 것을 권장하지만, 상/하단에 쇼핑몰 풀네임 텍스트와 함꼐 쓰일 수도 있음. 아이콘보다 큰 사이즈의 정사각형 이미지가 필요한 경우 사용.
  /// - 특징: 배경색은 존재할 수도 없을 수도 있으며 이를 고려하여 사용해야 함. 긴 쇼핑몰의 풀 네임이 그대로 쓰이는 경우에도 가독성이 확보될 정도의 크기가 확보된 곳에 사용해야 함.
  Image bigImgOf(Enum code) {
    return Image.asset(
        'assets/images/shopping_mall_master/${code.toString().split('.').last.replaceAll('.', '')}_Big.png');
  }

  /// 3. 배너: 3:1 비율의 가로로 긴 사각형 [600x200]
  /// - 사용되는 곳: 배너 이미지, 쇼핑몰의 풀 네임이 포함된 이미지가 필요한 경우 사용. 쇼핑몰 풀 네임 텍스트는 일반적으로 혼용되지 않음. 가로로 긴 사각형 이미지가 필요한 경우 사용.
  /// - 특징: 일반적으로 배경 색은 없는 것이 권장되지만, 있는 경우에도 대응하도록 해야 함. 배너에 로고가 포함될 수도 있고 없을 수도 있음. 쇼핑몰들이 대외적으로 사용하는 구조를 따름.
  Image longImgOf(Enum code) {
    return Image.asset(
        'assets/images/shopping_mall_master/${code.toString().split('.').last.replaceAll('.', '')}_Long.png');
  }

  /// 4. 컬러: 쇼핑몰마다 가진 테마 컬러.
  Color themeColorOf(Enum code) {
    switch (code) {
      case Mall.ElevenStreet:
        return Color(0xFFFF0038);
      case Mall.NaverSmartStore:
        return Color(0xFF5DAE52);
      case Mall.Auction:
        return Color(0xFFC83639);
      case Mall.Coupang:
        return Color(0xFFE5E2C28);
      case Mall.TenByTen:
        return Color(0xFFCD0719);
      case Mall.Tmon:
        return Color(0xFFFF5000);
      case Mall.Gmarket:
        return Color(0xFF00C01E);
      case Mall.Wemakeprice:
        return Color(0xFFD42A1E);
      case Mall.Ably:
        return Color.fromARGB(255, 50, 50, 50);
      case Mall.Brandi:
        return Color.fromARGB(255, 50, 50, 50);
      case Mall.Hiver:
        return Color(0xFFCC9C61);
      case Mall.KakaoShopping:
        return Color(0xFFF9E100);
      case Mall.Lookpin:
        return Color(0xFF071345);
      case Mall.Zigzag:
        return Color(0xFFFA6EE3);
      default:
        return Colors.white;
    }
  }

  String textOf(Enum code) {
    switch (code) {
      case Mall.ElevenStreet:
        return '11번가';
      case Mall.NaverSmartStore:
        return '네이버 스마트스토어';
      case Mall.Auction:
        return '옥션';
      case Mall.Coupang:
        return '쿠팡';
      case Mall.TenByTen:
        return '텐바이텐';
      case Mall.Tmon:
        return '티몬';
      case Mall.Gmarket:
        return '지마켓';
      case Mall.Wemakeprice:
        return '위메프';
      case Mall.Ably:
        return '에이블리';
      case Mall.Brandi:
        return '브랜디';
      case Mall.Hiver:
        return '하이버';
      case Mall.KakaoShopping:
        return '카카오쇼핑';
      case Mall.Lookpin:
        return '룩핀';
      case Mall.Zigzag:
        return '지그재그';
      default:
        return '';
    }
  }

  Mall mallOf(String mallName) {
    switch (mallName) {
      case 'ElevenStreet':
        return Mall.ElevenStreet;
      case '11번가':
        return Mall.ElevenStreet;
      case 'NaverSmartStore':
        return Mall.NaverSmartStore;
      case '스마트스토어':
        return Mall.NaverSmartStore;
      case 'SmartStore':
        return Mall.NaverSmartStore;
      case 'Auction':
        return Mall.Auction;
      case '옥션':
        return Mall.Auction;
      case 'Coupang':
        return Mall.Coupang;
      case '쿠팡':
        return Mall.Coupang;

      case 'TenByTen':
        return Mall.TenByTen;
      case '텐바이텐':
        return Mall.TenByTen;
      case 'Tmon':
        return Mall.Tmon;
      case '티몬':
        return Mall.Tmon;
      case 'Gmarket':
        return Mall.Gmarket;
      case '지마켓':
        return Mall.Gmarket;
      case 'Wemakeprice':
        return Mall.Wemakeprice;
      case '위메프':
        return Mall.Wemakeprice;
      case 'Ably':
        return Mall.Ably;
      case '에이블리':
        return Mall.Ably;
      case 'Brandi':
        return Mall.Brandi;
      case '브랜디':
        return Mall.Brandi;
      case 'Hiver':
        return Mall.Hiver;
      case '하이버':
        return Mall.Hiver;
      case 'KakaoShopping':
        return Mall.KakaoShopping;
      case '카카오쇼핑':
        return Mall.KakaoShopping;
      case 'Lookpin':
        return Mall.Lookpin;
      case '룩핀':
        return Mall.Lookpin;
      case 'Zigzag':
        return Mall.Zigzag;
      case '지그재그':
        return Mall.Zigzag;
      default:
        return Mall.ElevenStreet;
    }
  }
}

final mallMaster = MallMaster();
