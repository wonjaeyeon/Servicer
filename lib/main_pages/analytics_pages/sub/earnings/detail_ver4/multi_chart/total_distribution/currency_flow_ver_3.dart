import 'package:flutter/material.dart';

class CurrencyFlowChartV3 extends StatefulWidget {
  const CurrencyFlowChartV3({super.key});

  @override
  State<CurrencyFlowChartV3> createState() => _CurrencyFlowChartV3State();
}

class _CurrencyFlowChartV3State extends State<CurrencyFlowChartV3> {
  @override
  Widget build(BuildContext context) {
    double unityWidth = MediaQuery.of(context).size.width / 7;
    double unityHeight = 40;
    // 2 unity = two rows or columns merge
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text("매출 분포"),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: unityWidth * 2,
                          margin: EdgeInsets.zero,
                          height: unityHeight,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0XFFBCBCBC)),
                              color: Color(0xFFEEEEEE)),
                          child: Center(
                            child: Text('Category'),
                          ),
                        ),
                        Container(
                          width: unityWidth,
                          margin: EdgeInsets.zero,
                          height: unityHeight,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0XFFBCBCBC)),
                              color: Color(0xFFEEEEEE)),
                          child: Center(
                            child: Text('Other'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: unityWidth * 2,
                          margin: EdgeInsets.zero,
                          height: unityHeight * 2,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0XFFBCBCBC)),
                              color: Color(0xFFFFFFFF)),
                          child: Center(
                            child: Text('1888'),
                          ),
                        ),
                        Container(
                          width: unityWidth,
                          margin: EdgeInsets.zero,
                          height: unityHeight * 2,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0XFFBCBCBC)),
                              color: Color(0xFFFFFFFF)),
                          child: Center(
                            child: Text('20%'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: unityWidth * 2,
                          margin: EdgeInsets.zero,
                          height: unityHeight,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0XFFBCBCBC)),
                              color: Color(0xFFEEEEEE)),
                          child: Center(
                            child: Text('Items'),
                          ),
                        ),
                        Container(
                          width: unityWidth,
                          margin: EdgeInsets.zero,
                          height: unityHeight,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0XFFBCBCBC)),
                              color: Color(0xFFEEEEEE)),
                          child: Center(
                            child: Text('Percent'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: unityWidth * 2,
                          margin: EdgeInsets.zero,
                          height: unityHeight,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0XFFBCBCBC)),
                              color: Color(0xFFFFFFFF)),
                          child: Center(
                            child: Text('Items 1'),
                          ),
                        ),
                        Container(
                          width: unityWidth,
                          margin: EdgeInsets.zero,
                          height: unityHeight,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0XFFBCBCBC)),
                              color: Color(0xFFFFFFFF)),
                          child: Center(
                            child: Text('20%'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: unityWidth * 2,
                          margin: EdgeInsets.zero,
                          height: unityHeight,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0XFFBCBCBC)),
                              color: Color(0xFFFFFFFF)),
                          child: Center(
                            child: Text('Items 2'),
                          ),
                        ),
                        Container(
                          width: unityWidth,
                          margin: EdgeInsets.zero,
                          height: unityHeight,
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0XFFBCBCBC)),
                              color: Color(0xFFFFFFFF)),
                          child: Center(
                            child: Text('50%'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
