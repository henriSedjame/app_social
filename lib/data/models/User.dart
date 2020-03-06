
import 'package:json_annotation/json_annotation.dart';

import 'BaseModel.dart';

part 'User.g.dart';

@JsonSerializable()
class User extends BaseModel {

  String nom;
  String prenom;
  String email;
  String imageUrl;
  List<String> followers;
  List<String> followings;

  User(this.nom, this.prenom, this.email, this.imageUrl);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

}