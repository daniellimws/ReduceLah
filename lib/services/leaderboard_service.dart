import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final databaseReference = Firestore.instance;

class User {
  String id;
  String name;
  int points;
  int rank;

  User({this.id, this.name, this.points, this.rank});

  User.fromMap(Map userSnapshot, Map leaderboardSnapshot):
      id = userSnapshot['uid'] ?? '',
      name = userSnapshot['displayName'] ?? '',
      points = leaderboardSnapshot['total'] ?? 0,
      rank = leaderboardSnapshot['rank'] ?? 100;

  User.fromSnapshot(Map userSnapshot, Map leaderboardSnapshot, int rank):
        id = userSnapshot['uid'] ?? '',
        name = userSnapshot['displayName'] ?? '',
        points = leaderboardSnapshot['total'] ?? 0,
        rank = rank ?? 100;
}

class LeaderboardData {
  List<User> users;
  User me;

  LeaderboardData({this.users, this.me});
}

Future<List<User>> generateLeaderboard() async {
  Query leaderboardRef = databaseReference.collection('leaderboard').orderBy('total').limit(10);
  CollectionReference userRef = databaseReference.collection('users');

  QuerySnapshot leaderboardSnapshot = await databaseReference.collection('leaderboard').orderBy('total').getDocuments();
  List<DocumentSnapshot> leaderboard = leaderboardSnapshot.documents;

  final FirebaseUser user = await _auth.currentUser();

  List<User> users = [];

  var futureList = Future.wait(
      leaderboard.asMap().entries.map((entry) async {
        int idx = entry.key;
        DocumentSnapshot d = entry.value;
        DocumentSnapshot userSnapshot = await userRef.document(d.data['uid']).get();
        return new User.fromSnapshot(userSnapshot.data, d.data, idx);
      }).toList());

  DocumentSnapshot currLeader = await databaseReference.collection('leaderboard').document(user.uid).get();
  DocumentSnapshot currUser = await userRef.document(user.uid).get();

  return futureList;
}

