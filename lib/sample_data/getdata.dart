/**
 * NOTE 이 테스트 코드는 서버에서 데이터를 일정 딜레이 이후에 받아오는 시뮬레이션을 위한 것이다.
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//* 이 아래에 사용할 데이터들을 선언한다.
Map<String, double> shoppingMallExampleData = {
  'kakaoStyle': 7,
  'naverSmartStore': 16,
  'zigzag': 14,
  'hiver': 17,
  'ably': 12,
  'coupang': 20,
  'lookpin': 11,
  'brandi': 9,
};

//* 이 함수의 인자로 문자 코드를 넣어 일정 로딩 시간 뒤 데이터를 future로 보내준다.
Future<Map<String, double>> simulateGetData(data_code) async {
  await Future.delayed(Duration(seconds: 1));
  switch (data_code) {
    case 'mainBarChart':
      return shoppingMallExampleData;
    default:
      return {};
  }
}
