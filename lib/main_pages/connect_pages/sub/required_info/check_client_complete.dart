import 'package:flutter/material.dart';
import '../../../../design_standards/text_styles.dart';
import '../../c_data_handler/name_switch_for_icon.dart';

class CheckCompletePage extends StatefulWidget {
  final String mallName;

  final String? initialValue_;
  CheckCompletePage({
    Key? key,
    required this.mallName,
    required this.initialValue_,
  }) : super(key: key);

  @override
  State<CheckCompletePage> createState() => _CheckCompletePageState();
}

class _CheckCompletePageState extends State<CheckCompletePage>
    with IconSwitcher {
  late TextEditingController controller = TextEditingController(
      text: (widget.initialValue_ == null) ? "" : widget.initialValue_);
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(''),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: $mediumFontSize,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: SizedBox(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40.0),
                      child: SizedBox(
                        child: iconSwitcher(widget.mallName),
                        height: 50,
                        width: 50,
                      ),
                    ),
                    Text("${widget.mallName}의 연동이 완료되었습니다.",
                        style: TextStyle(fontSize: $mediumFontSize)),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: Colors.green[400],
                      size: 50,
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                    const Spacer(),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                //모서리를 둥글게
                                borderRadius: BorderRadius.circular(60)),
                            minimumSize: const Size(260, 50), //width, height
                            elevation: 0,
                            alignment: Alignment.center,
                            textStyle:
                                TextStyle(fontSize: $mediumFontSize - 4)),
                        onPressed: () {
                          int count = 0;
                          // pop 6 times
                          Navigator.of(context).popUntil((route) {
                            return count++ == 6;
                          });
                          // Navigator.popUntil(
                          //     context, ModalRoute.withName('/ConnectPage'));

                          // Navigator.pop(context);
                          // //print the current route
                          // //FIXME: popUntil, PushNamedAndRemoveUntil이 구현지 잘 안된다. 계속 하단바가 사라지는 이슈가 생긴다. 계속 고쳐봤는데도 해결 잘 안 됨
                          // Navigator.pop(context);
                          // Navigator.pop(context);
                          // Navigator.pop(context);
                          // Navigator.pop(context);
                          // Navigator.pop(context);
                        },
                        child: Text('확인'),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
