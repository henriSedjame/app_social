
import 'package:json_annotation/json_annotation.dart';

part 'PostComment.g.dart';

@JsonSerializable()
class PostComment {
  String comment;
  String commenter;


  PostComment(this.comment, this.commenter);

  factory PostComment.fromJson(Map<String, dynamic> json) => _$PostCommentFromJson(json);

  Map<String, dynamic> toJson() => _$PostCommentToJson(this);
}