import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';

/// Treemap import.
import 'package:syncfusion_flutter_treemap/treemap.dart';

import '../../../../../../../../../../servicer_modules/shopping_mall_master.dart';

class TreemapViewChartContainerV1 extends StatefulWidget {
  const TreemapViewChartContainerV1({super.key});

  @override
  State<TreemapViewChartContainerV1> createState() =>
      _TreemapViewChartContainerV1State();
}

class _TreemapViewChartContainerV1State
    extends State<TreemapViewChartContainerV1> {
  late TooltipBehavior _tooltipBehavior;
  //late AnimationController _opacityAnimationController;
  late bool _isLightTheme;
  // late Animation<double> _opacityAnimation;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    // Data source to the treemap.
    //
    // [medalCount] is used to get each tile's weight.
    // [country] is the first level grouping key.
    // [medal] is the second level grouping key.
    // [category] is the third level grouping key.

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    _isLightTheme = themeData.colorScheme.brightness == Brightness.light;
    final double _verticalPadding = 15;
    const double horizontalPadding = 15;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: AspectRatio(
          aspectRatio: 0.8,
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0), //*그래프 컨테이너 바깥쪽 간격
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
              dataCount: getChartData().length,
              // The value returned in the callback will specify the
              // weight of each tile.
              weightValueMapper: (int index) {
                return getChartData()[index].earnings;
              },
              // enableDrilldown: true,
              // breadcrumbs: TreemapBreadcrumbs(
              //   builder:
              //       (BuildContext context, TreemapTile tile, bool isCurrent) {
              //     final String breadcrumbText =
              //         tile.group == 'Home' ? '입점몰' : tile.group;
              //     final Widget current = AnimatedDefaultTextStyle(
              //       style: Theme.of(context).textTheme.bodySmall!.copyWith(
              //           color: _isLightTheme
              //               ? const Color.fromRGBO(10, 10, 10, 1)
              //               : const Color.fromRGBO(255, 255, 255, 1),
              //           fontWeight: isCurrent && tile.group != 'Home'
              //               ? FontWeight.bold
              //               : FontWeight.normal),
              //       duration: const Duration(milliseconds: 500),
              //       child: Text(breadcrumbText),
              //     );

              //     if (tile.group == 'Home') {
              //       if (!isCurrent) {
              //         _opacityAnimationController.forward();
              //       } else {
              //         _opacityAnimationController.reverse();
              //       }

              //       return FadeTransition(
              //           opacity: _opacityAnimation, child: current);
              //     }

              //     return current;
              //   },
              // ),
              tooltipSettings: const TreemapTooltipSettings(
                color: Color.fromRGBO(57, 65, 9, 1.0),
                borderRadius: BorderRadius.all(
                  Radius.circular(2.0),
                ),
              ),
              levels: _getTreemapLevels(),
            ),
          ),
        ));
  }

  List<TreemapLevel> _getTreemapLevels() {
    final ThemeData themeData = Theme.of(context);
    return <TreemapLevel>[
      TreemapLevel(
        color: Colors.transparent,
        // Used for grouping the tiles based on the value returned from
        // this callback.
        //
        // Once grouped, we will get [labelBuilder], [tooltipBuilder],
        // [colorValueMapper], and [itemBuilder] callbacks respectively.
        groupMapper: (int index) => getChartData()[index].mall,
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
        groupMapper: (int index) => getChartData()[index].gender,
        padding: EdgeInsets.zero,
        colorValueMapper: (TreemapTile tile) {
          if (tile.group == 'man') {
            return Colors.blueAccent.withOpacity(0.5);
          } else if (tile.group == 'woman') {
            return Color.fromARGB(255, 255, 114, 161).withOpacity(0.5);
          } else {
            return $$lightGrey;
          }
        },
        // Returns a widget for each tile's content.
        itemBuilder: (BuildContext context, TreemapTile tile) {
          // return Center(
          //     child: Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: mallMaster.bigImgOf(Mall.NaverSmartStore)));
        },
      ),
      TreemapLevel(
        color: Colors.transparent,
        padding: EdgeInsets.zero,
        border: RoundedRectangleBorder(
          side: BorderSide(
              color: themeData.colorScheme.brightness == Brightness.light
                  ? const Color.fromRGBO(255, 255, 255, 1.0)
                  : const Color.fromRGBO(0, 0, 0, 1.0),
              width: 0.5),
        ),
        groupMapper: (int index) {
          return getChartData()[index].age;
        },
        tooltipBuilder: (BuildContext context, TreemapTile tile) {
          return _buildTooltip(tile);
        },
        labelBuilder: (BuildContext context, TreemapTile tile) {
          Color color;
          if (getChartData()[tile.indices[0]].gender == 'Bronze') {
            color = const Color.fromRGBO(255, 255, 255, 1.0);
          } else {
            color = const Color.fromRGBO(72, 72, 72, 1.0);
          }

          return Padding(
            padding: const EdgeInsets.only(left: 2.0, top: 2.0, bottom: 2.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                tile.group,
                style: themeData.textTheme.bodySmall!.copyWith(color: color),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    ];
  }

  Widget _buildTooltip(TreemapTile tile) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Transform.translate(
                offset: const Offset(-3, 0),
                child: Icon(
                  getChartData()[tile.indices[0]].icon,
                  color: Colors.white,
                  size: 15,
                ),
              ),
              const SizedBox(height: 5),
              Text(tile.group, style: const TextStyle(color: Colors.white)),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            getChartData()[tile.indices[0]].gender! +
                ' : ' +
                tile.weight.round().toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  List<GenderDistributionDetails> getChartData() {
    List<GenderDistributionDetails> chartData = [];
    chartData = <GenderDistributionDetails>[
      const GenderDistributionDetails(
          mall: 'SmartStore',
          gender: 'man',
          age: '~10대',
          earnings: 16,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'SmartStore',
          gender: 'man',
          age: '20대',
          earnings: 13,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'SmartStore',
          gender: 'man',
          age: '30대',
          earnings: 4,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'SmartStore',
          gender: 'man',
          age: '40대',
          earnings: 2,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'SmartStore',
          gender: 'man',
          age: '50대',
          earnings: 2,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'SmartStore',
          gender: 'man',
          age: '~60대',
          earnings: 2,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'SmartStore',
          gender: 'woman',
          age: '~10대',
          earnings: 8,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'SmartStore',
          gender: 'woman',
          age: '20대',
          earnings: 10,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'SmartStore',
          gender: 'woman',
          age: '30대',
          earnings: 6,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'SmartStore',
          gender: 'woman',
          age: '40대',
          earnings: 3,
          icon: Icons.woman),
      const GenderDistributionDetails(
        mall: 'SmartStore',
        gender: 'woman',
        age: '50대',
        earnings: 2,
        icon: Icons.woman,
      ),
      const GenderDistributionDetails(
        mall: 'SmartStore',
        gender: 'woman',
        age: '~60대',
        earnings: 2,
        icon: Icons.woman,
      ),
      const GenderDistributionDetails(
          mall: 'Zigzag',
          gender: 'man',
          age: '~10대',
          earnings: 6,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'Zigzag',
          gender: 'man',
          age: '20대',
          earnings: 2,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'Zigzag',
          gender: 'man',
          age: '30대',
          earnings: 2,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'Zigzag',
          gender: 'man',
          age: '40대',
          earnings: 3,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'Zigzag',
          gender: 'woman',
          age: '~10대',
          earnings: 5,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'Zigzag',
          gender: 'woman',
          age: '20대',
          earnings: 50,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'Zigzag',
          gender: 'woman',
          age: '30대',
          earnings: 20,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'Zigzag',
          gender: 'woman',
          age: '40대',
          earnings: 4,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'Coupang',
          gender: 'man',
          age: '~10대',
          earnings: 7,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'Coupang',
          gender: '확인 불가',
          age: '20대',
          earnings: 5,
          icon: Icons.question_mark),
      const GenderDistributionDetails(
          mall: 'Coupang',
          gender: '확인 불가',
          age: '30대',
          earnings: 2,
          icon: Icons.question_mark),
      const GenderDistributionDetails(
          mall: 'Coupang',
          gender: 'man',
          age: '20대',
          earnings: 4,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'Coupang',
          gender: 'man',
          age: '30대',
          earnings: 2,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'Coupang',
          gender: 'man',
          age: '40대',
          earnings: 1,
          icon: Icons.man),
      const GenderDistributionDetails(
        mall: 'Coupang',
        gender: 'woman',
        age: '~10대',
        earnings: 2,
        icon: Icons.woman,
      ),
      const GenderDistributionDetails(
          mall: 'Coupang',
          gender: 'woman',
          age: '20대',
          earnings: 2,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'Coupang',
          gender: 'woman',
          age: '30대',
          earnings: 2,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'Coupang',
          gender: 'woman',
          age: '40대',
          earnings: 2,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'Coupang',
          gender: 'woman',
          age: '50대',
          earnings: 1,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'Ably',
          gender: 'man',
          age: '~10대',
          earnings: 7,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'Ably',
          gender: 'man',
          age: '20대',
          earnings: 4,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'Ably',
          gender: 'man',
          age: '30대',
          earnings: 2,
          icon: Icons.man),
      const GenderDistributionDetails(
          mall: 'Ably',
          gender: 'man',
          age: '40대',
          earnings: 1,
          icon: Icons.man),
      const GenderDistributionDetails(
        mall: 'Ably',
        gender: 'woman',
        age: '~10대',
        earnings: 2,
        icon: Icons.woman,
      ),
      const GenderDistributionDetails(
          mall: 'Ably',
          gender: 'woman',
          age: '20대',
          earnings: 2,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'Ably',
          gender: 'woman',
          age: '30대',
          earnings: 2,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'Ably',
          gender: 'woman',
          age: '40대',
          earnings: 2,
          icon: Icons.woman),
      const GenderDistributionDetails(
          mall: 'Ably',
          gender: 'woman',
          age: '50대',
          earnings: 1,
          icon: Icons.woman),
    ];
    return chartData;
  }
}

class GenderDistributionDetails {
  const GenderDistributionDetails({
    required this.earnings,
    this.mall,
    this.gender,
    this.age,
    this.icon,
  });

  final String? mall;
  final String? gender;
  final String? age;
  final double earnings;
  final IconData? icon;
}
