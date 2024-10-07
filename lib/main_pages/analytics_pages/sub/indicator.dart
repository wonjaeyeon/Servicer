import 'package:flutter/material.dart';
import '../../../data_handler/text/chart_text.dart';

class IndicatorsWidget extends StatelessWidget {
  final List data;
  final String unit;
  const IndicatorsWidget({Key? key, required this.data, required this.unit})
      : super(key: key);
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data
            .map(
              (data) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: buildIndicator(
                    color: data.color,
                    text: data.title,
                    value: data.value.toInt(),
                    // isSquare: true,
                  )),
            )
            .toList(),
      );

  Widget buildIndicator({
    required Color color,
    required String text,
    required int value,
    bool isSquare = true,
    double size = 16,
    Color textColor = const Color(0xff505050),
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Row(
          children: <Widget>[
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: textColor,
              ),
            ),
            const Spacer(),
            Text(
              ChartText().addComma("$value") + unit,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: textColor,
              ),
            ),
          ],
        ),
      );
}
