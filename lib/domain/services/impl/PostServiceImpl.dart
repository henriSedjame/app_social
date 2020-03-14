import 'dart:io';

import 'package:app_social/data/models/LikeType.dart';
import 'package:app_social/data/models/Post.dart';
import 'package:app_social/data/models/PostLike.dart';
import 'package:app_social/data/models/User.dart';
import 'package:app_social/data/repositories/FileStorage.dart';
import 'package:app_social/data/repositories/PostRepository.dart';
import 'package:app_social/data/repositories/UserRepository.dart';
import 'package:app_social/domain/services/PostService.dart';
import 'package:injectable/injectable.dart';

@RegisterAs(PostService)
@Singleton(signalsReady: true)
class PostServiceImpl extends PostService {

  final PostRepository _postRepository;
  final FileStorage _fileStorage;

  PostServiceImpl(this._postRepository, this._fileStorage);

  @override
  Future<void> save(String postContent, File file, String userId) {
    String id;

    var post = Post(postContent, null, userId)
      ..publicationDate = DateTime.now().millisecondsSinceEpoch.toInt()
      ..comments = []
      ..likes = [];

    return this._postRepository.saveIntoParent(userId, post).then((value){
      id = value;
      return this._fileStorage.storePostFile(file, value, userId).then((downloadUrl) {
        var updatedPost = post
          ..downloadUrl = downloadUrl
          ..id = id;
        return this
            ._postRepository
            .updateIntoParent(userId, updatedPost);
      });
    });
  }

  @override
  Stream<List<Post>> watchUserPosts(String userId) {
    return this._postRepository.snapshotsFromParent(userId)
        .map((event) => event.documents.map((doc) => Post.fromJson(doc.data)).toList());
  }

  @override
  Future<void> addLike(Post post, User liker, String ownerId) {
    post.likes.add(PostLike(LikeType.LOVE, '${liker.prenom} ${liker.nom}', liker.id));
    return this._postRepository.updateIntoParent(ownerId, post);
  }

  @override
  Future<void> removeLike(Post post, User liker, String ownerId) {
    var likeToRemove = post.likes.firstWhere((element) => element.likerId == liker.id);
    if (likeToRemove != null) {
      post.likes.remove(likeToRemove);
      return this._postRepository.updateIntoParent(ownerId, post);
    }
  }
}
