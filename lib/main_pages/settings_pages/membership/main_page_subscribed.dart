import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_extensions/flutter_extensions.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:servicer/main_pages/settings_pages/membership/sub/pages/manage_or_compare_memberships.dart';
import 'package:servicer/main_pages/settings_pages/membership/sub/pages/manage_payments.dart';
import 'package:servicer/main_pages/settings_pages/membership/sub/pages/membership_detailed_info.dart';
import 'package:servicer/main_pages/settings_pages/settings_main_page.dart';

import '../../../design_standards/text_styles.dart';
import 'sub/logics/membership_features.dart';

class MembershipMainPageSubscribed extends StatefulWidget {
  const MembershipMainPageSubscribed({Key? key}) : super(key: key);

  @override
  MembershipMainPageSubscribedState createState() => MembershipMainPageSubscribedState();
}

class MembershipMainPageSubscribedState extends State<MembershipMainPageSubscribed> {
  double pi = 3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679;
  double x = 0;
  double y = 0;
  double z = 0;
  Offset _offset = Offset.zero;
  Offset _offsetOld = Offset.zero;
  double _gestureX = 0;
  double _gestureY = 0;
  double _gyroX = 0;
  double _gyroY = 0;
  double _gyroRawX = 0;
  double _gyroRawY = 0;
  double _gyroRawZ = 0;

  int memberShipLevel = membershipLevel.toInt();

  StreamSubscription<GyroscopeEvent>? __ge;

