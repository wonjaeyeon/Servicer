import 'package:flutter/material.dart';
import 'package:servicer/main_pages/connect_pages/sub/unused/main_page_ver1.dart';
import '../../../MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import '../c_data_handler/name_switch_for_icon.dart';

double $cardMenuElevation = 25;
RoundedRectangleBorder $cardMenuShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0));
EdgeInsets $cardMenuVerticalMargin =
    const EdgeInsets.symmetric(horizontal: 0, vertical: 8);
EdgeInsets $cardMenuContainerMargin = const EdgeInsets.all(16);

class ConnectedMall extends StatefulWidget {
  ConnectedMall({super.key});
  List<String> items = [
    '지그재그',
    '스마트스토어',
    '룩핀',
    '11번가',
    '쿠팡',
    '에이블리',
    '브랜디',
    '더보기'
  ];

  @override
  State<ConnectedMall> createState() => _ConnectedMallState();
}

class _ConnectedMallState extends State<ConnectedMall> with IconSwitcher {
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: widget.items.map((index) {
        return Row(
          children: [
            Card(
              elevation: $cardMenuElevation - 20, // card elevation = 25
              shape: $cardMenuShape,
              margin: $cardMenuContainerMargin / 2.8,
              child: SizedBox(
                width: 120,
                height: 120,
                child: BHTouchFXInkWell(
                    onTap: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(index),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    child: iconSwitcher(index),
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                                Text('등록일: 2021.04.10'),
                                Text('연동시작일: 2021.10.10'),
                                Text('연동종료일: 2023.10.10'),
                                Text('연동상태: 연동중'),
                              ],
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('연동해지'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'OK'),
                                child: const Text('취소'),
                              ),
                            ],
                          ),
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                          ),
                          flex: 2,
                        ),
                        Expanded(
                            flex: 8,
                            child: SizedBox(
                              child: iconSwitcher(index),
                              width: 75,
                              height: 75,
                            )),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 1,
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                                child: Text(
                                  index,
                                  softWrap: true,
                                ))),
                        Expanded(
                          flex: 2,
                          child: Container(
                            height: 1,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 0))
          ],
        );
      }).toList(),
    );
  }
}
