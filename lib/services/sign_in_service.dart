import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<FirebaseUser> signInWithGoogle() async {
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

  return currentUser;
}

Future signOutGoogle() async {
  await googleSignIn.signOut();
  _auth.signOut();
  print("User Sign Out");
}

Future<FirebaseUser> loginWithEmail({
  @required String email,
  @required String password,
}) async {
  try {
    var authResult = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return authResult.user;
  } catch (e) {
    return null;
  }
}

Future signUpWithEmail(String email, String password, String fullName) async {
  try {
    var authResult = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return authResult.user != null;
  } catch (e) {
    return e.message;
  }
}

Future<FirebaseUser> getLoggedUser() async {
  var user = await _auth.currentUser();
  return user;
}
