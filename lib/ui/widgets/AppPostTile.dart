
import 'package:app_social/data/models/Post.dart';
import 'package:app_social/data/models/User.dart';
import 'package:app_social/domain/utils/PostUtils.dart';
import 'package:app_social/ui/widgets/AppColors.dart';
import 'package:app_social/ui/widgets/AppDivider.dart';
import 'package:app_social/ui/widgets/AppIcons.dart';
import 'package:app_social/ui/widgets/AppProfileImage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../extensions/StringExtension.dart';
import 'AppPadding.dart';
import 'AppTypeDefs.dart';

class AppPostTile extends StatelessWidget {

  final Post post;
  final User user;
  final bool showDetail;
  final PostLikedFunc onPostLiked;

  const AppPostTile({Key key, @required this.post, @required this.user, this.showDetail, @required this.onPostLiked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Card(
        elevation: 3.0,
        child: AppPadding(
          top: 10.0,
          bottom: 10.0,
          child: Column(
            children: <Widget>[
              AppPadding(
                top: 5.0,
                bottom: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppProfileImage(
                      src: user.imageUrl,
                      onTap: null,
                      size: 15.0,
                    ),
                    Column(
                      children: <Widget>[
                        Text('${user.prenom} ${user.nom}'),
                        Text(
                            DateTime.fromMillisecondsSinceEpoch(post.publicationDate).toIso8601String(),
                          style: TextStyle(
                            color: blueLight,
                            fontStyle: FontStyle.italic
                          ),
                        ),

                      ],
                    )
                  ],
                ),
              ),
              postImage(context),
              postContent(context),
              likeBar(context),
            ],
          )
        ),
      ),
    );
  }

  Widget postImage(BuildContext context){

    if (post.downloadUrl.isNotBlank) {
      return Column(
        children: <Widget>[

          AppDivider( color: secondaryColor, width: MediaQuery.of(context).size.width*0.9, paddingBottom: 10.0,),

          Container(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.width * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              image: DecorationImage(
                image: CachedNetworkImageProvider(post.downloadUrl),
                fit: BoxFit.cover
              )
            ),
          ),
        ],
      );
    } else {
      return Container(height: 0.0,);
    }
  }

  Widget postContent(BuildContext context) {

    if (post.content.isNotBlank) {

      return Column(
        children: <Widget>[
          AppDivider( color: secondaryColor, width: MediaQuery.of(context).size.width*0.9, paddingBottom: 10.0,),
          Text(post.content)
        ],
      );
    } else {
      return Container(height: 0.0,);
    }
  }

  Widget likeBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: PostUtils.isLikedBy(post, user.id) ? likedIcon : likeableIcon,
                onPressed: PostUtils.isLikedBy(post, user.id) ? () => onPostLiked(post, false) : () => onPostLiked(post, true),
              ),
              Text('${post.likes.length}')
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 15.0),
          width: MediaQuery.of(context).size.width * 0.45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                icon: msgIcon,
                onPressed: (){},
              ),
              Text('${post.comments.length}')
            ],
          ),
        )
      ],
    );
  }

}
