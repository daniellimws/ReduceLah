import 'package:flutter/material.dart';

import 'tab_container.dart';

void main() => runApp(ReduceLah());

class ReduceLah extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ReduceLah',
      theme: ThemeData(
        primaryColor: Colors.green
      ),
      home: TabContainer(),
    );
  }
}