import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/User.dart';
import 'BaseRepository.dart';

@injectable
class UserRepository extends BaseRepository<User> {

  Firestore _firestore;

  UserRepository(this._firestore);

  @override
  CollectionReference get collectionRef => this._firestore.collection('users');

}