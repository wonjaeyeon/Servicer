import 'package:flutter/material.dart';
import 'package:servicer/main_pages/settings_pages/membership/main_page_subscribed.dart';
import 'package:servicer/main_pages/settings_pages/settings_main_page.dart';

import 'main_page_unsubscribed.dart';

class MembershipMainPage extends StatefulWidget {
  MembershipMainPage({Key? key}) : super(key: key);

  @override
  State<MembershipMainPage> createState() => _MembershipMainPageState();
}

class _MembershipMainPageState extends State<MembershipMainPage> {
  @override
  Widget build(BuildContext context) {
    return membershipLevel == 1 ? MembershipMainPageUnsucscribed() : MembershipMainPageSubscribed();
  }
}
