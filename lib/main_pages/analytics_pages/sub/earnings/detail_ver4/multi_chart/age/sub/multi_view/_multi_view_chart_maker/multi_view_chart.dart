import 'package:flutter/material.dart';

import '../../../../../../../../../../data_handler/data_standards/category.dart';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../../../../design_standards/widget_styles.dart';
import 'view_chart_selector.dart';

class AgeMultiViewChart extends StatefulWidget {
  const AgeMultiViewChart({super.key});

  @override
  State<AgeMultiViewChart> createState() => _AgeMultiViewChartState();
}

class _AgeMultiViewChartState extends State<AgeMultiViewChart>
    with ViewChartSelector {
  final List<bool> _isSelectedViewType = [
    true,
    false,
    false,
    false,
  ];
  late ViewType viewType;
  bool _visible = true;

  @override
  void initState() {
    viewType = ViewType.treemap;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double _verticalPadding = 15;
    final double _horizontalPadding = 15;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: $AnalyticsPageHorizontalPadding,
                    child: Text(
                      "구성",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: $mediumFontSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    //physics: const AlwaysScrollableScrollPhysics(),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        ToggleButtons(
                          splashColor: Colors.transparent,
                          renderBorder: false,
                          constraints: const BoxConstraints(
                            minHeight: 15,
                            minWidth: 66,
                            maxHeight: 60,
                            maxWidth: 120,
                          ),
                          color: $$Grey,
                          fillColor: Colors.transparent,
                          selectedColor: Colors.white,
                          isSelected: _isSelectedViewType,
                          onPressed: (int newIndex) async {
                            _visible = false;

                            setState(() {
                              for (int i = 0;
                                  i < _isSelectedViewType.length;
                                  i++) {
                                if (i == newIndex) {
                                  _isSelectedViewType[i] = true;
                                } else {
                                  _isSelectedViewType[i] = false;
                                  switch (newIndex) {
                                    case 0:
                                      viewType = ViewType.treemap;
                                      //data = widget.profitData;
                                      break;
                                    case 1:
                                      viewType = ViewType.trend;
                                      //data = widget.mallData;
                                      break;
                                    case 2:
                                      viewType = ViewType.calendar;
                                      //data = widget.priceData;
                                      break;
                                    case 3:
                                      viewType = ViewType.table;
                                      //data = widget.profitData;
                                      break;
                                  }
                                }
                              }
                            });
                          },
                          children: [
                            Ink(
                                width: 80,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: _isSelectedViewType[0]
                                      ? $$mediumGrey
                                      : $$lightGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '상세 분포',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: $smallFontSize,
                                    ),
                                  ),
                                )),
                            Ink(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                  //set the background color of the button when it is selected/ not selected
                                  color: _isSelectedViewType[1]
                                      ? $$mediumGrey
                                      : $$lightGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '추세',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: $smallFontSize,
                                    ),
                                  ),
                                )),
                            Ink(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: _isSelectedViewType[2]
                                      ? $$mediumGrey
                                      : $$lightGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '달력별',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: $smallFontSize,
                                    ),
                                  ),
                                )),
                            Ink(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                  //set the background color of the button when it is selected/ not selected
                                  color: _isSelectedViewType[3]
                                      ? $$mediumGrey
                                      : $$lightGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    '소비자',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: $smallFontSize,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: _visible
                    ? const Duration(milliseconds: 400)
                    : const Duration(milliseconds: 0),
                onEnd: () async => {
                  await Future.delayed(const Duration(milliseconds: 400)),
                  setState(() {
                    _visible = true;
                  })
                },
                child: Container(
                  alignment: Alignment.center,
                  child: showMultiViewChart(
                      viewType, MediaQuery.of(context).size.width * 0.7),
                ),
              ),
              // TimeClicker(
              //   isSelectedTime: _isSelectedTime,
              //   callbackFunction: callbackFunction,
              // ),
              //AnalysisChartAnalysis(timeRange: getTimeRange(time), unit: "원")
            ],
          ),
        ],
      ),
    );
  }
}
