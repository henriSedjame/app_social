
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationService {

  Stream<FirebaseUser> get authStream;

  Future<AuthResult> create({String email, String password});

  Future<AuthResult> login({String email, String password});

  Future<void> logout();
}