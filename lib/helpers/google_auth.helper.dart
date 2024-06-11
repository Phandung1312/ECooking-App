
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthHelper{
  static Future<String?> handleSignIn() async{
    try{
      final googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication =
      await googleUser?.authentication;
      return googleSignInAuthentication?.idToken ;
    }
    catch (error){
      return null;
    }
  }
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
    'https://www.googleapis.com/auth/userinfo.profile'
  ],
);
