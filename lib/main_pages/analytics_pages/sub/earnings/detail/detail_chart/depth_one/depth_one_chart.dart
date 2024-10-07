import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../design_standards/colors.dart';
import '../../../../../../../design_standards/text_styles.dart';
import '../../../../../../../design_standards/widget_styles.dart';
import 'sub/depth_one_analysis.dart';
import 'sub/depth_one_graph.dart';

class DetailChartContainerD1 extends StatefulWidget {
  final String title;
  DetailChartContainerD1({Key? key, required this.title}) : super(key: key);

  @override
  State<DetailChartContainerD1> createState() => _DetailChartContainerD1State();
}

class _DetailChartContainerD1State extends State<DetailChartContainerD1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: $$lightGrey,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(fontSize: $mediumFontSize),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Color.fromARGB(255, 238, 238, 238)
            ],
            stops: [
              0.0,
              0.04,
              0.96,
              1.0
            ], // 10% purple, 80% transparent, 10% purple
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: Container(
          color: Color.fromARGB(255, 238, 238, 238),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.topCenter,
                    child: D1GraphContainer(),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
