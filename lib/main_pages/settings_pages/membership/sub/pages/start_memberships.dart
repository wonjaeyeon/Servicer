import 'package:flutter/material.dart';

class ChangeMemberShipPage extends StatefulWidget {
  ChangeMemberShipPage({Key? key}) : super(key: key);

  @override
  State<ChangeMemberShipPage> createState() => _ChangeMemberShipPageState();
}

class _ChangeMemberShipPageState extends State<ChangeMemberShipPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('멤버십 변경'),
      ),
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}
