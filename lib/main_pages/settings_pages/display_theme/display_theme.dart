import 'package:flutter/material.dart';
import 'package:servicer/design_standards/colors.dart';
import 'package:servicer/design_standards/text_styles.dart';
import 'package:servicer/design_standards/widget_styles.dart';
import 'package:servicer/main.dart';

class SettingsPageScreenTheme extends StatefulWidget {
  const SettingsPageScreenTheme({Key? key}) : super(key: key);

  @override
  SettingsPageScreenThemeState createState() => SettingsPageScreenThemeState();
}

class SettingsPageScreenThemeState extends State<SettingsPageScreenTheme> {
  bool _darkModeEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('테마 및 화면 설정'),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: $mediumFontSize,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                CheckboxListTile(
                    title: Text('다크 모드'),
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      setState(() {
                        _darkModeEnabled = value!;
                      });
                      _darkModeEnabled
                          ? MyApp.themeNotifier.value = ThemeMode.dark
                          : MyApp.themeNotifier.value = ThemeMode.light;
                    }),
              ],
            )),
      ),
    );
  }
}
