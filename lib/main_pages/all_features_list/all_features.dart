import 'package:flutter/material.dart';
import 'package:servicer/MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import 'package:servicer/MOD_PACKAGES/servicer_neumorphism/servicerNeu.dart';
import 'package:servicer/design_standards/my_font_icons.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/main_pages/settings_pages/settings_main_page.dart';

class AllFeatures extends StatefulWidget {
  AllFeatures({Key? key}) : super(key: key);

  @override
  State<AllFeatures> createState() => _AllFeaturesState();
}

class _AllFeaturesState extends State<AllFeatures> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(color: Colors.black, fontSize: $mediumFontSize),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        // hide back button
        automaticallyImplyLeading: false,
        title: const Text('전체 기능'),
        actions: [
          BHTouchEffectWrapper(
            $clickedColor: Colors.transparent,
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
              },
              // hide ripple effect
              splashColor: Colors.transparent,
              icon: const Icon(MyFont.cog_1, size: 18, color: Colors.grey),
            ),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 10),
              // Text('최근 사용 기능', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              // // 최근 사용한 기능들을 3개까지 보여준다.
              const SizedBox(height: 10),

              Text('유용한 셀러 정보', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              BHTouchFXListTile(
                //$clickedColor: Colors.pink,
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.account_balance_wallet),
                title: Text('혜택 좋은 사업자용 계좌 만들기'),
                trailing: Text(''),
                onTap: () {},
              ),
              BHTouchFXListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.account_balance_wallet),
                title: Text('개인사업자에게 혜택 좋은 카드 만들기'),
                trailing: Text(''),
                onTap: () {},
              ),
              const SizedBox(height: 10),
              Text('매출 및 회계', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              BHTouchFXListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.account_balance_wallet),
                title: Text('매출 및 지출 직접 추가하기'),
                trailing: Text(''),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
