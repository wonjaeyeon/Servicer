import 'package:flutter/material.dart';

class ManagePaymentPage extends StatefulWidget {
  ManagePaymentPage({Key? key}) : super(key: key);

  @override
  State<ManagePaymentPage> createState() => _ManagePaymentPageState();
}

class _ManagePaymentPageState extends State<ManagePaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('결제 수단 관리'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text('결제 수단 관리'),
          ],
        ),
      ),
    );
  }
}
