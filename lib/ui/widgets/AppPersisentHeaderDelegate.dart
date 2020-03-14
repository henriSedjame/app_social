
import 'package:app_social/data/models/User.dart';
import 'package:app_social/ui/widgets/AppColors.dart';
import 'package:app_social/ui/widgets/AppDivider.dart';
import 'package:app_social/ui/widgets/AppProfileImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AppPersisentHeaderDelegate extends SliverPersistentHeaderDelegate {

  User user;
  VoidCallback callback;
  bool scrolled;


  AppPersisentHeaderDelegate({@required this.user, @required this.callback, @required this.scrolled});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      padding: EdgeInsets.all(10.0),
      color: ternaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          (scrolled) ? Container(width: 0.0, height: 0.0,) : Text('${user.prenom.toUpperCase()} ${user.nom.toUpperCase()}',
            style: TextStyle(
              fontSize: 25.0
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              AppProfileImage(onTap: null, src: user.imageUrl,),
              Text(user.description ?? 'Aucune description')
            ],
          ),
          AppDivider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InkWell(
                child: Text('Followers : ${user.followers.length}'),
              ),
              InkWell(
                child: Text('Followings : ${user.followings.length - 1}'),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => scrolled ? 120.0 : 200.0;

  @override
  double get minExtent => scrolled ? 120.0 : 200.0;

  @override
  bool shouldRebuild(AppPersisentHeaderDelegate oldDelegate) => this.scrolled != oldDelegate.scrolled && this.user != oldDelegate.user;

}