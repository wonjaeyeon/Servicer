import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:servicer/main_pages/settings_pages/lock_screen/set_lockscreen_pin_repeat.dart';

class SetPin extends StatefulWidget {
  SetPin({Key? key}) : super(key: key);

  @override
  State<SetPin> createState() => _SetPinState();
}

class _SetPinState extends State<SetPin> {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  var formKey = GlobalKey<FormState>();
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
                const Text('PIN 번호를 입력해주세요. \n'),
                Pinput(
                  obscuringCharacter: '●',
                  focusNode: FocusNode(),
                  closeKeyboardWhenCompleted: false,
                  key: formKey,
                  autofocus: true,
                  length: 6,
                  obscureText: true,
                  pinAnimationType: PinAnimationType.scale,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  validator: (pin) {
                    return RegExp(r'^-?[0-9]+$').hasMatch(pin ?? '') && (pin!.length == 6) ? null : '6자리의 숫자를 입력해주세요. ';
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: false,
                  onCompleted: (pin) {
                    (RegExp(r'^-?[0-9]+$').hasMatch(pin) && (pin.length == 6))
                        ? Navigator.push(context, MaterialPageRoute(builder: ((context) => RepeatPin(inputtedPin: pin))))
                        : print('bad pin input');
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
