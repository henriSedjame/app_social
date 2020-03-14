
import 'package:json_annotation/json_annotation.dart';

import 'LikeType.dart';

part 'PostLike.g.dart';

@JsonSerializable()
class PostLike {
  LikeType type;
  String likerName;
  String likerId;

  PostLike(this.type, this.likerName, this.likerId);

  factory PostLike.fromJson(Map<String, dynamic> json) => _$PostLikeFromJson(json);

  Map<String, dynamic> toJson() => _$PostLikeToJson(this);
}
