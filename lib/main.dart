import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';

import 'nfc_detected_page.dart';
import 'tab_container.dart';
import 'login_page.dart';

void main() => runApp(ReduceLah());

class ReduceLah extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ReduceLah',
        theme: ThemeData(primaryColor: Colors.green),
        initialRoute: "/login",
        routes: {
          "/main": (context) => TabContainer(),
          "/nfc": (context) => NFCDetectedPage(),
          "/login": (context) => LoginPage(),
        });
  }
}
