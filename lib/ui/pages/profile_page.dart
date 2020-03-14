import 'package:app_social/data/models/Post.dart';
import 'package:app_social/data/models/User.dart';
import 'package:app_social/domain/services/AuthenticationService.dart';
import 'package:app_social/domain/services/PostService.dart';
import 'package:app_social/ui/stores/AppGlobalStore.dart';
import 'package:app_social/ui/stores/ProfilePageStore.dart';
import 'package:app_social/ui/utils/ToasterUtils.dart';
import 'package:app_social/ui/widgets/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../widgets/AppWidgets.dart';

class ProfilePage extends StatefulWidget {
  String userId;

  ProfilePage(this.userId, {Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  AuthenticationService _authenticationService;
  PostService _postService;
  AppGlobalStore _globalStore;
  ProfilePageStore _store;
  ScrollController _scrollController;
  bool myOwnProfile;
  static final double _expandedHeight = 200.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    this._globalStore ??= GetIt.instance<AppGlobalStore>();
    this._store ??= GetIt.instance<ProfilePageStore>();
    this._postService ??= GetIt.instance<PostService>();
    this._authenticationService ??= GetIt.instance<AuthenticationService>();

    this.myOwnProfile = this._globalStore.currentUser.id == widget.userId;

    if (!this.myOwnProfile) {
      this._store.loadUser(widget.userId);
    }
  }

  @override
  void initState() {
    super.initState();
    this._scrollController = ScrollController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    this._scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext ctx) {
        var user = this.myOwnProfile ? this._globalStore.currentUser : this._store.user;
        return postsView(user);
      },
    );
  }

  StreamBuilder<List<Post>> postsView(User user) {
    return StreamBuilder<List<Post>>(
      stream: this._postService.watchUserPosts(widget.userId),
      builder: (BuildContext ctx, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.hasData) {
          List<Post> posts = snapshot.data;

          return CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: _expandedHeight,
                pinned: true,
                actions: <Widget>[
                  myOwnProfile ? IconButton(
                    icon:logoutIcon,
                    onPressed: () => ToasterUtils.showLogOutDialog(context, () => logout(context)),
                  ) : Text('SUIVRE')
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: _showTitle
                      ? Text('${user.nom} ${user.prenom}')
                      : Text(''),
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: appProfilImage, fit: BoxFit.cover),
                    ),
                    child: Center(
                      child: AppProfileImage(
                        src: user.imageUrl,
                        size: 45.0,
                        onTap: () {},
                      ),
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: AppPersisentHeaderDelegate(
                    user: user, scrolled: _showTitle, callback: () {}),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (ctx, index) => buildSliverChild(index, posts, user),
                    childCount: posts.length + 1),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }

  bool get _showTitle =>
      this._scrollController.hasClients &&
      this._scrollController.offset > (_expandedHeight - kToolbarHeight);

  Widget buildSliverChild(int index, List<Post> posts, User user) {
    if (index == posts.length) {
      return Container(
        height: 50.0,
      );
    }
    return AppPostTile(
      post: posts[index],
      user: user,
      onPostLiked: (Post p, bool add) => likePost(p, user, add),
    );
  }

  void likePost(Post post, User liker, bool add){
    if (add) {
      this._postService.addLike(post, liker, this._globalStore.currentUser.id);
    } else {
      this._postService.removeLike(post, liker, this._globalStore.currentUser.id);
    }
  }

  void logout(BuildContext context) {
    Navigator.pop(context);
    this._authenticationService.logout();
  }
}
