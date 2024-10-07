import 'package:flutter/material.dart';
import 'package:servicer/design_standards/text_styles.dart';
import '../../../design_standards/colors.dart';

class BottomSheetTime {
  //make a constructor
  final _controllerStartDate = TextEditingController();
  final _controllerEndDate = TextEditingController();

  //function that return _controllerStartDate.text
  String getStartDate() {
    return _controllerStartDate.text;
  }

  //function that return _controllerEndDate.text
  String getEndDate() {
    return _controllerEndDate.text;
  }

  //make function that makes showModalBottomsheet
  Future<dynamic> makeShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Row(
                    children: const [
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        '시간 선택',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 15,
                        child: SizedBox(
                          //width: MediaQuery.of(context).size.width * 0.44,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: TextField(
                              controller: _controllerStartDate,
                              decoration: InputDecoration(
                                hintText: '시작일',
                                hintStyle: TextStyle(color: $$Grey),
                                suffixIcon: Icon(
                                  Icons.calendar_month,
                                  color: $$Grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: $$lightGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                          flex: 2,
                          child: Text(
                            "~",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: $mediumFontSize, color: Colors.black),
                          )),
                      Flexible(
                        flex: 15,
                        child: SizedBox(
                          //width: MediaQuery.of(context).size.width * 0.44,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: TextField(
                              controller: _controllerEndDate,
                              decoration: InputDecoration(
                                hintText: '종료일',
                                hintStyle: TextStyle(color: $$Grey),
                                suffixIcon: Icon(
                                  Icons.calendar_month,
                                  color: $$Grey,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: $$lightGrey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () => {
                              //startDate = _controllerStartDate.text,
                              Navigator.pop(context, {
                                'startDate': _controllerStartDate.text,
                                'endDate': _controllerEndDate.text
                              })
                            },
                        child: Text(
                          "확인",
                          style: (TextStyle(fontSize: 20, color: Colors.black)),
                        )),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                ],
              ),
            ));
  }
}
