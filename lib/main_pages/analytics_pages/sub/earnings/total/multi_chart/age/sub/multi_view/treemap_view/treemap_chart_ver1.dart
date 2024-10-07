import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';

/// Treemap import.
import 'package:syncfusion_flutter_treemap/treemap.dart';

import '../../../../../../../../../../servicer_modules/shopping_mall_master.dart';
import '../../../a_data_handler/y_axis_unit.dart';

class TreemapViewChartContainerV2 extends StatefulWidget {
  const TreemapViewChartContainerV2({super.key});

  @override
  State<TreemapViewChartContainerV2> createState() =>
      _TreemapViewChartContainerV2State();
}

class _TreemapViewChartContainerV2State
    extends State<TreemapViewChartContainerV2> with AChartYAxisUnit {
  late List<_StateElectionDetails> _stateWiseElectionResult;
  late List<TreemapColorMapper> _colorMappers;
  late bool _isLightTheme;
  late bool isDesktop;

  @override
  void initState() {
    // Data source to the treemap.
    //
    // [totalVoters] is used to get each tile's weight.
    // [state] is the flat level grouping key.
    _stateWiseElectionResult = getChartData();

    _colorMappers = <TreemapColorMapper>[
      const TreemapColorMapper.range(
          from: 0, to: 5, color: Color(0xFFe8f5e9), name: '{0%},{}'),
      const TreemapColorMapper.range(
          from: 5, to: 10, color: Color(0xFFc8e6c9), name: ''),
      const TreemapColorMapper.range(
          from: 10, to: 20, color: Color(0xFFa5d6a7), name: ''),
      const TreemapColorMapper.range(
          from: 20, to: 30, color: Color(0xFF81c784), name: '25%'),
      const TreemapColorMapper.range(
          from: 30, to: 40, color: Color(0xFF66bb6a), name: ''),
      const TreemapColorMapper.range(
          from: 40, to: 50, color: Color(0xFF4caf50), name: ''),
      const TreemapColorMapper.range(
          from: 50, to: 60, color: Color(0xFF43a047), name: ''),
      const TreemapColorMapper.range(
          from: 60, to: 70, color: Color(0xFf388e3c), name: '75%'),
      const TreemapColorMapper.range(
          from: 70, to: 80, color: Color(0xFF2e7d32), name: ''),
      const TreemapColorMapper.range(
          from: 80, to: 90, color: Color(0xFF1b5e20), name: ''),
      const TreemapColorMapper.range(
          from: 90, to: 95, color: Color.fromARGB(255, 18, 77, 22), name: ''),
      const TreemapColorMapper.range(
          from: 95,
          to: 100,
          color: Color.fromARGB(255, 9, 51, 12),
          name: '100%'),
    ];

    super.initState();
  }

  @override
  void dispose() {
    _stateWiseElectionResult.clear();
    _colorMappers.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    _isLightTheme = themeData.colorScheme.brightness == Brightness.light;
    isDesktop = themeData.platform == TargetPlatform.windows;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final Size size = Size(constraints.maxWidth, constraints.maxHeight);
      return Center(
        child: Padding(
          padding: MediaQuery.of(context).orientation == Orientation.portrait ||
                  isDesktop
              ? const EdgeInsets.all(12.5)
              : const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Text(
                    '연령백분위',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: AspectRatio(
                  aspectRatio: 0.8,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(
                        0, 0, 0, 0), //*그래프 컨테이너 바깥쪽 간격
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: SfTreemap(
                      // The number of data in your data source collection.
                      //
                      // The callback for the [weightValueMapper] and
                      // [TreemapLevel.groupMapper] will be called
                      // the number of times equal to the [dataCount].
                      dataCount: _stateWiseElectionResult.length,
                      // The value returned in the callback will specify the
                      // weight of each tile.
                      weightValueMapper: (int index) {
                        return _stateWiseElectionResult[index].totalEarnings;
                      },
                      tooltipSettings: TreemapTooltipSettings(
                        color: _isLightTheme
                            ? const Color.fromRGBO(45, 45, 45, 1)
                            : const Color.fromRGBO(242, 242, 242, 1),
                      ),
                      colorMappers: _colorMappers,
                      levels: _getTreemapLevels(themeData),
                      legend: TreemapLegend.bar(
                        segmentSize: isDesktop
                            ? const Size(25, 12)
                            : Size((size.width * 0.80) / _colorMappers.length,
                                12.0),
                        spacing: 0.0,
                        textStyle: const TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  List<TreemapLevel> _getTreemapLevels(ThemeData themeData) {
    return <TreemapLevel>[
      TreemapLevel(
        color: Colors.transparent,
        // Used for grouping the tiles based on the value returned from
        // this callback.
        //
        // Once grouped, we will get [labelBuilder], [tooltipBuilder],
        // [colorValueMapper], and [itemBuilder] callbacks respectively.
        groupMapper: (int index) => _stateWiseElectionResult[index].mall,
        // Padding around the tile.
        padding: const EdgeInsets.all(2.0),
        // Returns a widget for each tile's data label.
        labelBuilder: (BuildContext context, TreemapTile tile) {
          final Mall groupMall = mallMaster.mallOf(tile.group);
          final Brightness brightness =
              ThemeData.estimateBrightnessForColor(tile.color);
          final Color color =
              brightness == Brightness.dark ? Colors.white : Colors.black;
          return ColoredBox(
              color: mallMaster.themeColorOf(groupMall),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 4.0, top: 2.0, bottom: 2.0),
                  child: Text(
                    tile.group,
                    style:
                        themeData.textTheme.bodyMedium!.copyWith(color: color),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ));
        },
        // Returns a widget for each tile's tooltip.
        tooltipBuilder: (BuildContext context, TreemapTile tile) {
          return Padding(
            padding: EdgeInsets.zero,
            child: Text(
              '${tile.group}' '\nMedals : ${tile.weight.round()}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
      TreemapLevel(
        color: Colors.red,
        // Used for grouping the tiles based on the value returned from
        // this callback.
        //
        // Once grouped, we will get [labelBuilder], [tooltipBuilder], and
        // [colorValueMapper] callbacks respectively.
        groupMapper: (int index) =>
            "${getValueUnit(_stateWiseElectionResult[index].totalEarnings)}원",
        // The value returned in the callback will specify the
        // color of each tile.
        colorValueMapper: (TreemapTile tile) {
          // if (_stateWiseElectionResult[tile.indices[0]].candidate ==
          //     'Hillary Clinton') {
          //   return _stateWiseElectionResult[tile.indices[0]].percentage;
          // } else {
          //   return -_stateWiseElectionResult[tile.indices[0]].percentage!;
          // }
          return _stateWiseElectionResult[tile.indices[0]].agePercentage;
        },
        // Returns a widget for each tile's data label.
        labelBuilder: (BuildContext context, TreemapTile tile) {
          final Brightness brightness =
              ThemeData.estimateBrightnessForColor(tile.color);
          final Color color =
              brightness == Brightness.dark ? Colors.white : Colors.black;
          return Padding(
            padding: const EdgeInsets.only(left: 4.0, top: 4.0),
            child: Text(
              tile.group,
              style: themeData.textTheme.bodySmall!.copyWith(
                fontSize: 11,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          );
        },
        // Returns a widget for each tile's tooltip.
        tooltipBuilder: (BuildContext context, TreemapTile tile) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
              text: TextSpan(
                text: _stateWiseElectionResult[tile.indices[0]].mall,
                style: themeData.textTheme.bodySmall!.copyWith(
                  height: 1.5,
                  color: _isLightTheme
                      ? const Color.fromRGBO(255, 255, 255, 1)
                      : const Color.fromRGBO(10, 10, 10, 1),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '\n매출 기간 : ${_stateWiseElectionResult[tile.indices[0]].timeRange}',
                    style: themeData.textTheme.bodySmall!.copyWith(
                      color: _isLightTheme
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(10, 10, 10, 1),
                    ),
                  ),
                  TextSpan(
                      text: '\n매출량 :' +
                          getValueUnit(_stateWiseElectionResult[tile.indices[0]]
                              .totalEarnings) +
                          "원",
                      style: themeData.textTheme.bodySmall!.copyWith(
                        color: _isLightTheme
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(10, 10, 10, 1),
                      )),
                  TextSpan(
                    text: '\n연령 : ' +
                        getValueUnit(_stateWiseElectionResult[tile.indices[0]]
                            .age!
                            .toDouble()) +
                        "세",
                    style: themeData.textTheme.bodySmall!.copyWith(
                      color: _isLightTheme
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(10, 10, 10, 1),
                    ),
                  ),
                  TextSpan(
                    text: '\n판매건 : ' +
                        getValueUnit(_stateWiseElectionResult[tile.indices[0]]
                            .order!
                            .toDouble()) +
                        "건",
                    style: themeData.textTheme.bodySmall!.copyWith(
                      color: _isLightTheme
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(10, 10, 10, 1),
                    ),
                  ),
                  TextSpan(
                    text: '\n평균상품가 : ' +
                        getValueUnit(
                            _stateWiseElectionResult[tile.indices[0]].price!) +
                        "원",
                    style: themeData.textTheme.bodySmall!.copyWith(
                      color: _isLightTheme
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(10, 10, 10, 1),
                    ),
                  ),
                  TextSpan(
                    text:
                        '\n연령 백분위 : ${_stateWiseElectionResult[tile.indices[0]].agePercentage}%',
                    style: themeData.textTheme.bodySmall!.copyWith(
                      color: _isLightTheme
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(10, 10, 10, 1),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ];
  }

  List<_StateElectionDetails> getChartData() {
    return <_StateElectionDetails>[
      const _StateElectionDetails(
          mall: "SmartStore",
          timeRange: '2022.12.21~2022.12.22',
          age: 22,
          totalEarnings: 712900,
          order: 100,
          price: 7000,
          agePercentage: 12.54),
      const _StateElectionDetails(
          mall: "SmartStore",
          timeRange: '2022.12.21~2022.12.22',
          age: 22,
          totalEarnings: 100000 * 10,
          order: 10,
          price: 100000,
          agePercentage: 70.07),
      const _StateElectionDetails(
          mall: "SmartStore",
          timeRange: '2022.12.21~2022.12.22',
          age: 22,
          totalEarnings: 2123372,
          order: 100,
          price: 1318255,
          agePercentage: 62.08),
      const _StateElectionDetails(
          mall: "SmartStore",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 318608,
          order: 100,
          price: 163387,
          agePercentage: 51.28),
      const _StateElectionDetails(
          mall: "SmartStore",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 2604657,
          order: 100,
          price: 1252401,
          agePercentage: 48.08),
      const _StateElectionDetails(
          mall: "SmartStore",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 1130676,
          order: 100,
          price: 684872,
          agePercentage: 60.57),
      const _StateElectionDetails(
          mall: "SmartStore",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 14181595,
          order: 100,
          price: 8753788,
          agePercentage: 61.73),
      const _StateElectionDetails(
          mall: "SmartStore",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 2780247,
          order: 100,
          price: 1338870,
          agePercentage: 48.16),
      const _StateElectionDetails(
          mall: "SmartStore",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 1644920,
          order: 100,
          price: 897572,
          agePercentage: 54.57),
      const _StateElectionDetails(
          mall: "SmartStore",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 443814,
          order: 100,
          price: 235603,
          agePercentage: 53.09),
      const _StateElectionDetails(
          mall: "SmartStore",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 9420039,
          order: 100,
          price: 4617886,
          agePercentage: 49.02),
      const _StateElectionDetails(
          mall: "SmartStore",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 4114732,
          order: 100,
          price: 2089104,
          agePercentage: 50.77),
      const _StateElectionDetails(
          mall: "SmartStore",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 428937,
          order: 100,
          price: 266891,
          agePercentage: 62.22),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 690255,
          order: 100,
          price: 409055,
          agePercentage: 59.26),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 5536424,
          order: 100,
          price: 3090729,
          agePercentage: 55.83),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 2734958,
          order: 100,
          price: 1557286,
          agePercentage: 56.82),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 1566031,
          order: 100,
          price: 800983,
          agePercentage: 51.15),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 1184402,
          order: 100,
          price: 671018,
          agePercentage: 56.65),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 1924149,
          order: 100,
          price: 1202971,
          agePercentage: 62.52),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 2029032,
          order: 100,
          price: 1178638,
          agePercentage: 58.09),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 747927,
          order: 100,
          price: 357735,
          agePercentage: 47.83),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 2781446,
          order: 100,
          price: 1677928,
          agePercentage: 60.33),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 3325046,
          order: 100,
          price: 1995196,
          agePercentage: 60.01),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 4799284,
          order: 100,
          price: 2279543,
          agePercentage: 47.50),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 2944813,
          order: 100,
          price: 1367716,
          agePercentage: 46.44),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 1209357,
          order: 100,
          price: 700714,
          agePercentage: 57.86),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 2808605,
          order: 100,
          price: 1594511,
          agePercentage: 56.77),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 497147,
          order: 100,
          price: 279240,
          agePercentage: 56.17),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 844227,
          order: 100,
          price: 495961,
          agePercentage: 58.75),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 1125385,
          order: 100,
          price: 539260,
          agePercentage: 47.92),
      const _StateElectionDetails(
          mall: "Zigzag",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 744296,
          order: 100,
          price: 348526,
          agePercentage: 46.98),
      const _StateElectionDetails(
          mall: "Ably",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 3874046,
          order: 100,
          price: 2148278,
          agePercentage: 55.45),
      const _StateElectionDetails(
          mall: "Ably",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 798319,
          order: 100,
          price: 385234,
          agePercentage: 48.26),
      const _StateElectionDetails(
          mall: "Ably",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 7721453,
          order: 100,
          price: 4556124,
          agePercentage: 59.01),
      const _StateElectionDetails(
          mall: "Ably",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 4741564,
          order: 100,
          price: 2362631,
          agePercentage: 49.83),
      const _StateElectionDetails(
          mall: "Ably",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 344360,
          order: 100,
          price: 216794,
          agePercentage: 62.96),
      const _StateElectionDetails(
          mall: "Ably",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 5496487,
          order: 100,
          price: 2841005,
          agePercentage: 51.69),
      const _StateElectionDetails(
          mall: "Ably",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 1452992,
          order: 100,
          price: 949136,
          agePercentage: 65.32),
      const _StateElectionDetails(
          mall: "Ably",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 6165478,
          order: 100,
          price: 2970733,
          agePercentage: 48.18),
      const _StateElectionDetails(
          mall: "Ably",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 464144,
          order: 100,
          price: 252525,
          agePercentage: 54.41),
      const _StateElectionDetails(
          mall: "Ably",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 2103027,
          order: 100,
          price: 1155389,
          agePercentage: 54.94),
      const _StateElectionDetails(
          mall: "Ably",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 370093,
          order: 100,
          price: 227721,
          agePercentage: 61.53),
      const _StateElectionDetails(
          mall: "Ably",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 2508027,
          order: 100,
          price: 1522925,
          agePercentage: 60.72),
      const _StateElectionDetails(
          mall: "Coupang",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 8969226,
          order: 100,
          price: 4685047,
          agePercentage: 52.23),
      const _StateElectionDetails(
          mall: "Coupang",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 1131430,
          order: 100,
          price: 515231,
          agePercentage: 45.54),
      const _StateElectionDetails(
          mall: "Coupang",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 315067,
          order: 100,
          price: 178573,
          agePercentage: 56.68),
      const _StateElectionDetails(
          mall: "Coupang",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 3984631,
          order: 100,
          price: 1981473,
          agePercentage: 49.73),
      const _StateElectionDetails(
          mall: "Coupang",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 714423,
          order: 100,
          price: 489371,
          agePercentage: 68.50),
      const _StateElectionDetails(
          mall: "Coupang",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 2976150,
          order: 100,
          price: 1405284,
          agePercentage: 47.22),
      const _StateElectionDetails(
          mall: "Coupang",
          timeRange: '2023.01.21~2023.01.22',
          age: 25,
          totalEarnings: 255849,
          order: 100,
          price: 174419,
          agePercentage: 95.17),
    ];
  }
}

class _StateElectionDetails {
  const _StateElectionDetails(
      {required this.totalEarnings,
      this.mall,
      this.timeRange,
      this.age,
      this.price,
      this.order,
      this.agePercentage});

  final String? mall;
  final double totalEarnings;
  final int? order;
  final String? timeRange;
  final int? age;
  final double? price;

  final double? agePercentage;
}
