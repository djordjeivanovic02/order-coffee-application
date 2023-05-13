import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ordercoffee/firebase_options.dart';
import 'package:ordercoffee/services/auth/auth_exceptions.dart';
import 'package:ordercoffee/services/auth/auth_provider.dart';
import 'package:ordercoffee/services/auth/auth_user.dart';

class FirebaseAuthProvider extends AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw InvalidEmailException();
        case 'user-disabled':
          throw UserDisabledException();
        case 'user-not-found':
          throw UserNotFoundException();
        case 'wrong-password':
          throw WrongPasswordException();
        case 'too-many-requests':
          throw TooManyRequestsException();
        case 'operation-not-allowed':
          throw OperationNotAllowedException();
        case 'account-exists-with-different-credential':
          throw AccountExistWithDifferentCredentialException();
        case 'weak-password':
          throw WeakPasswordException();
        default:
          throw GenericException();
      }
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  AuthUser? get currentUser {
    User? current = FirebaseAuth.instance.currentUser;
    if (current != null) {
      return AuthUser.fromFirebase(current);
    }
    return null;
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInException();
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case 'invalid-email':
          throw InvalidEmailException();
        case 'user-disabled':
          throw UserDisabledException();
        case 'user-not-found':
          throw UserNotFoundException();
        case 'wrong-password':
          throw WrongPasswordException();
        case 'too-many-requests':
          throw TooManyRequestsException();
        case 'operation-not-allowed':
          throw OperationNotAllowedException();
        case 'account-exists-with-different-credential':
          throw AccountExistWithDifferentCredentialException();
        case 'weak-password':
          throw WeakPasswordException();
        default:
          throw GenericException();
      }
    } catch (_) {
      throw GenericException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInException();
    }
  }

  @override
  Future<void> sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInException();
    }
  }
}
