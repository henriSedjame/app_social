
import 'dart:io';

import 'package:app_social/data/models/Post.dart';
import 'package:app_social/data/models/User.dart';

abstract class PostService {
  
  Future<void> save(String postContent, File file, String userId);

  Stream<List<Post>> watchUserPosts(String userId);

  Future<void> addLike(Post post, User liker, String ownerId);

  Future<void> removeLike(Post post, User liker, String ownerId);
}