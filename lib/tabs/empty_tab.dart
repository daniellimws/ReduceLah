import 'package:flutter/material.dart';

class EmptyTab extends StatefulWidget {
  @override
  _EmptyTabState createState() => _EmptyTabState();
}

class _EmptyTabState extends State<EmptyTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Empty',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
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
}
