import 'package:app_social/domain/services/AuthenticationService.dart';
import 'package:app_social/ui/pages/create_post_view.dart';
import 'package:app_social/ui/stores/AppGlobalStore.dart';
import 'package:app_social/ui/utils/UIUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../widgets/AppWidgets.dart';

class MainPage extends StatefulWidget {
  String userId;

  MainPage({@required this.userId, Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  AuthenticationService _authenticationService;
  AppGlobalStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authenticationService ??= GetIt.instance<AuthenticationService>();
    _store ??= GetIt.instance<AppGlobalStore>();
    _store.loadUser(widget.userId);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return (_store.connexionState == ConnexionState.CONNECTED)
            ? Scaffold(
                key: _scaffoldKey,
                bottomNavigationBar: appBottomBar(),
                floatingActionButton: FloatingActionButton(
                  onPressed: this._store.editing ? null : showBottomSheet,
                  backgroundColor: this._store.editing ? Colors.grey : blueLight,
                  child: writeIcon,
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                body: Center(
                    child: menuPages(widget.userId)[_store.selectedMenuItem]),
              )
            : AppLoading();
      },
    );
  }

  showBottomSheet() {
    UIUtils.showAppBottomSheet(
      store: _store,
      key: _scaffoldKey,
      widget: CreatePostView(widget.userId)
    );
  }

  AppBottomBar appBottomBar() {
    return AppBottomBar(
      items: <Widget>[
        AppBottomBarItem(
          store: _store,
          name: HOME,
          icon: homeIcon,
          onPressed: () {},
        ),
        AppBottomBarItem(
          store: _store,
          name: FRIENDS,
          icon: friendsIcon,
          onPressed: () {},
        ),
        Container(
          width: 0,
          height: 0,
        ),
        AppBottomBarItem(
          store: _store,
          name: NOTIFICATIONS,
          icon: notificationsIcon,
          onPressed: () {},
        ),
        AppBottomBarItem(
          store: _store,
          name: PROFILE,
          icon: profileIcon,
          onPressed: () {},
        )
      ],
    );
  }
}
