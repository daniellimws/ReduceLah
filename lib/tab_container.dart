import 'package:flutter/material.dart';

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
  List<Widget> listScreens;
  List<int> listScreensIndex;

  int tabIndex = 0;
  @override
  void initState() {
    super.initState();
    listScreens = [
      EmptyTab(),
      EmptyTab(),
      LeaderboardTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.greenAccent,
      home: Scaffold(
        body: listScreens[tabIndex],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
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
                icon: Icon(Icons.assessment),
                title: Text('Leaderboard'),
              ),
            ]),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}