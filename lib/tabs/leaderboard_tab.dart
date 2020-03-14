import 'package:flutter/material.dart';

class LeaderboardTab extends StatefulWidget {
  @override
  _LeaderboardTabState createState() => _LeaderboardTabState();
}

class _LeaderboardTabState extends State<LeaderboardTab>
    with AutomaticKeepAliveClientMixin<LeaderboardTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Leaderboard',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          'This is content of Tab1',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
