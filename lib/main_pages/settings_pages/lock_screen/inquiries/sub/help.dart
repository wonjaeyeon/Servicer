import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HelpPage extends StatefulWidget {
  HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  bool isLoadingErrorOccurred = false;
  int oldpercent = 0;
  int percent = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Opacity(
                opacity: percent == 100 ? 1 : 0.3,
                child: InAppWebView(
                  initialUrlRequest:
                      URLRequest(url: Uri.parse('https://servicer.notion.site/744e84c4e7c445ffbfbc19a28e9f69b5')),
                  onProgressChanged: (controller, progress) => setState(() {
                    oldpercent = percent;
                    percent = progress;
                  }),
                  onLoadError: (controller, url, code, message) => setState(() {
                    isLoadingErrorOccurred = true;
                  }),
                ),
              ),
              isLoadingErrorOccurred
                  ? Text('Error occurred while loading page')
                  : AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      opacity: (percent == 100) ? 0 : 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: TweenAnimationBuilder(
                          duration: const Duration(milliseconds: 250),
                          tween: Tween<double>(begin: oldpercent.toDouble(), end: percent.toDouble()),
                          builder: (BuildContext context, dynamic value, Widget? child) => Container(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(value: value / 100, strokeWidth: 8),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color.fromARGB(16, 0, 0, 0)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
