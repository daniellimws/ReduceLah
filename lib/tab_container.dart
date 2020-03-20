import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:nfc_in_flutter/nfc_in_flutter.dart';
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
  List<Widget> listScreens;
  List<int> listScreensIndex;

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    listScreens = [
      EmptyTab(),
      RewardsTab(),
      AchievementsTab(),
      LeaderboardTab(),
    ];

    _prepareNFCListener(context);
  }

  void _prepareNFCListener(BuildContext context) {
    NFC.readNDEF().first.then((NDEFMessage message) {
      int type = int.parse(message.payload);
      NFC
          .writeNDEF(
              NDEFMessage.withRecords([NDEFRecord.type("text/plain", "4")]))
          .first;
      print(type);
      if (type >= 1 && type <= 3) {
        Navigator.of(context).pushNamed("/nfc", arguments: type);
        print("Clearing");
      }

      _prepareNFCListener(context);
    }, onError: (e) {
      _prepareNFCListener(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.greenAccent,
      home: Scaffold(
        body: listScreens[tabIndex],
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
