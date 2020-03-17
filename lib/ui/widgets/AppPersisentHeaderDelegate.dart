import 'package:app_social/data/models/User.dart';
import 'package:app_social/ui/widgets/AppClikeableText.dart';
import 'package:app_social/ui/widgets/AppColors.dart';
import 'package:app_social/ui/widgets/AppDivider.dart';
import 'package:app_social/ui/widgets/AppProfileImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppPersisentHeaderDelegate extends SliverPersistentHeaderDelegate {

  User user;
  VoidCallback updateUserInfo;
  bool scrolled;
  bool isConnectedUser;

  AppPersisentHeaderDelegate(
      {@required this.user,
      @required this.updateUserInfo,
      @required this.scrolled,
      @required this.isConnectedUser});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      padding: EdgeInsets.all(10.0),
      color: ternaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          (scrolled)
              ? Container(
                  width: 0.0,
                  height: 0.0,
                )
              : textElement(
                  onTap: updateUserInfo,
                  text: '${user.prenom.toUpperCase()} ${user.nom.toUpperCase()}',
                  style: TextStyle(fontSize: 25.0),
                  context: context),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              AppProfileImage(
                onTap: null,
                src: user.imageUrl,
              ),
              textElement(
                  onTap: updateUserInfo,
                  text: user.description ?? 'Aucune description',
                  context: context)
            ],
          ),
          AppDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              textElement(
                  text: 'Followers : ${user.followers.length}',
                  context: context),
              textElement(
                  text: 'Followings : ${user.followings.length - 1}',
                  context: context),
            ],
          )
        ],
      ),
    );
  }

  Widget textElement({String text, TextStyle style, VoidCallback onTap, BuildContext context}) {
    return this.isConnectedUser
        ? AppClikeableText(
            onTap: onTap,
            text: text,
            style: style,
          )
        : Text(
            text,
            style: style,
          );
  }

  @override
  double get maxExtent => scrolled ? 120.0 : 200.0;

  @override
  double get minExtent => scrolled ? 120.0 : 200.0;

  @override
  bool shouldRebuild(AppPersisentHeaderDelegate oldDelegate) =>
      this.scrolled != oldDelegate.scrolled && this.user != oldDelegate.user;
}
