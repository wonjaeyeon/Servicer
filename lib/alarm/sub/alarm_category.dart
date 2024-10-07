import 'package:flutter/material.dart';
import 'package:servicer/MOD_PACKAGES/BH_touchFX/bh_touchfx.dart';

class ACategory extends StatefulWidget {
  const ACategory({super.key});

  @override
  State<ACategory> createState() => _ACategoryState();
}

class _ACategoryState extends State<ACategory> {
  final double _verticalPadding = 15;
  final double _horizontalPadding = 15;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 2.8,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: BHTouchFXInkWell(
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Flexible(flex: 2, child: Icon(Icons.description)),
                              SizedBox(width: 10),
                              Flexible(flex: 3, child: Text('판매/반품/취소')),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: AspectRatio(
                      aspectRatio: 2.8,
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: BHTouchFXInkWell(
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Flexible(
                                  flex: 1, child: Icon(Icons.question_answer)),
                              SizedBox(width: 10),
                              Flexible(flex: 1, child: Text('문의사항')),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  
                  
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
