import 'package:flutter/material.dart';
import '../../../data_handler/data_standards/time.dart';
import '../../../data_handler/mapData_handler/mapData_picker.dart';
import '../../../data_handler/mapData_handler/mapData_time.dart';
import '../../../data_handler/mapData_handler/pie_chart/map_sectiondata_converter.dart';
import '../../../data_handler/text/chart_text.dart';
import '../../../design_standards/colors.dart';
import '../../../design_standards/text_styles.dart';

class ElementList extends StatefulWidget {
  final Map<String, dynamic> data;
  const ElementList({Key? key, this.data = const {}}) : super(key: key);

  @override
  State<ElementList> createState() => _ElementListState();
}

class _ElementListState extends State<ElementList> {
  final List<bool> _isSelectedTime = [true, false, false, false, false, false];
  final TextEditingController _textController = TextEditingController();
  static List<String> mainDataList = [
    "zigzag",
    "에이블리",
    "쿠팡",
    "룩핀",
    "스마트 스토어",
    "지마켓",
    "마켓컬리",
  ];

  late Time time;
  late String searchWord;
  bool listVisible = false;
  void showList() {
    setState(() {
      listVisible = true;
    });
  }

  void hideList() {
    setState(() {
      listVisible = false;
    });
  }

  @override
  void initState() {
    time = Time.day;
    searchWord = "total";
    print(sumElementData(Picker().pickDataByName(
        MapDataTimeRange().pickTimeRange(widget.data, time, 20220830),
        "total")));
    super.initState();
  }

  // Copy Main List into New List.
  List<String> newDataList = List.from(mainDataList);

  onItemChanged(String value) {
    setState(() {
      newDataList = mainDataList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
    // if value is empty, hide list
    if (value.isEmpty) {
      hideList();
    } else {
      showList();
    }
  }

  onItemSubmitted(String value) {
    setState(() {
      searchWord = value;
    });
    hideList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: ListTile.divideTiles(context: context, tiles: [
        // TextButton(
        //   child: Text("ss"),
        //   onPressed: () {
        //     print(widget.data);
        //   },
        // ),
        SizedBox(
          width: 320 * MediaQuery.of(context).size.width * 0.0022,
          height: 50,
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
                hintText: '검색',
                fillColor: Colors.white,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(60.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(60.0),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20)),
            onChanged: onItemChanged,
            onSubmitted: onItemSubmitted,
            onEditingComplete: hideList,
          ),
        ),
        Visibility(
          visible: listVisible,
          child: GestureDetector(
            onTap: hideList,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              //physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26),
                    child: Text(
                      '검색 결과',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: $mediumFontSize - 4,
                      ),
                    ),
                  ),
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(12.0),
                    children: newDataList.map((data) {
                      return ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.scale(
                              scale: 1.6,
                              child: const Icon(
                                Icons.fullscreen,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        title: Text(data),
                        onTap: () => print(data),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: ToggleButtons(
            splashColor: Colors.transparent,
            renderBorder: false,
            //borderRadius: BorderRadius.circular(15),
            constraints: const BoxConstraints.expand(
              height: 25,
              width: 46,
            ),
            color: $$Grey,
            fillColor: Colors.transparent,
            selectedColor: Colors.black,
            isSelected: _isSelectedTime,
            onPressed: (int newIndex) {
              setState(() {
                for (int i = 0; i < _isSelectedTime.length; i++) {
                  if (i == newIndex) {
                    _isSelectedTime[i] = true;
                  } else {
                    _isSelectedTime[i] = false;
                    switch (newIndex) {
                      case 0:
                        time = Time.day;
                        break;
                      case 1:
                        time = Time.week;
                        break;
                      case 2:
                        time = Time.month;
                        break;
                    }
                  }
                  //print(_isSelectedTime);
                }
              });
            },
            children: [
              Ink(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color:
                        _isSelectedTime[0] ? $$lightGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(child: Text('일'))),
              Ink(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color:
                        _isSelectedTime[1] ? $$lightGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(child: Text('주'))),
              Ink(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color:
                        _isSelectedTime[2] ? $$lightGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(child: Text('월'))),
              Ink(
                  width: 26,
                  height: 26,
                  decoration: BoxDecoration(
                    color:
                        _isSelectedTime[3] ? $$lightGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(child: Text('년'))),
              Ink(
                  width: 38,
                  height: 26,
                  decoration: BoxDecoration(
                    color:
                        _isSelectedTime[4] ? $$lightGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(child: Text('전체'))),
              Ink(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color:
                        _isSelectedTime[5] ? $$lightGrey : Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(child: Icon(Icons.calendar_month))),
            ],
          ),
        ),
        showSearchList(sumElementData(Picker().pickDataByName(
            MapDataTimeRange().pickTimeRange(widget.data, time, 20220830),
            searchWord))),
      ]).toList(),
    );
  }
}

Widget showSearchList(Map<String, dynamic> data) {
  return ListView(
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    physics: const NeverScrollableScrollPhysics(),
    // itemBuilder: (context, index) => ListTile(
    //   title: Text(data[key]),
    //   trailing: Text(data[key]),
    //   onTap: () => print(data[index]),
    // ),
    //itemBuilder that shows key and value of Map data
    // itemBuilder: (context, index) {
    //   var key = data.keys.elementAt(index);
    //   return ListTile(
    //     title: Text(key),
    //     trailing: Text(data[key]),
    //     onTap: () => print(data[index]),
    //   );
    // },
    //make List of ListTile that shows key and value of Map data
    children: data.keys.map((key) {
      return ListTile(
        title: Text(key),
        trailing:
            Text(ChartText().addComma(data[key].toInt().toString()) + "건"),
        onTap: () => print(data[key]),
      );
    }).toList(),
  );
}
