import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';
import 'c_data_handler/name_switch_for_icon.dart';

class ListSearch extends StatefulWidget {
  ListSearchState createState() => ListSearchState();
}

class ListSearchState extends State<ListSearch> with IconSwitcher {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController _textController = TextEditingController();

  static List<String> mainDataList = [
    "지그재그",
    "에이블리",
    "쿠팡",
    "룩핀",
    "스마트스토어",
    "지마켓",
    "마켓컬리",
    "지그재그",
    "에이블리",
    "쿠팡",
    "룩핀",
    "스마트스토어",
    "지마켓",
    "마켓컬리",
  ];

  // Copy Main List into New List.
  List<String> newDataList = List.from(mainDataList);

  onItemChanged(String value) {
    setState(() {
      newDataList = mainDataList
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              const Padding(padding: EdgeInsets.symmetric(vertical: 12)),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 1.2,
                    child: Row(
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          flex: 1,
                          child: IconButton(
                            iconSize: $bigFontSize - 4,
                            icon: const Icon(
                              Icons.arrow_back_ios_rounded,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          flex: 16,
                          child: SizedBox(
                            width: 320 *
                                MediaQuery.of(context).size.width *
                                0.0022,
                            height: 50,
                            child: TextField(
                              controller: _textController,
                              decoration: InputDecoration(
                                  hintText: '판매처 검색',
                                  fillColor: Color.fromARGB(255, 230, 230, 230),
                                  filled: true,
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 20)),
                              onChanged: onItemChanged,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                  width: double.infinity,
                  child: Divider(
                      color: Color.fromARGB(255, 168, 168, 168),
                      thickness: 1.0)),
              Expanded(
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
                          '최근 검색',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: $mediumFontSize - 4,
                          ),
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(12.0),
                        children: newDataList.map((data) {
                          return ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: iconSwitcher(data)),
                                ),
                              ],
                            ),
                            title: Text(data),
                            onTap: () => print(data),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26),
                        child: Text(
                          '추천 검색',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: $mediumFontSize - 4,
                          ),
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(12.0),
                        children: newDataList.map((data) {
                          return ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: iconSwitcher(data)),
                                ),
                              ],
                            ),
                            title: Text(data),
                            onTap: () => print(data),
                          );
                        }).toList(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 26),
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
                        padding: EdgeInsets.all(12.0),
                        children: newDataList.map((data) {
                          return ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Transform.scale(
                                  scale: 0.8,
                                  child: SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: iconSwitcher(data)),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Search bar in app bar flutter
class SearchAppBar extends StatefulWidget {
  const SearchAppBar({super.key});

  @override
  _SearchAppBarState createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  Widget appBarTitle = Text("AppBar Title");
  Icon actionIcon = Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: appBarTitle, actions: <Widget>[
        IconButton(
          icon: actionIcon,
          onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = Icon(Icons.close);
                this.appBarTitle = TextField(
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.white)),
                );
              } else {
                this.actionIcon = Icon(Icons.search);
                this.appBarTitle = Text("AppBar Title");
              }
            });
          },
        ),
      ]),
    );
  }
}
