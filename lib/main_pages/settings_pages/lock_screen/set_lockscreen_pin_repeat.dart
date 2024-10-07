import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:servicer/main_pages/settings_pages/logics/settings_definitions.dart';
import 'package:servicer/main_pages/settings_pages/logics/settings_handler_v3.dart';

class RepeatPin extends StatefulWidget {
  final String inputtedPin;

  RepeatPin({Key? key, required this.inputtedPin}) : super(key: key);

  @override
  State<RepeatPin> createState() => _RepeatPinState();
}

class _RepeatPinState extends State<RepeatPin> {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  var formKey = GlobalKey<FormState>();
  bool didPinFail = false;

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: TextStyle(fontSize: 10, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(255, 122, 129, 135)),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('set_lock_screen'));
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('PIN 번호를 다시 한 번 입력해주세요. \n'),
                Pinput(
                  controller: controller,
                  obscuringCharacter: '●',
                  focusNode: focusNode,
                  closeKeyboardWhenCompleted: true,
                  autofocus: true,
                  length: 6,
                  obscureText: true,
                  //obscuringCharacter: '*',
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  validator: (pin) {
                    return widget.inputtedPin == pin ? null : '\nPIN번호를 다시 확인해주세요.';
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: false,
                  onTap: () {
                    (didPinFail) ? controller.text = '' : null;
                  },
                  onCompleted: (pin) {
                    if (widget.inputtedPin == pin) {
                      SettingsHandlerV3().setPreferences(Security.lockScreenType, LockScreenType.pin);
                      Navigator.popUntil(context, ModalRoute.withName('set_lock_screen'));
                    } else {
                      didPinFail = true;
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
