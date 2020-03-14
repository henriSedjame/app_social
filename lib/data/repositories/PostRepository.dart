
import 'package:app_social/data/Tables.dart';
import 'package:app_social/data/repositories/BaseRepository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@Singleton(signalsReady: true)
class PostRepository extends BaseRepository {

  Firestore _firestore;

  PostRepository(this._firestore);

  @override
  CollectionReference get collectionRef => this._firestore.collection(Tables.POSTS);

  @override
  CollectionReference get parentCollectionRef => this._firestore.collection(Tables.USERS);

}