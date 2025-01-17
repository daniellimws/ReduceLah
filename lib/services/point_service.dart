import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final databaseReference = Firestore.instance;

enum ReduceType {
  plastic,
  bag,
  container
}

class Points {
  String id;
  int total = 0;
  int bag = 0;
  int straw = 0;
  int container = 0;
  var redeemed = [];

  Points({this.id, this.total, this.bag, this.straw, this.container});

  Points.fromMap(Map map):
        id = map['uid'] ?? '',
        total = map['total'] ?? 0,
        bag = map['bag'] ?? 0,
        straw = map['straw'] ?? 0,
        container = map['container'] ?? 0;

  Points.fromAllMap(Map map):
        id = map['uid'] ?? '',
        total = map['total'] ?? 0,
        bag = map['bag'] ?? 0,
        straw = map['straw'] ?? 0,
        container = map['container'] ?? 0,
        redeemed = map['redeemed'] ?? [];
}

Future<Points> getPoints() async {
  final FirebaseUser user = await _auth.currentUser();
  DocumentSnapshot pointsSnapshot = await databaseReference.collection('leaderboard').document(user.uid).get();
  return Points.fromMap(pointsSnapshot.data);
}

void addPoint(ReduceType type) async {
  final FirebaseUser user = await _auth.currentUser();

  await databaseReference.collection('leaderboard').document(user.uid).updateData({
    type.toString() : FieldValue.increment(1),
    'total': FieldValue.increment(1),
  });
}

Stream<Points> getPointsStream(String uid) {
  return databaseReference.collection('total').document(uid).snapshots().map((DocumentSnapshot snapshot) {
      return new Points.fromAllMap(snapshot.data);
  });
}


