
import 'package:app_social/data/models/BaseModel.dart';
import 'package:app_social/data/models/PostComment.dart';
import 'package:app_social/data/models/PostLike.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Post.g.dart';

@JsonSerializable(explicitToJson: true)
class Post extends BaseModel {

  String content;
  String downloadUrl;
  String ownerId;
  List<PostComment> comments;
  List<PostLike> likes;
  int publicationDate;

  Post(this.content, this.downloadUrl, this.ownerId);

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PostToJson(this);

}