import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final databaseReference = Firestore.instance;

class User {
  String id;
  String name;
  int points;
  int rank;
  String photoUrl;

  User({this.id, this.name, this.points, this.rank});

  User.fromSnapshot(Map userSnapshot, Map leaderboardSnapshot, int rank):
        id = leaderboardSnapshot['uid'] ?? '',
        name = userSnapshot['displayName'] ?? '',
        photoUrl = userSnapshot['photoUrl'] ?? '',
        points = leaderboardSnapshot['total'] ?? 0,
        rank = rank ?? 100;
}

class LeaderboardData {
  List<User> users;
  User me;

  LeaderboardData({this.users, this.me});
}

Future<LeaderboardData> generateLeaderboard() async {
  CollectionReference userRef = databaseReference.collection('users');
  QuerySnapshot leaderboardSnapshot = await databaseReference.collection('leaderboard').orderBy('total', descending: true).limit(10).getDocuments();
  List<DocumentSnapshot> leaderboard = leaderboardSnapshot.documents;
  final FirebaseUser user = await _auth.currentUser();

  var futureList = Future.wait(
      leaderboard.asMap().entries.map((entry) async {
        int idx = entry.key;
        DocumentSnapshot d = entry.value;
        DocumentSnapshot userSnapshot = await userRef.document(d.data['uid']).get();
        return new User.fromSnapshot(userSnapshot.data, d.data, idx + 1);
      }).toList());

  List<User> list = await futureList;

  DocumentSnapshot currLeaderboardSnapshot = await databaseReference.collection('leaderboard').document(user.uid).get();
  DocumentSnapshot currUserSnapshot = await userRef.document(user.uid).get();

  User currUser = new User.fromSnapshot(currUserSnapshot.data, currLeaderboardSnapshot.data, -1);

  LeaderboardData ld = LeaderboardData(users: list, me: currUser);

  return ld;
}

Stream<LeaderboardData> getLeaderboardStream(){
  CollectionReference userRef = databaseReference.collection('users');
  Stream<QuerySnapshot> stream = databaseReference.collection('leaderboard').orderBy('total', descending: true).limit(10).snapshots();
  
  Stream<LeaderboardData> s = stream.map((QuerySnapshot leaderboardSnapshot){
      List<DocumentSnapshot> leaderboard = leaderboardSnapshot.documents;
      return LeaderboardData();

  });

  return s;
}


