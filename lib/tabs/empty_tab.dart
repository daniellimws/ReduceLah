import 'package:flutter/material.dart';

class EmptyTab extends StatefulWidget {
  @override
  _EmptyTabState createState() => _EmptyTabState();
}

class _EmptyTabState extends State<EmptyTab>
    with AutomaticKeepAliveClientMixin<EmptyTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empty', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'Replace this tab',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}