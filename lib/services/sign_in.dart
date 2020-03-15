import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final databaseReference = Firestore.instance;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final FirebaseUser currentUser = await _auth.currentUser();
  assert(user.uid == currentUser.uid);

  assert(user.displayName != null);
  assert(user.email != null);
  assert(user.photoUrl != null);

  createUser();

  print(user.displayName);

  return 'signInWithGoogle succeeded: $user';
}

void signOutGoogle() async{
  await googleSignIn.signOut();
  print("User Sign Out");
}

void createUser() async {
  
  final FirebaseUser user = await _auth.currentUser();
  
  DocumentReference userRef = databaseReference.collection('users').document(user.uid);
  DocumentReference leaderboardRef = databaseReference.collection('leaderboard').document(user.uid);

  userRef.get()
      .then((docSnapshot) => {
        if(docSnapshot.exists) {
          userRef.updateData({
            'displayName': user.displayName,
            'email': user.email,
            'photoUrl': user.photoUrl
          })
        } else {
          userRef.setData({
            'displayName': user.displayName,
            'email': user.email,
            'photoUrl': user.photoUrl
          }).then((_) => {
            leaderboardRef.setData({
              'uid': user.uid,
              'straw': 0,
              'bag': 0,
              'container': 0,
              'total': 0,
            })
          })
        }
      });
}