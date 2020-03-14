
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/models/BaseModel.dart';

abstract class BaseRepository<T extends BaseModel> {

  CollectionReference get collectionRef;

  CollectionReference get parentCollectionRef;

  /* save an entity and return the document ID */
  Future<String> save(T t) {
    return collectionRef.add(t.toJson()).then((value) => value.documentID);
  }

  /* Save child entity into parent */
  Future<String> saveIntoParent(String parentId, T t) {
    return _childCollection(parentId)
        .add(t.toJson())
        .then((value) => value.documentID);
  }

  /* Update child entoty into parent */
  Future<void> updateIntoParent(String parentId, T t) {
    _childCollection(parentId)
        .document(t.id)
        .setData(t.toJson());
  }

  /* update an entity */
  Future<void> update(T t) {
    return collectionRef.document(t.id).setData(t.toJson());
  }

  /* Find an entity by id */
  Future<Map<String, dynamic>> findById(String id) {
    return collectionRef.where('id', isEqualTo: id)
        .getDocuments()
        .then((value) => value.documents.first)
        .then((value) => value.data);
  }

  /* watch all snapshots of an entity from its parent*/
  Stream<QuerySnapshot> snapshotsFromParent(String parentId) {
    return _childCollection(parentId).snapshots();
  }

  CollectionReference _childCollection(String parentId) {
    return parentCollectionRef.document(parentId)
        .collection(collectionRef.path);
  }

}