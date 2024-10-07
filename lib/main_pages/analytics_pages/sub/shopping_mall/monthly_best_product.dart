import 'package:flutter/material.dart';
import 'package:servicer/MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';
import 'package:servicer/design_standards/colors.dart';

class MonthlyBestProduct extends StatefulWidget {
  const MonthlyBestProduct({super.key});

  @override
  State<MonthlyBestProduct> createState() => _MonthlyBestProductState();
}

class _MonthlyBestProductState extends State<MonthlyBestProduct> {
  Map<String, dynamic> prouctName = {
    "상품명 1": "쿠팡에서 190건",
    "상품명 2": "옥션에서 90건",
    "상품명 3": "에이블리에서 81건"
  };

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      //itemExtent: 90,
      itemBuilder: (context, index) {
        return BHTouchFXListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: $$lightGrey,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: Text(
                      (index + 1).toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ),
              Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.image, color: Colors.white, size: 40)),
            ],
          ),
          title: Text(
            prouctName.keys.toList()[index],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            prouctName.values.toList()[index],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
