// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostComment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostComment _$PostCommentFromJson(Map<String, dynamic> json) {
  return PostComment(
    json['comment'] as String,
    json['commenter'] as String,
  );
}

Map<String, dynamic> _$PostCommentToJson(PostComment instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'commenter': instance.commenter,
    };
