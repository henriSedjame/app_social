// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    json['content'] as String,
    json['downloadUrl'] as String,
    json['ownerId'] as String,
  )
    ..id = json['id'] as String
    ..comments = (json['comments'] as List)
        ?.map((e) =>
            e == null ? null : PostComment.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..likes = (json['likes'] as List)
        ?.map((e) =>
            e == null ? null : PostLike.fromJson(e as Map<String, dynamic>))
        ?.toList()
    ..publicationDate = json['publicationDate'] as int;
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'downloadUrl': instance.downloadUrl,
      'ownerId': instance.ownerId,
      'comments': instance.comments?.map((e) => e?.toJson())?.toList(),
      'likes': instance.likes?.map((e) => e?.toJson())?.toList(),
      'publicationDate': instance.publicationDate,
    };
