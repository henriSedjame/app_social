// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    json['nom'] as String,
    json['prenom'] as String,
    json['email'] as String,
    json['imageUrl'] as String,
  )
    ..id = json['id'] as String
    ..description = json['description'] as String
    ..followers = (json['followers'] as List)?.map((e) => e as String)?.toList()
    ..followings =
        (json['followings'] as List)?.map((e) => e as String)?.toList();
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'email': instance.email,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'followers': instance.followers,
      'followings': instance.followings,
    };
