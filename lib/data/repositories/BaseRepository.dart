
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/BaseModel.dart';

abstract class BaseRepository<T extends BaseModel> {

  CollectionReference get collectionRef;

  /* save an entity and return the document ID */
  Future<String> save(T t) {
    return collectionRef.add(t.toJson()).then((value) => value.documentID);
  }

  /* Find an entity by id */
  Future<Map<String, dynamic>> findById(String id) {
    return collectionRef.where('id', isEqualTo: id)
        .getDocuments()
        .then((value) => value.documents.first)
        .then((value) => value.data);
  }

}