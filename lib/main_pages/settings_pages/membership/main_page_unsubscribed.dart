import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:servicer/main_pages/settings_pages/membership/sub/pages/manage_or_compare_memberships.dart';

import '../../../design_standards/text_styles.dart';

class MembershipMainPageUnsucscribed extends StatefulWidget {
  MembershipMainPageUnsucscribed({Key? key}) : super(key: key);

  @override
  State<MembershipMainPageUnsucscribed> createState() => _MembershipMainPageUnsucscribedState();
}

class _MembershipMainPageUnsucscribedState extends State<MembershipMainPageUnsucscribed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 10),
        bottom: true,
        child: Container(
          child: ElevatedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Text('멤버십 시작하기!', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManageMembershipPage(),
                ),
              );
            },
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('멤버십 시작하기'),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: $mediumFontSize,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
              stops: [0.0, 0.01, 0.98, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text('서비서와 함께'),
                      Text('새로운 셀러 라이프를 즐겨보세요!', style: TextStyle(fontSize: 28)),
                      Text('현재 체험판 요금제를 사용하고 계세요. ', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 20),
                      Text('멤버십을 구독하여 다양한 혜택을 누리세요.'),
                      SizedBox(height: 20),
                      // Internet image
                      Image.network(
                          'https://media.istockphoto.com/vectors/online-merchants-are-happy-that-the-sales-of-online-products-sell-vector-id1185906444?k=20&m=1185906444&s=612x612&w=0&h=rJYoJVaYYS0qSpaiVeknOcm1VmSvAistqlD7dw3r12A='),
                      SizedBox(height: 40),
                      //  blue text
                      Text('서비서 멤버십을 구독하면 받게 되는 혜택들', style: TextStyle(color: Colors.indigo)),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        // rounded border and background color
                        decoration: BoxDecoration(
                          color: Colors.indigo[50],
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.indigo[100]!),
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.shopify),
                              title: Text('더 많은 쇼핑몰 연동'),
                              subtitle: Text('5개부터 30개까지 요금제에 따라 늘릴 수 있어요.'),
                            ),
                            ListTile(
                              leading: Icon(Icons.timer),
                              title: Text('더 빠른 주기로 쇼핑몰 데이터 동기화'),
                              subtitle: Text('구독 요금제에 따라 동기화 주기를 올릴 수 있어요.'),
                            ),
                            ListTile(
                              leading: Icon(Icons.analytics),
                              title: Text('추가/심화 분석 기능'),
                              subtitle: Text('더욱 자세한 분석 기준, 1대1 쇼핑몰 분석,\n키워드 분석 기능을 이용할 수 있어요.'),
                            ),
                            ListTile(
                              leading: Icon(Icons.token),
                              title: Text('서비서 툴박스'),
                              subtitle: Text('셀러들에게 유용한 각종 계산기 등의 도구를 \n이용할 수 있어요.'),
                            ),
                            ListTile(
                              leading: Icon(Icons.devices),
                              title: Text('더 많은 기기에서 동시 이용'),
                              subtitle: Text('현재 1대의 기기에서만 사용할 수 있어요.'),
                            ),
                            ListTile(
                              leading: Icon(Icons.discount),
                              title: Text('서비서 유료 서비스 할인 혜택'),
                              subtitle: Text('구독 요금제에 따라 할인율이 올라가요.'),
                            ),
                            ListTile(
                              leading: Icon(Icons.support_agent),
                              title: Text('회원 전용 문의/지원 채널'),
                              subtitle: Text('회원 전용 이메일 및 카카오톡 지원 서비스를 제공받아요.'),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('아래 버튼을 누르면 나에게 꼭 필요한 멤버십을 찾아드릴게요.'),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
