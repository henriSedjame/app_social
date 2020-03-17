
import 'package:app_social/data/models/Post.dart';

typedef PostLikedFunc = void Function(Post, bool);
typedef AppFunction<R, T> = T Function(R);