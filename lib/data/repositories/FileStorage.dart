
import 'dart:io';

import 'package:app_social/data/Tables.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@Singleton(signalsReady: true)
class FileStorage {

  StorageReference _storage;

  FileStorage(this._storage);

  Future<String> storeFile(File file, String id) async {
    if (file == null) {
      return Future.value('');
    }
    var storageReference = this._storage.child(id);
    return await _store(storageReference, file);
  }

  Future<String> storePostFile(File file, String postId, String userId) async {
    if (file == null) {
      return Future.value('');
    }
    var storageReference = this._storage.child(Tables.POSTS).child(userId).child(postId);
    return await _store(storageReference, file);
  }

  Future<String> _store(StorageReference storageReference, File file) async {
    StorageUploadTask task = await storageReference.putFile(file);
    StorageTaskSnapshot taskSnapshot = await task.onComplete;
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }
}