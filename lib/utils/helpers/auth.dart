import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';




///Signs in the user using Google and Firebase auth
Future<User?> signIn() async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  await googleSignIn.signOut();
  final GoogleSignInAccount? googleUser = await (googleSignIn.signIn());
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Create a new credential
  final GoogleAuthCredential googleCredential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  ) as GoogleAuthCredential;

  // Once signed in, return the UserCredential
  UserCredential credential =
      await firebaseAuth.signInWithCredential(googleCredential);
  User user = credential.user!;

  assert(!user.isAnonymous);
  // assert (await user.getIdToken() != null);

  final User currentUser = firebaseAuth.currentUser!;
  assert(currentUser.uid == user.uid);

  return user;
}



///Signs out the user
Future signOut() async {
  FirebaseAuth auth = FirebaseAuth.instance;

  await auth.signOut();
}
