import 'package:firebase/models/fb_response.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FbAuthController {
  ///Functions:
  /// 1) singInWithEmailAndPassword
  /// 2) createAccountWitheEmailAndPassword
  /// 3) singOut
  /// 4) forgetPassword
  ///

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FpResponse> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user!.emailVerified) {
        return FpResponse('Logged In Successfully', true);
      } else {
        await userCredential.user!.sendEmailVerification();
        return FpResponse('Verify your email', false);
      }
    } on FirebaseAuthException catch (e) {
      return FpResponse(e.message ?? '', false);
    } catch (e) {
      return FpResponse('Something went wrong', false);
    }
  }

  Future<FpResponse> createAccount(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.sendEmailVerification();
      return FpResponse('Register successfully, verify email', true);
    } on FirebaseAuthException catch (e) {
      return FpResponse(e.message ?? '', false);
    } catch (e) {
      return FpResponse('Something went wrong', false);
    }
  }

  Future<void> singOut() async {
    await _auth.signOut();
  }

  User get currentUser => _auth.currentUser!;

  Future<FpResponse> forgetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return FpResponse('Reset Email sent successfully', true);
    } on FirebaseAuthException catch (e) {
      return FpResponse(e.message ?? '', false);
    } catch (e) {
      return FpResponse('Something went wrong', false);
    }
  }
}
