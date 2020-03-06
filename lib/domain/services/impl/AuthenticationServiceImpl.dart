
import 'package:app_social/domain/services/AuthenticationService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@RegisterAs(AuthenticationService)
@injectable
class AuthenticationServiceImpl extends AuthenticationService {

  FirebaseAuth _firebaseAuth;

  AuthenticationServiceImpl(this._firebaseAuth);

  @override
  Stream<FirebaseUser> get authStream => this._firebaseAuth.onAuthStateChanged;

  @override
  Future<AuthResult> create({String email, String password}) => this._firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);


  @override
  Future<AuthResult> login({String email, String password}) => this._firebaseAuth.signInWithEmailAndPassword(email: email, password: password);


  @override
  Future<void> logout() => this._firebaseAuth.signOut();

}