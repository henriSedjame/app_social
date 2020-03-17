import 'package:app_social/data/models/Post.dart';
import 'package:app_social/data/models/User.dart';
import 'package:app_social/domain/services/AuthenticationService.dart';
import 'package:app_social/domain/services/PostService.dart';
import 'package:app_social/ui/pages/change_image_view.dart';
import 'package:app_social/ui/pages/update_user_info_view.dart';
import 'package:app_social/ui/stores/AppGlobalStore.dart';
import 'package:app_social/ui/stores/ProfilePageStore.dart';
import 'package:app_social/ui/utils/ToasterUtils.dart';
import 'package:app_social/ui/utils/UIUtils.dart';
import 'package:app_social/ui/widgets/AppImages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../widgets/AppWidgets.dart';
import '../../extensions/StringExtension.dart';

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
        var user = this.myOwnProfile
            ? this._globalStore.currentUser
            : this._store.user;
        return postsView(user);
      },
    );
  }

  bool get _showTitle =>
      this._scrollController.hasClients &&
      this._scrollController.offset > (_expandedHeight - kToolbarHeight);

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
                actions: <Widget>[popUpMenu(context, user)],
                flexibleSpace: FlexibleSpaceBar(
                  title: _showTitle
                      ? Text('${user.nom} ${user.prenom}')
                      : Text(''),
                  background: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: (user.coverUrl.isNotBlank)
                              ? CachedNetworkImageProvider(user.coverUrl)
                              : appProfilImage,
                          fit: BoxFit.cover),
                    ),
                    child: Center(
                      child: AppProfileImage(
                        src: user.imageUrl,
                        size: 45.0,
                        onTap: () => updateProfilImage(context, user),
                      ),
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: AppPersisentHeaderDelegate(
                    user: user,
                    scrolled: _showTitle,
                    isConnectedUser: myOwnProfile,
                    updateUserInfo: () => this.updateUserInfo(context, user)),
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

  PopupMenuButton popUpMenu(BuildContext context, User user) {
    return PopupMenuButton(
      itemBuilder: (ctx) => [
        PopupMenuItem(
            child: FlatButton(
                child: Text('Modifier la couverture'),
                onPressed: () {
                  Navigator.pop(ctx);
                  updateCoverImage(context, user);
                })),
        PopupMenuItem(
          height: 1.0,
          child: AppDivider(
            color: ternaryColor,
            paddingTop: 1.0,
            paddingBottom: 1.0,
          ),
        ),
        PopupMenuItem(
          child: FlatButton(
            child: Text('Deconnexion'),
            onPressed: () {
              Navigator.pop(ctx);
              ToasterUtils.showLogOutDialog(context, () => logout(context));
            },
          ),
        ),
      ],
    );
  }

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

  void likePost(Post post, User liker, bool add) {
    if (add) {
      this._postService.addLike(post, liker, this._globalStore.currentUser.id);
    } else {
      this
          ._postService
          .removeLike(post, liker, this._globalStore.currentUser.id);
    }
  }

  void logout(BuildContext context) {
    Navigator.pop(context);
    this._authenticationService.logout();
  }

  void updateUserInfo(BuildContext context, User user) {
    UIUtils.showAppBottomSheet(
        context: context,
        store: this._globalStore,
        widget: UpdateUserInfoView(user.id));
  }

  void updateProfilImage(BuildContext context, User user) {
    this._updateImage(
        context: context,
        imageUrl: user.imageUrl,
        type: ImageType.PROFILE,
        user: user,
        consumer: (url) => this
            ._globalStore
            .updateUser(user..imageUrl = url)
            .then((_) => this._globalStore.resetImageUrl()));
  }

  void updateCoverImage(BuildContext context, User user) {
    this._updateImage(
        context: context,
        imageUrl: user.coverUrl,
        type: ImageType.COVER,
        user: user,
        consumer: (url) => this
            ._globalStore
            .updateUser(user..coverUrl = url)
            .then((_) => this._globalStore.resetImageUrl()));
  }

  void _updateImage(
      {BuildContext context,
      User user,
      ImageType type,
      String imageUrl,
      Function consumer}) {
    UIUtils.showAppBottomSheetWithResult<String>(
        widget: ChangeImageView(
          imageUrl: imageUrl,
          type: type,
        ),
        context: context,
        store: this._globalStore,
        func: (store) => store.imageUrl).then((url) {
          if (url.isNotBlank) consumer(url);
        });
  }
}
