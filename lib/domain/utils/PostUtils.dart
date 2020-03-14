
import 'package:app_social/data/models/Post.dart';

class PostUtils {

  static bool isLikedBy(Post post, String userId){
    return post.likes?.map((like) => like.likerId)?.contains(userId) ?? false;
  }
}