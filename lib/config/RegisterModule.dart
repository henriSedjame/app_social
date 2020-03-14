
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@registerModule
abstract class RegisterModule {

  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  Firestore get firestore => Firestore.instance;

  StorageReference get storage => FirebaseStorage.instance.ref();

}