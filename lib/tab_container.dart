import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:reducelah/tabs/achievements_tab.dart';
import 'package:reducelah/tabs/rewards_tab.dart';

import 'tabs/leaderboard_tab.dart';
import 'tabs/empty_tab.dart';

class TabContainer extends StatefulWidget {
  TabContainer({Key key}) : super(key: key);

  @override
  _TabContainerState createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  List<Widget> originalList;
  Map<int, bool> originalDic;
  List<Widget> listScreens = [
    EmptyTab(),
    RewardsTab(),
    AchievementsTab(),
    LeaderboardTab(),
  ];
  List<int> listScreensIndex;

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterNfcReader.onTagDiscovered().listen((onData) {
      Navigator.of(context).pushNamed("/nfc");
    });

    return MaterialApp(
      color: Colors.greenAccent,
      home: Scaffold(
        body: IndexedStack(
          index: tabIndex,
          children: listScreens,
        ),
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.grey[600],
            currentIndex: tabIndex,
            onTap: (int index) {
              setState(() {
                tabIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Dashboard'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard),
                title: Text('Rewards'),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesome.trophy),
                title: Text('Achievements'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.assessment),
                title: Text('Leaderboard'),
              ),
            ]),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
