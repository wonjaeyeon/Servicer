import 'package:flutter/material.dart';

class MembershipInfoPage extends StatefulWidget {
  MembershipInfoPage({Key? key}) : super(key: key);

  @override
  State<MembershipInfoPage> createState() => _MembershipInfoPageState();
}

class _MembershipInfoPageState extends State<MembershipInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Membership Info'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('멤버십 정보'),
          ],
        ),
      ),
    );
  }
}
