import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final databaseReference = Firestore.instance;

class User {
  int id;
  String name;
  int points;
  int rank;

  User({this.id, this.name, this.points, this.rank});
}

class LeaderboardData {
  List<User> users;
  User me;

  LeaderboardData({this.users, this.me});
}

void generateLeaderboard() async {

}
