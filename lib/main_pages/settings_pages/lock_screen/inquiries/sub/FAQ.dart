import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';

class SettingsPageQuestionsFAQ extends StatefulWidget {
  const SettingsPageQuestionsFAQ({Key? key}) : super(key: key);

  @override
  SettingsPageQuestionsFAQState createState() => SettingsPageQuestionsFAQState();
}

class SettingsPageQuestionsFAQState extends State<SettingsPageQuestionsFAQ> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 24),
                child: Row(
                  children: [
                    Flexible(
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    iconSize: $mediumFontSize,
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'FAQ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: $mediumFontSize,
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 12)),
              Container(
                height: 470,
                child: ListView(
                  children: ListTile.divideTiles(context: context, tiles: [
                    ListTile(
                      title: Text('서비서는 어떤 어플인가요?'),
                      trailing: IconButton(
                        iconSize: $mediumFontSize - 4,
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                        onPressed: () {},
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('멤버쉽은 어떤 게 있나요?'),
                      trailing: IconButton(
                        iconSize: $mediumFontSize - 4,
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                        onPressed: () {},
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('알림 설정은 어떻게 할 수 있나요?'),
                      trailing: IconButton(
                        iconSize: $mediumFontSize - 4,
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                        onPressed: () {},
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text('내 쇼핑몰 등록은 어떻게 하나요?'),
                      trailing: IconButton(
                        iconSize: $mediumFontSize - 4,
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                        onPressed: () {},
                      ),
                      onTap: () {},
                    ),
                  ]).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
