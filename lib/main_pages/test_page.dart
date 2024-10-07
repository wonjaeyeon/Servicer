import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:servicer/sample_data/getdata.dart';
import 'package:servicer/MOD_PACKAGES/SVSHorizontalBarChart/SVS_horizontalBarChart.dart';

class TestPage extends StatefulWidget {
  TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('horizontalchart testpage'),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SVSHorizontalBarChart(
            data: shoppingMallExampleData,
            useTestMode: true,
          ),
        ),
      ),
    );
  }
}
