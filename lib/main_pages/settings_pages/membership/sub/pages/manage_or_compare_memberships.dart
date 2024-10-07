import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ManageMembershipPage extends StatefulWidget {
  ManageMembershipPage({Key? key}) : super(key: key);

  @override
  State<ManageMembershipPage> createState() => _ManageMembershipPageState();
}

class _ManageMembershipPageState extends State<ManageMembershipPage> {
  List<Widget> tableValues(List<String> text) {
    List<Widget> list = [];
    for (var element in text) {
      list.add(Text(element));
      list.add(const SizedBox(height: 20));
    }
    return list;
  }

  Widget _buildCell(String textInput, {Color bgColor = Colors.transparent, int cellWidth = 120}) => Container(
        alignment: Alignment.center,
        height: 70,
        width: cellWidth.toDouble(),
        child: Text(textInput),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: Colors.indigo.withOpacity(0.5), width: 0.5),
          borderRadius: BorderRadius.circular(0),
        ),
      );

  @override
  Widget build(BuildContext context) {
    double _verticalPadding = 15;
    double _verticalPaddingFixed = _verticalPadding + 0.4;
    return Scaffold(
      appBar: AppBar(
        title: Text('멤버십 관리'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _buildCell('멤버십', cellWidth: 150, bgColor: Colors.indigo.withOpacity(0.5)),
                  _buildCell('연동 가능 쇼핑몰 수', cellWidth: 150),
                  _buildCell('쇼핑몰과 동기화 주기', cellWidth: 150),
                  _buildCell('원하는 시간에 동기화', cellWidth: 150),
                  _buildCell('서비서 뉴스', cellWidth: 150),
                  _buildCell('서비서 솔루션', cellWidth: 150),
                  _buildCell('서비서 툴박스', cellWidth: 150),
                  _buildCell('유료 결제 할인', cellWidth: 150),
                  _buildCell('회원전용 문의 채널', cellWidth: 150),
                  _buildCell('이용 가능 기기 수', cellWidth: 150),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          _buildCell('서비서 체험판', bgColor: Colors.indigo.withOpacity(0.5)),
                          _buildCell('1'),
                          _buildCell('매일'),
                          _buildCell('O'),
                          _buildCell('O'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('1'),
                        ],
                      ),
                      Column(
                        children: [
                          _buildCell('이등병', bgColor: Colors.indigo.withOpacity(0.5)),
                          _buildCell('1'),
                          _buildCell('매일'),
                          _buildCell('O'),
                          _buildCell('O'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('1'),
                        ],
                      ),
                      Column(
                        children: [
                          _buildCell('일병', bgColor: Colors.indigo.withOpacity(0.5)),
                          _buildCell('1'),
                          _buildCell('매일'),
                          _buildCell('O'),
                          _buildCell('O'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('1'),
                        ],
                      ),
                      Column(
                        children: [
                          _buildCell('상병', bgColor: Colors.indigo.withOpacity(0.5)),
                          _buildCell('1'),
                          _buildCell('매일'),
                          _buildCell('O'),
                          _buildCell('O'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('1'),
                        ],
                      ),
                      Column(
                        children: [
                          _buildCell('병장', bgColor: Colors.indigo.withOpacity(0.5)),
                          _buildCell('1'),
                          _buildCell('매일'),
                          _buildCell('O'),
                          _buildCell('O'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('X'),
                          _buildCell('1'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
