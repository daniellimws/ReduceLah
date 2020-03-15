import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:reducelah/services/leaderboard_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final databaseReference = Firestore.instance;

User me = User(id: "6", name: "Loser", points: 1, rank: 22);
LeaderboardData _leaderboardData = LeaderboardData(users: [
  User(id: '1', name: "Daniel Lim Wee Soong", points: 100, rank: 1),
  User(id: '2', name: "Ang Jie Liang", points: 10, rank: 2),
  User(id: '3', name: "Aaron Saw", points: 4, rank: 3),
  User(id: '4', name: "Lee Hsien Loong", points: 3, rank: 4),
  User(id: '5', name: "Salmon", points: 2, rank: 5)
], me: me);

class LeaderboardTab extends StatefulWidget {
  @override
  _LeaderboardTabState createState() => _LeaderboardTabState();
}

class _LeaderboardTabState extends State<LeaderboardTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6FBF5),
      appBar: AppBar(
        title: Text(
          'Leaderboard',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),

      body: FutureBuilder(
        builder: (context, leaderboardSnap) {
          if(!leaderboardSnap.hasData) {
            return Container();
          }
          return Column(
            children: <Widget>[
              new List<User>.from(leaderboardSnap.data.users).where((u) => u.id == leaderboardSnap.data.me.id).length == 0
                   ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _meCard(leaderboardSnap.data.me),
              )
                  : Container(width: 0, height: 0),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: _leaderboardList(leaderboardSnap.data.users, leaderboardSnap.data.me)),
              ),
            ],
          );
        },
        future: generateLeaderboard(),
      )
    );
  }

  Widget _leaderboardList(_users, _me) {
    return ListView.separated(
      itemCount: _users.length,
      separatorBuilder: (context, index) =>
          Divider(color: Colors.grey[400], indent: 24, endIndent: 24),
      itemBuilder: (context, index) {
        User user = _users[index];
        return _me.id == user.id ? _meCard(user) : _listItem(user, false, _me);
      },
    );
  }

  Widget _meCard(_me) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
          color: Colors.lightGreen,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: _listItem(_me, true, _me),
          )),
    );
  }

  Widget _listItem(User user, bool topCard, User _me) {
    return ListTile(
      title: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 14.0),
              child: Text(user.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Text(
              user.id == _me.id ? "ME" : "",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: topCard ? Colors.grey[800] : Colors.grey[500]),
            ),
          ),
        ],
      ),
      leading: Wrap(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(user.rank.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: topCard ? Colors.grey[900] : Colors.grey[600])),
            ),
          ),
          CircleAvatar(
              child: Text(user.name[0].toUpperCase(),
                  style: TextStyle(color: Colors.white)),
              backgroundColor:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)]),
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
                  color: topCard ? Colors.grey[900] : Colors.grey[800],
                )),
          ),
          Icon(Ionicons.ios_leaf,
              color: topCard ? Colors.grey[800] : Colors.lightGreen, size: 16)
        ],
        crossAxisAlignment: WrapCrossAlignment.center,
      ),
    );
  }
}

Future<LeaderboardData> generateLeaderboard() async {
  CollectionReference userRef = databaseReference.collection('users');
  QuerySnapshot leaderboardSnapshot = await databaseReference.collection('leaderboard').orderBy('total').limit(10).getDocuments();
  List<DocumentSnapshot> leaderboard = leaderboardSnapshot.documents;
  final FirebaseUser user = await _auth.currentUser();

  var futureList = Future.wait(
      leaderboard.asMap().entries.map((entry) async {
        int idx = entry.key;
        DocumentSnapshot d = entry.value;
        DocumentSnapshot userSnapshot = await userRef.document(d.data['uid']).get();
        return new User.fromSnapshot(userSnapshot.data, d.data, idx);
      }).toList());

  List<User> list = await futureList;

  DocumentSnapshot currLeaderboardSnapshot = await databaseReference.collection('leaderboard').document(user.uid).get();
  DocumentSnapshot currUserSnapshot = await userRef.document(user.uid).get();

  User currUser = new User.fromSnapshot(currUserSnapshot.data, currLeaderboardSnapshot.data, -1);

  LeaderboardData ld = LeaderboardData(users: list, me: currUser);

  return ld;
}
