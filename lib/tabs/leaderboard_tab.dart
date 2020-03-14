import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:reducelah/services/leaderboard_service.dart';

User me = User(name: "Daniel Lim", points: 100, rank: 1);
LeaderboardData _leaderboardData = LeaderboardData(users: [
  User(name: "Daniel Lim", points: 100, rank: 1),
  User(name: "Ang Jie Liang", points: 10, rank: 2),
  User(name: "Aaron Saw", points: 4, rank: 3),
  User(name: "Lee Hsien Loong", points: 2, rank: 4),
  User(name: "Salmon", points: 1, rank: 5)
], me: me);

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
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: ListView.separated(
            itemCount: _leaderboardData.users.length,
            separatorBuilder: (context, index) =>
                Divider(color: Colors.grey[400], indent: 24, endIndent: 24),
            itemBuilder: (context, index) {
              User user = _leaderboardData.users[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 0),
                child: ListTile(
                  title: Text(user.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  leading: Wrap(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(user.rank.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600])),
                        ),
                      ),
                      CircleAvatar(
                          child: Text(user.name[0].toUpperCase(),
                              style: TextStyle(color: Colors.white)),
                          backgroundColor: Colors.primaries[
                              Random().nextInt(Colors.primaries.length)]),
                    ],
                    crossAxisAlignment: WrapCrossAlignment.center,
                  ),
                  trailing: Wrap(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: Text(user.points.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            )),
                      ),
                      Icon(Ionicons.ios_leaf,
                          color: Colors.lightGreen, size: 16)
                    ],
                    crossAxisAlignment: WrapCrossAlignment.center,
                  ),
                ),
              );
            },
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
