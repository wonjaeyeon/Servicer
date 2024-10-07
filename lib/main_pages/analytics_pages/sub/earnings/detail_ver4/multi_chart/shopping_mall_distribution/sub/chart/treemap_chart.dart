import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';
import '../../../../../../../../../../design_standards/colors.dart';
import '../../../../../../../../../../design_standards/text_styles.dart';

/// Treemap import.
import 'package:syncfusion_flutter_treemap/treemap.dart';

import '../../../../../../../../../../servicer_modules/shopping_mall_master.dart';

class TreemapViewChartContainer extends StatefulWidget {
  const TreemapViewChartContainer({super.key});

  @override
  State<TreemapViewChartContainer> createState() =>
      _TreemapViewChartContainerState();
}

class _TreemapViewChartContainerState extends State<TreemapViewChartContainer>
    with SingleTickerProviderStateMixin {
  late TooltipBehavior _tooltipBehavior;
  late List<GEarningsDistributionDetails> _gEarningsDistributionDetails;
  late Map<String, Color> _colors;
  late List<TreemapLevel> _levels;
  late bool _isLightTheme;
  late AnimationController _opacityAnimationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true, color: $$Grey, opacity: 1);
    _gEarningsDistributionDetails = <GEarningsDistributionDetails>[
      const GEarningsDistributionDetails(
          continent: 'SmartStore',
          country: 'India',
          state: 'Uttar Pradesh',
          populationInThousands: 199812.341,
          color: Color.fromARGB(255, 210, 191, 50)),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Maharashtra',
        populationInThousands: 112374.333,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Bihar',
        populationInThousands: 104099.452,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'West Bengal',
        populationInThousands: 91276.115,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Madhya Pradesh',
        populationInThousands: 72626.809,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Tamil Nadu',
        populationInThousands: 72147.03,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Rajasthan',
        populationInThousands: 68548.437,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Karnataka',
        populationInThousands: 61095.297,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Gujarat',
        populationInThousands: 60439.692,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Andhra Pradesh',
        populationInThousands: 49576.777,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Odisha',
        populationInThousands: 41974.218,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Telangana',
        populationInThousands: 35004,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Kerala',
        populationInThousands: 33406.061,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Jharkhand',
        populationInThousands: 32988.134,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Assam',
        populationInThousands: 31205.576,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Punjab',
        populationInThousands: 27743.338,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Chhattisgarh',
        populationInThousands: 25545.198,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Haryana',
        populationInThousands: 25351.462,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Delhi',
        populationInThousands: 16787.941,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Jammu & Kashmir',
        populationInThousands: 12258.433,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Uttarakhand',
        populationInThousands: 10086.292,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Himachal Pradesh',
        populationInThousands: 6864.602,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Tripura',
        populationInThousands: 3673.917,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Meghalaya',
        populationInThousands: 2966.889,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Manipur',
        populationInThousands: 2855.794,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Nagaland',
        populationInThousands: 1978.502,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Goa',
        populationInThousands: 1458.545,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Arunachal Pradesh',
        populationInThousands: 1383.727,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Puducherry',
        populationInThousands: 1247.953,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Mizoram',
        populationInThousands: 1097.206,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Chandigarh',
        populationInThousands: 1055.45,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'India',
        state: 'Sikkim',
        populationInThousands: 610.577,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Guangdong',
        populationInThousands: 126010,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Shandong',
        populationInThousands: 101530,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Henan',
        populationInThousands: 99370,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Jiangsu',
        populationInThousands: 84750,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Sichuan',
        populationInThousands: 83670,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Hebei',
        populationInThousands: 74610,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Hunan',
        populationInThousands: 66440,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Zheijiang',
        populationInThousands: 64570,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Anhui',
        populationInThousands: 61030,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Hubei',
        populationInThousands: 57750,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Guangxi',
        populationInThousands: 50130,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Yunnan',
        populationInThousands: 47210,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Jiangsi',
        populationInThousands: 45190,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Liaoning',
        populationInThousands: 42590,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Fujian',
        populationInThousands: 41540,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Shaanxi',
        populationInThousands: 39530,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Guizhou',
        populationInThousands: 38560,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Shanxi',
        populationInThousands: 34920,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Chongqing',
        populationInThousands: 32050,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Heilongjiang',
        populationInThousands: 31850,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Xinjiang',
        populationInThousands: 25850,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Gansu',
        populationInThousands: 25020,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Shanghai',
        populationInThousands: 24870,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Jilin',
        populationInThousands: 24070,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Inner Mongolia',
        populationInThousands: 24040,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Beijing',
        populationInThousands: 21890,
        color: Color.fromARGB(255, 210, 191, 50),
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Tianjin',
        populationInThousands: 13870,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Hainan',
        populationInThousands: 10080,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Ningxia',
        populationInThousands: 7200,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Qinghai',
        populationInThousands: 59200,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'China',
        state: 'Tibet',
        populationInThousands: 36500,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Indonesia',
        populationInThousands: 273523.615,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Pakisthan',
        populationInThousands: 220892.34,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Bangladesh',
        populationInThousands: 164689.383,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Japan',
        populationInThousands: 126476.461,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Philippines',
        populationInThousands: 109581.078,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Vietnam',
        populationInThousands: 97338.579,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Turkey',
        populationInThousands: 84339.067,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Iran',
        populationInThousands: 83992.949,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Thailand',
        populationInThousands: 69799.978,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Myanmar',
        populationInThousands: 54409.8,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'South Korea',
        populationInThousands: 51269.185,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Iraq',
        populationInThousands: 40222.493,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Afghanistan',
        populationInThousands: 38928.346,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Saudi Arabia',
        populationInThousands: 34813.871,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Uzbekistan',
        populationInThousands: 33469.203,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Malaysia',
        populationInThousands: 32365.999,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Yemen',
        populationInThousands: 29825.964,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Nepal',
        populationInThousands: 29136.808,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Tajikistan',
        populationInThousands: 25778.816,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Israel',
        populationInThousands: 8655.535,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Hong Kong',
        populationInThousands: 7496.981,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Laos',
        populationInThousands: 7275.56,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Lebanon',
        populationInThousands: 6825.445,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Kyrgyzstan',
        populationInThousands: 6524.195,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Turkmenistan',
        populationInThousands: 6031.2,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Singapore',
        populationInThousands: 5850.342,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'State of Palestine',
        populationInThousands: 5101.414,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Oman',
        populationInThousands: 5106.626,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Kuwait',
        populationInThousands: 4270.571,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Georgia',
        populationInThousands: 3989.167,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Mongolia',
        populationInThousands: 3278.29,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Armenia',
        populationInThousands: 2963.243,
      ),
      const GEarningsDistributionDetails(
        continent: 'SmartStore',
        country: 'Qatar',
        populationInThousands: 2881.053,
      ),
      const GEarningsDistributionDetails(
          continent: 'Zigzag',
          country: 'Nigeria',
          state: 'Lagos',
          populationInThousands: 14862,
          color: Color.fromRGBO(44, 90, 128, 1.0)),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Kano',
        populationInThousands: 4103,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ibadan',
        populationInThousands: 3649,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Kaduna',
        populationInThousands: 1133,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Port Harcourt',
        populationInThousands: 3171,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Benin City',
        populationInThousands: 1782,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Maiduguri',
        populationInThousands: 803,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Zaria',
        populationInThousands: 736,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Aba',
        populationInThousands: 1114,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Jos',
        populationInThousands: 917,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ilorin',
        populationInThousands: 974,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Oyo',
        populationInThousands: 441,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Uyo',
        populationInThousands: 1200,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Enugu',
        populationInThousands: 795,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Lokoja',
        populationInThousands: 741,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Abuja',
        populationInThousands: 3464,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Sokoto',
        populationInThousands: 662,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Onitsha',
        populationInThousands: 1483,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Warri',
        populationInThousands: 899,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ikorodu',
        populationInThousands: 989,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Okene',
        populationInThousands: 478,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Igbidu',
        populationInThousands: 465,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Calabar',
        populationInThousands: 605,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Katsina',
        populationInThousands: 487,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ado Ekiti',
        populationInThousands: 497,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Akure',
        populationInThousands: 691,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Bauchi',
        populationInThousands: 621,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ikeja',
        populationInThousands: 313.196,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Makurdi',
        populationInThousands: 422,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Minna',
        populationInThousands: 463,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Effon Alaaye',
        populationInThousands: 396,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ilesa',
        populationInThousands: 371,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Umuahia',
        populationInThousands: 817,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ondo',
        populationInThousands: 445,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ikot Ekpene',
        populationInThousands: 254.806,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ife',
        populationInThousands: 385,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Gombe',
        populationInThousands: 529,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Jimeta',
        populationInThousands: 248.148,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Atani',
        populationInThousands: 230,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Gusau',
        populationInThousands: 226.857,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Mubi',
        populationInThousands: 225.705,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ikire',
        populationInThousands: 222.16,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Owerri',
        populationInThousands: 908,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Shagamu',
        populationInThousands: 214.558,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ijebu-Ode	',
        populationInThousands: 209.175,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ugep',
        populationInThousands: 200.276,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Nnewi',
        populationInThousands: 1114,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ise-Ekiti',
        populationInThousands: 190.063,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ila Orangun',
        populationInThousands: 179.192,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Saki',
        populationInThousands: 178.677,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Bida',
        populationInThousands: 171.656,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Awka',
        populationInThousands: 167.738,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ado-Ekiti',
        populationInThousands: 497,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Inisa',
        populationInThousands: 164.161,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Suleja',
        populationInThousands: 162.135,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Sapele',
        populationInThousands: 161.686,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Osogbo',
        populationInThousands: 731,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Kisi',
        populationInThousands: 155.51,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Gbongan',
        populationInThousands: 139.485,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ejigbo',
        populationInThousands: 138.357,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Funtua',
        populationInThousands: 136.811,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Igboho',
        populationInThousands: 136.764,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Buguma',
        populationInThousands: 135.404,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Ikirun',
        populationInThousands: 134.24,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Abakaliki',
        populationInThousands: 602,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Okrika',
        populationInThousands: 133.271,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Amaigbo',
        populationInThousands: 127.3,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Lafia',
        populationInThousands: 348,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Gashua',
        populationInThousands: 125.817,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Nigeria',
        state: 'Modakeke',
        populationInThousands: 119.529,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Ethiopia',
        state: 'Tigray',
        populationInThousands: 7070,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Ethiopia',
        state: 'Afar',
        populationInThousands: 1812.002,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Ethiopia',
        state: 'Amhara',
        populationInThousands: 108113.15,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Ethiopia',
        state: 'Dire Dawa',
        populationInThousands: 493,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Ethiopia',
        state: 'Gambela',
        populationInThousands: 435.999,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Ethiopia',
        state: 'Benishangul Gumuz',
        populationInThousands: 1127.001,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Ethiopia',
        state: 'Oromia',
        populationInThousands: 3500,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Ethiopia',
        state: 'Addis Ababa',
        populationInThousands: 5006,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Egypt',
        populationInThousands: 102334.404,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Kinshasa',
        populationInThousands: 11575,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Kongo Central',
        populationInThousands: 5575,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Kwango',
        populationInThousands: 1994.036,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Kwilu',
        populationInThousands: 5174.718,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Mai-Ndombe',
        populationInThousands: 1768.327,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Kasaï',
        populationInThousands: 3199.891,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Kasaï-Central',
        populationInThousands: 2976.806,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Kasaï-Oriental',
        populationInThousands: 2702.43,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Lomami',
        populationInThousands: 2048.839,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Sankuru',
        populationInThousands: 1374.239,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Maniema',
        populationInThousands: 2333,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'South Kivu',
        populationInThousands: 5772,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'North Kivu',
        populationInThousands: 6655,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Ituri',
        populationInThousands: 4241.236,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Haut-Uele',
        populationInThousands: 1920.867,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Tshopo',
        populationInThousands: 2614.63,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Bas-Uele',
        populationInThousands: 1093.845,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Nord-Ubangi',
        populationInThousands: 1482.076,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Mongala',
        populationInThousands: 1793.564,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Sud-Ubangi',
        populationInThousands: 2744.345,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Équateur',
        populationInThousands: 1626.606,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Tshuapa',
        populationInThousands: 1316.855,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Tanganyika',
        populationInThousands: 2482.001,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Haut-Lomami',
        populationInThousands: 2540.127,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Lualaba',
        populationInThousands: 1677.288,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'DR Congo',
        state: 'Haut-Katanga',
        populationInThousands: 3960.945,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Tanzania',
        populationInThousands: 59734.218,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'South Zigzag',
        populationInThousands: 59308.69,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Kenya',
        populationInThousands: 53771.296,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Uganda',
        populationInThousands: 45741.007,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Algeria',
        populationInThousands: 43851.044,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Sudan',
        populationInThousands: 43849.26,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Morocco',
        populationInThousands: 36910.56,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Angola',
        populationInThousands: 32866.272,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Mozambique',
        populationInThousands: 31255.435,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Ghana',
        populationInThousands: 31072.94,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Madagascar',
        populationInThousands: 27.691,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Cameroon',
        populationInThousands: 26545.863,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Ivory Coast',
        populationInThousands: 26378.274,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Niger',
        populationInThousands: 24206.644,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Burkina Faso',
        populationInThousands: 20903.273,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Mali',
        populationInThousands: 20250.833,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Malawi',
        populationInThousands: 19129.952,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Zambia',
        populationInThousands: 18383.955,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Senegal',
        populationInThousands: 16743.927,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Chad',
        populationInThousands: 16425.864,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Somalia',
        populationInThousands: 15893.222,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Zimbabwe',
        populationInThousands: 14862.924,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Guinea',
        populationInThousands: 13132.795,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Rwanda',
        populationInThousands: 12952.218,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Benin',
        populationInThousands: 12123.2,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Tunisia',
        populationInThousands: 11818.619,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Burundi',
        populationInThousands: 11890.784,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'South Sudan',
        populationInThousands: 11193.725,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Togo',
        populationInThousands: 8278.724,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Sierra Leone',
        populationInThousands: 7976.983,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Libya',
        populationInThousands: 6871.292,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Congo',
        populationInThousands: 5518.087,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Liberia',
        populationInThousands: 5057.681,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Central Zigzagn Republic',
        populationInThousands: 4829.767,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Mauritania',
        populationInThousands: 4649.658,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Eritrea',
        populationInThousands: 3546.421,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Namibia',
        populationInThousands: 2540.905,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Gambia',
        populationInThousands: 2416.668,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Botswana',
        populationInThousands: 2351.627,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Gabon',
        populationInThousands: 2225.734,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Lesotho',
        populationInThousands: 2142.249,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Guinea-Bissau',
        populationInThousands: 1968.001,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Equatorial Guinea',
        populationInThousands: 1402.985,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Mauritius',
        populationInThousands: 1271.768,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Eswatini',
        populationInThousands: 1160.164,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Djibouti',
        populationInThousands: 988,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Réunion',
        populationInThousands: 895.312,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Comoros',
        populationInThousands: 869.601,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Western Sahara',
        populationInThousands: 597.339,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Cabo Verde',
        populationInThousands: 555.987,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Mayotte',
        populationInThousands: 272.815,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Sao Tome & Principe',
        populationInThousands: 219.159,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Seychelles',
        populationInThousands: 98.347,
      ),
      const GEarningsDistributionDetails(
        continent: 'Zigzag',
        country: 'Saint Helena',
        populationInThousands: 6.077,
      ),
      const GEarningsDistributionDetails(
          continent: 'Ably',
          populationInThousands: 747636.026,
          color: Color.fromRGBO(255, 100, 121, 1.0)),
    ];

    _levels = _getTreemapLevels();
    _colors = <String, Color>{
      'SmartStore':
          mallMaster.themeColorOf(Mall.NaverSmartStore).withOpacity(0.8),
      'Zigzag': mallMaster.themeColorOf(Mall.Zigzag).withOpacity(0.8),
      'Ably': mallMaster.themeColorOf(Mall.Ably).withOpacity(0.8),
    };
    _opacityAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _opacityAnimation = CurvedAnimation(
        parent: _opacityAnimationController, curve: Curves.linear);
    super.initState();
  }

  @override
  void dispose() {
    _opacityAnimationController.dispose();
    _gEarningsDistributionDetails.clear();
    _levels.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    _isLightTheme = themeData.colorScheme.brightness == Brightness.light;
    const double horizontalPadding = 15;

    return Column(
      children: <Widget>[
        Text(
          'Most populated continents 2021',
          style: themeData.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: AspectRatio(
            aspectRatio: 1.2,
            child: SfTreemap(
              dataCount: _gEarningsDistributionDetails.length,
              weightValueMapper: (int index) {
                return _gEarningsDistributionDetails[index]
                    .populationInThousands;
              },
              enableDrilldown: true,
              breadcrumbs: TreemapBreadcrumbs(
                builder:
                    (BuildContext context, TreemapTile tile, bool isCurrent) {
                  final Widget breadcrumbText = tile.group == 'Home'
                      ? Icon(Icons.home, color: Colors.black)
                      : Text(tile.group);
                  final Widget current = AnimatedDefaultTextStyle(
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: _isLightTheme
                            ? const Color.fromRGBO(10, 10, 10, 1)
                            : const Color.fromRGBO(255, 255, 255, 1),
                        fontWeight: isCurrent && tile.group != 'Home'
                            ? FontWeight.bold
                            : FontWeight.normal),
                    duration: const Duration(milliseconds: 500),
                    child: breadcrumbText,
                  );

                  if (tile.group == 'Home') {
                    if (!isCurrent) {
                      _opacityAnimationController.forward();
                    } else {
                      _opacityAnimationController.reverse();
                    }

                    return FadeTransition(
                        opacity: _opacityAnimation, child: current);
                  }

                  return current;
                },
              ),
              tooltipSettings: TreemapTooltipSettings(
                color: _isLightTheme
                    ? const Color.fromRGBO(45, 45, 45, 1)
                    : const Color.fromRGBO(242, 242, 242, 1),
              ),
              levels: _levels,
            ),
          ),
        ),
      ],
    );
  }

  List<TreemapLevel> _getTreemapLevels() {
    return <TreemapLevel>[
      TreemapLevel(
        //color: Colors.transparent,
        groupMapper: (int index) =>
            _gEarningsDistributionDetails[index].continent,
        // colorValueMapper: (TreemapTile tile) {
        //   return _colors[
        //       _gEarningsDistributionDetails[tile.indices[0]].continent];
        // },
        colorValueMapper: (TreemapTile tile) {
          return _colors[tile.group];
        },
        // labelBuilder: (BuildContext context, TreemapTile tile) {
        //   return _buildParentTileLabels(tile);
        // },

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
                    style: TextStyle(color: color),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ));
        },
        // itemBuilder: (BuildContext context, TreemapTile tile) {
        //   return _buildItemBuilder(tile);
        // }
      ),
      TreemapLevel(
        groupMapper: (int index) =>
            _gEarningsDistributionDetails[index].country,
        colorValueMapper: (TreemapTile tile) {
          return _colors[
              _gEarningsDistributionDetails[tile.indices[0]].continent];
        },
        tooltipBuilder: (BuildContext context, TreemapTile tile) {
          return _buildTooltipBuilder(tile);
        },
        labelBuilder: (BuildContext context, TreemapTile tile) {
          return _buildDescendantsLabels(tile);
        },
        itemBuilder: (BuildContext context, TreemapTile tile) {
          return _buildItemBuilder(tile);
        },
      ),
      TreemapLevel(
        groupMapper: (int index) => _gEarningsDistributionDetails[index].state,
        colorValueMapper: (TreemapTile tile) {
          return _colors[
              _gEarningsDistributionDetails[tile.indices[0]].continent];
        },
        labelBuilder: (BuildContext context, TreemapTile tile) {
          return _buildDescendantsLabels(tile);
        },
        tooltipBuilder: (BuildContext context, TreemapTile tile) {
          return _buildTooltipBuilder(tile);
        },
      ),
    ];
  }

  Widget _buildParentTileLabels(TreemapTile tile) {
    final Brightness brightness =
        ThemeData.estimateBrightnessForColor(tile.color);
    final Color color =
        brightness == Brightness.dark ? Colors.white : Colors.black;
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 4, top: 4, right: 4),
            child: Text(
              tile.group,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              'Population : ' +
                  (tile.weight / pow(10, 6)).toStringAsFixed(2) +
                  'B',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescendantsLabels(TreemapTile tile) {
    final Brightness brightness =
        ThemeData.estimateBrightnessForColor(tile.color);
    final Color color =
        brightness == Brightness.dark ? Colors.white : Colors.black;
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0, top: 4.0, right: 4),
          child: Text(
            tile.group,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontSize: 11, color: color),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  // Widget _buildTooltip(TreemapTile tile) {
  //   return Container(
  //     padding: const EdgeInsets.all(10),
  //     child: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         Row(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             Transform.translate(
  //               offset: const Offset(-3, 0),
  //               child: Icon(
  //                 _topRioOlympicCountries[tile.indices[0]].icon,
  //                 color: Colors.white,
  //                 size: 15,
  //               ),
  //             ),
  //             const SizedBox(height: 5),
  //             Text(tile.group, style: const TextStyle(color: Colors.white)),
  //           ],
  //         ),
  //         const SizedBox(height: 5),
  //         Text(
  //           _topRioOlympicCountries[tile.indices[0]].medal! +
  //               ' : ' +
  //               tile.weight.round().toString(),
  //           style: const TextStyle(color: Colors.white),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildItemBuilder(TreemapTile tile) {
    if (tile.hasDescendants) {
      return const Padding(
        padding: EdgeInsets.only(right: 4, bottom: 4),
        child: Align(
          alignment: Alignment.bottomRight,
          child: Icon(Icons.add_circle_outline, size: 20, color: Colors.white),
        ),
      );
    } else {
      return Container(
        color: tile.color,
      );
    }
  }

  Widget _buildTooltipBuilder(TreemapTile tile) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 7.0, 10.0, 8.5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            child: RichText(
              text: TextSpan(
                text: _levels.indexOf(tile.level) == 1 ? 'Country' : 'State',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      height: 1.5,
                      color: _isLightTheme
                          ? const Color.fromRGBO(255, 255, 255, 0.75)
                          : const Color.fromRGBO(10, 10, 10, 0.75),
                    ),
                children: const <TextSpan>[TextSpan(text: '\nPopulation')],
              ),
            ),
          ),
          const SizedBox(width: 15.0),
          SizedBox(
            child: RichText(
              text: TextSpan(
                text: tile.group,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                      color: _isLightTheme
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(10, 10, 10, 1),
                    ),
                children: <TextSpan>[
                  TextSpan(
                    text: '\n' +
                        ((_levels.indexOf(tile.level) == 1
                                    ? tile.weight
                                    : _gEarningsDistributionDetails[
                                            tile.indices[0]]
                                        .populationInThousands) /
                                pow(10, 3))
                            .toStringAsFixed(2) +
                        'M',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class GEarningsDistributionDetails {
  const GEarningsDistributionDetails({
    required this.continent,
    required this.populationInThousands,
    this.country,
    this.state,
    this.color,
  });

  final String continent;
  final String? country;
  final String? state;
  final double populationInThousands;
  final Color? color;
}
