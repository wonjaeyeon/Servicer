import 'package:flutter/material.dart';

class MembershipFeatures {
  Widget constructUI(int level) {
    // put sizedbox among the boxes
    List<Widget> boxList = generateBoxListWithMembershipLevel(level);
    List<Widget> finalList = [];
    boxList.forEach((element) {
      finalList.add(element);
      finalList.add(SizedBox(height: 10));
    });
    return Column(
      children: finalList,
    );
  }

  List<Widget> generateBoxListWithMembershipLevel(int level) {
    List<Widget> boxList = [];
    switch (level) {
      case 1: // 맛보기
        boxList.addAll(<Container>[
          generateBox('최대 2개 쇼핑몰 연동 가능', '서비서에서만 볼 수 있는 자세한 통계와 \n고급 분석 기능을 사용할 수 있는', 1),
          generateBox('일 1회, 고정 시간(매일 오후 8시)', '쇼핑몰 데이터가 서비서 앱과 동기화되는 빈도', 1),
          generateBox('고급 분석 기능', '자세한 주문과 매출 현황, 쇼핑몰별 분석과 기타 정보 \n및 일일/주간 리포트를 받아볼 수 있는', 1),
          generateBox('서비서 뉴스', '중요한 소식, 쇼핑몰 관련 소식 등 \n셀러들을 위한 뉴스를 누구보다 빨리 전달해 드리는', 1),
          generateBox('서비서 베이직 솔루션', '정교한 빅데이터 분석을 통해 회원님만을 위한 솔루션을 \n제한적으로 받아 볼 수 있는 ', 1),
          generateBox('서비서 베이직 툴박스', '각종 날짜와 금액 계산기 등, 운영에 도움이 되는 \n각종 도구를 제한적으로 사용할 수 있는', 1),
          generateBox('최대 1대', '이 모든 서비서 앱의 기능들을 동시에 이용할 수 있는 기기', 1),
        ]);
        break;
      case 2: // 이등병
        boxList.addAll(<Container>[
          generateBox('최대 5개 쇼핑몰 연동 가능', '서비서에서만 볼 수 있는 자세한 통계와 \n고급 분석 기능을 사용할 수 있는', 2),
          generateBox('일 1회, 원하는 시간', '쇼핑몰 데이터가 서비서 앱과 동기화되는 빈도', 2),
          generateBox('고급 분석 기능', '자세한 주문과 매출 현황, 쇼핑몰별 분석과 기타 정보 \n및 회원님만을 위한 리포트를 받아볼 수 있는', 1),
          generateBox('서비서 뉴스', '중요한 소식, 쇼핑몰 관련 소식 등 \n셀러들을 위한 뉴스를 누구보다 빨리 전달해 드리는', 1),
          generateBox('서비서 솔루션', '정교한 빅데이터 분석을 통해 \n회원님만을 위한 솔루션을 받아 볼 수 있는 ', 2),
          generateBox('서비서 툴박스', '셀러들에게 필요한 각종 날짜와 금액 계산기 등, \n 운영에 도움이 되는 각종 도구를 대부분 사용할 수 있는', 2),
          generateBox('3% 할인', '서비서의 모든 유료 기능 결제액의', 2),
          generateBox('회원 전용 이메일 및 카카오톡 문의 라인', '서비서 이용중 궁금한 점이 있거나, 도움이 필요할 때 \n24시간 이내에 답변을 받을 수 있는', 2),
          generateBox('최대 1대', '이 모든 서비서 앱의 기능들을 동시에 이용할 수 있는 기기', 1),
        ]);
        break;

      case 3: // 일병
        boxList.addAll(<Container>[
          generateBox('최대 10개 쇼핑몰 연동 가능', '서비서에서만 볼 수 있는 자세한 통계와 \n고급 및 Pro 분석 기능을 사용할 수 있는', 3),
          generateBox('일 3회, 원하는 시간', '쇼핑몰 데이터가 서비서 앱과 동기화되는 빈도', 3),
          generateBox('고급 분석 기능', '자세한 주문과 매출 현황, 쇼핑몰별 분석과 기타 정보 \n및 회원님만을 위한 리포트를 받아볼 수 있는', 1),
          generateBox('Pro 분석 기능', '더욱 자세한 분석 기준이 제공되며, 상세한 1대1 쇼핑몰 비교 분석 등 \n최대한 자세한 분석을 원하는 회원님들을 위한', 3),
          generateBox('서비서 뉴스', '중요한 소식, 쇼핑몰 관련 소식 등 \n셀러들을 위한 뉴스를 누구보다 빨리 전달해 드리는', 1),
          generateBox('서비서 솔루션', '정교한 빅데이터 분석을 통해 \n회원님만을 위한 솔루션을 받아 볼 수 있는 ', 2),
          generateBox('서비서 툴박스', '셀러들에게 필요한 각종 날짜와 금액 계산기 등, \n운영에 도움이 되는 각종 도구를 대부분 사용할 수 있는', 2),
          generateBox('5% 할인', '서비서의 모든 유료 기능 결제액의', 3),
          generateBox('회원 전용 이메일 및 카카오톡 문의 라인', '서비서 이용중 궁금한 점이 있거나, 도움이 필요할 때 \n24시간 이내에 답변을 받을 수 있는', 2),
          generateBox('최대 2대', '이 모든 서비서 앱의 기능들을 동시에 이용할 수 있는 기기', 3),
        ]);

        break;
      case 4: // 상병
        boxList.addAll(<Container>[
          generateBox('최대 30개 쇼핑몰 연동 가능', '서비서에서만 볼 수 있는 자세한 통계와 \n고급 및 Pro 분석 기능을 사용할 수 있는', 4),
          generateBox('일 5회, 원하는 시간', '쇼핑몰 데이터가 서비서 앱과 동기화되는 빈도', 4),
          generateBox('고급 분석 기능', '자세한 주문과 매출 현황, 쇼핑몰별 분석과 기타 정보 \n및 회원님만을 위한 리포트를 받아볼 수 있는', 1),
          generateBox('Pro 분석 기능', '더욱 자세한 분석 기준이 제공되며, 상세한 1대1 쇼핑몰 비교 분석 등 \n최대한 자세한 분석을 원하는 회원님들을 위한', 3),
          generateBox('서비서 뉴스', '중요한 소식, 쇼핑몰 관련 소식 등 \n셀러들을 위한 뉴스를 누구보다 빨리 전달해 드리는', 1),
          generateBox('서비서 Pro 솔루션', '정교한 빅데이터 분석을 통해 \n회원님만을 위한 솔루션을 제한 없이 받아 볼 수 있는 ', 4),
          generateBox('서비서 Pro 툴박스', '셀러들에게 필요한 각종 날짜와 금액 계산기 등, \n 운영에 도움이 되는 각종 도구를 모두 사용할 수 있는', 4),
          generateBox('7% 할인', '서비서의 모든 유료 기능 결제액의', 4),
          generateBox('회원 전용 이메일 및 카카오톡 문의 라인', '서비서 이용중 궁금한 점이 있거나, 도움이 필요할 때 \n우선 순위로 답변을 받을 수 있는', 4),
          generateBox('서비서 1대1 전화 문의 라인', '긴급한 문의가 있을 때 \n빠르고 정확한 답변을 받을 수 있는', 4),
          generateBox('최대 5대', '이 모든 서비서 앱의 기능들을 동시에 이용할 수 있는 기기', 4),
        ]);

        break;
      case 5: // 병장
        boxList.addAll(<Container>[
          generateBox('무제한 쇼핑몰 연동 가능', '서비서에서만 볼 수 있는 자세한 통계와 \n고급 및 Pro 분석 기능을 사용할 수 있는', 5),
          generateBox('일 10회, 원하는 시간', '쇼핑몰 데이터가 서비서 앱과 동기화되는 빈도', 5),
          generateBox('고급 분석 기능', '자세한 주문과 매출 현황, 쇼핑몰별 분석과 기타 정보 \n및 회원님만을 위한 리포트를 받아볼 수 있는', 1),
          generateBox('Pro 분석 기능', '더욱 자세한 분석 기준이 제공되며, 상세한 1대1 쇼핑몰 비교 분석 등 \n최대한 자세한 분석을 원하는 회원님들을 위한', 3),
          generateBox('서비서 뉴스', '중요한 소식, 쇼핑몰 관련 소식 등 \n셀러들을 위한 뉴스를 누구보다 빨리 전달해 드리는', 1),
          generateBox('서비서 Pro 솔루션', '정교한 빅데이터 분석을 통해 \n회원님만을 위한 솔루션을 제한 없이 받아 볼 수 있는', 4),
          generateBox('서비서 Pro 툴박스', '셀러들에게 필요한 각종 날짜와 금액 계산기 등, \n 운영에 도움이 되는 각종 도구를 모두 사용할 수 있고 \n새로 추가된 도구를 먼저 써 볼 수 있는', 4),
          generateBox('회원 전용 이메일 및 카카오톡 문의 라인', '서비서 이용중 궁금한 점이 있거나, 도움이 필요할 때 \n최고 우선 순위로 답변을 받을 수 있는', 5),
          generateBox('10% 할인', '서비서의 모든 유료 기능 결제액의', 5),
          generateBox('서비서 1대1 전화 문의 라인', '긴급한 문의가 있을 때 \n가장 빠르고 정확한 답변을 받을 수 있는', 5),
          generateBox('최대 10대', '이 모든 서비서 앱의 기능들을 동시에 이용할 수 있는 기기', 5),
          generateBox('특별 뱃지 및 닉네임 표시', '병장 등급인 회원님들만 제공되며, \n다른 서비서 이용자에게도 보이는', 5),
        ]);

        break;
      default:
        break;
    }
    return boxList;
  }

  Container generateBox(String feature, String description, int level) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.indigo),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              height: 50,
              child: Image.asset('assets/icons/memberships/level${level}.png'),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(description, textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                  Text(feature, style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