  @override
  void initState() {
    super.initState();
    __ge = gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        _gyroRawX = event.x;
        _gyroRawY = event.y;
        _gyroRawZ = event.z;
        _gyroX += _gyroRawY * -0.005;
        _gyroY += _gyroRawX * 0.005;
        //print('$_gyroX, $_gyroY');
      });
    });
  }

  @override
  void dispose() {
    __ge?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _rbSize = 4;
    final double _rbOpacity = 0.15;

    return Scaffold(
      body: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple, Colors.transparent, Colors.transparent, Colors.purple],
            stops: [0.0, 0.01, 0.98, 1.0], // 10% purple, 80% transparent, 10% purple
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: SafeArea(
          child: CustomScrollView(
            physics: ScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: const Text('멤버십'),
                backgroundColor: context.theme().scaffoldBackgroundColor,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: $mediumFontSize,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                centerTitle: true,
                snap: true,
                floating: true,
                elevation: 0,
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: AspectRatio(
                              aspectRatio: 1.586,
                              child: TweenAnimationBuilder(
                                curve: Curves.easeOut,
                                duration: Duration(milliseconds: 600),
                                tween: OffsetTween(begin: _offsetOld, end: _offset),
                                builder: (BuildContext context, Offset value, Widget? child) {
                                  double effectiveGyroX = (_gyroX.abs() <= 1) ? _gyroX : _gyroX.sign;
                                  double effectiveGyroY = (_gyroY.abs() <= 1) ? _gyroY : _gyroY.sign;

                                  return Transform(
                                    // Transform widget
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, 0.001) // perspective
                                      ..rotateX(0.001 * value.dy - effectiveGyroY * -0.003) // changed
                                      ..rotateY(-0.001 * value.dx - effectiveGyroX * 0.004), // changed
                                    alignment: FractionalOffset.center,
                                    child: GestureDetector(
                                      onPanUpdate: (details) {
                                        setState(() {
                                          (value.dx.abs() < 180) ? _gestureX += details.delta.dx : _gestureX = 0;
                                          (value.dy.abs() < 90) ? _gestureY += details.delta.dy : _gestureY = 0;
                                          //print('$_gestureX, $_gestureY');
                                          value = Offset(_gestureX * 0.04 * (180 - value.dx.abs()),
                                              _gestureY * 0.03 * (90 - value.dy.abs()));
                                          //print('onPanUpdate, ${value.dx}, ${value.dy}');
                                        });
                                        _offset = value;
                                        _offsetOld = _offset;
                                      },
                                      onPanEnd: (details) async {
                                        //await Future.delayed(Duration(seconds: 1));
                                        setState(() {
                                          _gestureX = 0;
                                          _gestureY = 0;
                                          _offsetOld = _offset;
                                          _offset = Offset.zero;
                                        });
                                        //print('onPanEnd, $_offsetOld, $_offset');
                                      },
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          MembershipCard(),
                                          //! light reflection effect
                                          Container(
                                            decoration: BoxDecoration(
                                              backgroundBlendMode: BlendMode.plus,
                                              borderRadius: BorderRadius.circular(10),
                                              gradient: RadialGradient(
                                                center: Alignment(value.dx * -0.01 - _gyroX * 4, value.dy * -0.01 - _gyroY * 4),
                                                radius: 2,
                                                colors: [
                                                  //Colors.blue,
                                                  Colors.white.withOpacity(0.13),
                                                  Colors.transparent,
                                                ],
                                              ),
                                            ),
                                          ),
                                          //! radial rainbow effect
                                          Container(
                                            // make reflection effect
                                            decoration: BoxDecoration(
                                              backgroundBlendMode: BlendMode.lighten,
                                              borderRadius: BorderRadius.circular(10),
                                              gradient: SweepGradient(
                                                tileMode: TileMode.repeated,
                                                colors: [
                                                  // rainbow
                                                  Colors.transparent,
                                                  Colors.red.withOpacity(_rbOpacity),
                                                  Colors.orange.withOpacity(_rbOpacity),
                                                  Colors.yellow.withOpacity(_rbOpacity),
                                                  Colors.green.withOpacity(_rbOpacity),
                                                  Colors.blue.withOpacity(_rbOpacity),
                                                  Colors.indigo.withOpacity(_rbOpacity),
                                                  Colors.purple.withOpacity(_rbOpacity),
                                                ],
                                                startAngle: 0,
                                                endAngle: pi,
                                                transform:
                                                    GradientRotation((value.dx * value.dy) * 0.00007 + (_gyroX * _gyroY) * 35),
                                                center: Alignment.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(25),
                        // make rounded border
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.indigo.withOpacity(0.1)),
                        ),
                        child: Column(
                          children: [
                            Text('지금까지 받은 혜택', style: TextStyle(fontSize: $mediumFontSize)),
                            const SizedBox(height: 10),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Text('확인한 리포트'), Text('128 개')]),
                            const SizedBox(height: 10),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Text('앱 접속'), Text('321 회')]),
                            const SizedBox(height: 10),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Text('분석 기능 이용'), Text('73 회')]),
                            const SizedBox(height: 10),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [Text('유용했던 서비서 솔루션'), Text('19 개')]),
                            const SizedBox(height: 10),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [Text('좋아요'), Text('12 개')]),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text('이등병 등급인 회원님의 모든 혜택', style: TextStyle(fontSize: $mediumFontSize)),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: MembershipFeatures().constructUI(memberShipLevel),
                    ),
                    const SizedBox(height: 30),
                    Divider(height: 0),
                    ListTile(
                      title: Text('멤버십 비교/변경하기'),
                      //trailing: Icon(Icons.arrow_forward_ios, size: 15),
                      tileColor: Colors.grey.withOpacity(0.1),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ManageMembershipPage()));
                      },
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: Text('멤버십에 대한 자세한 정보'),
                      //trailing: Icon(Icons.arrow_forward_ios, size: 15),
                      tileColor: Colors.grey.withOpacity(0.1),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MembershipInfoPage()));
                      },
                    ),
                    Divider(height: 0),
                    ListTile(
                      title: Text('결제 수단 변경하기'),
                      tileColor: Colors.grey.withOpacity(0.1),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ManagePaymentPage()));
                      },
                    ),

                    //SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MembershipCard extends StatelessWidget {
  const MembershipCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color cardColor = Color.fromARGB(255, 255, 193, 60);
    Color cardFontColor = Colors.black;

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: cardColor,
        boxShadow: [
          // shine effect
          BoxShadow(
            color: cardColor.withOpacity(0.65),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('멤버십 카드'),
            SizedBox(height: 4),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: FittedBox(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            width: 1.0,
                            height: 1.0,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill, image: NetworkImage("https://picsum.photos/250?image=9"))),
                          ),
                          Container(
                              width: 0.4,
                              height: 0.4,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black, width: 0.009),
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: AssetImage('assets/icons/memberships/level1.png')))),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 2,
                    child: FittedBox(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('등급: 이등병', style: TextStyle(fontSize: 16, color: cardFontColor)),
                            Text('사업자명: 가나다라마바사', style: TextStyle(fontSize: 16, color: cardFontColor)),
                            Text('업종: 전자기기', style: TextStyle(fontSize: 16, color: cardFontColor)),
                            Text('멤버십 취득일 2022.04.25 ~ \n(+158일)', style: TextStyle(fontSize: 16, color: cardFontColor)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4),
            Text('서비서'),
          ],
        ),
      ),
    );
  }
}
