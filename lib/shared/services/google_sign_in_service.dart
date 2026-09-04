import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  GoogleSignInService._();

  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static Future<void>? _initialization;

  static Future<void> _ensureInitialized() {
    return _initialization ??= _googleSignIn.initialize();
  }

  static Future<UserCredential> signInWithGoogle() async {
    await _ensureInitialized();

    if (!_googleSignIn.supportsAuthenticate()) {
      throw UnsupportedError(
        'Login com Google não está disponível nesta plataforma.',
      );
    }

    final googleAccount = await _googleSignIn.authenticate();
    final googleAuthentication = googleAccount.authentication;
    final idToken = googleAuthentication.idToken;

    if (idToken == null || idToken.isEmpty) {
      throw StateError('O Google não retornou um ID token válido.');
    }

    final firebaseCredential = GoogleAuthProvider.credential(idToken: idToken);

    return FirebaseAuth.instance.signInWithCredential(firebaseCredential);
  }

  static Future<void> signOut() async {
    await _ensureInitialized();
    await _googleSignIn.signOut();
  }
}
