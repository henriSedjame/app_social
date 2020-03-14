import 'package:app_social/domain/services/AuthenticationService.dart';
import 'package:app_social/ui/pages/create_post_view.dart';
import 'package:app_social/ui/pages/friends_page.dart';
import 'package:app_social/ui/pages/home_page.dart';
import 'package:app_social/ui/pages/notifications_page.dart';
import 'package:app_social/ui/pages/profile_page.dart';
import 'package:app_social/ui/stores/AppGlobalStore.dart';
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
    print('did change dependencies ');
  }

  @override
  void initState() {
    super.initState();
    print('Init state');
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_){
        return (_store.connexionState == ConnexionState.CONNECTED) ? Scaffold(
          key: _scaffoldKey,
          bottomNavigationBar: appBottomBar(),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _scaffoldKey.currentState.showBottomSheet((context) => CreatePostView(widget.userId)),
            backgroundColor: blueLight,
            child: writeIcon,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: Center(child: menuPages(widget.userId)[_store.selectedMenuItem]),
        ) : AppLoading();
      },
    );
  }

  AppBottomBar appBottomBar() {
    return AppBottomBar(
          items: <Widget>[
            AppBottomBarItem(
              store: _store,
              name: HOME,
              icon: homeIcon,
              onPressed: (){},
            ),
            AppBottomBarItem(
              store: _store,
              name: FRIENDS,
              icon: friendsIcon,
              onPressed: (){},
            ),
            Container(width: 0, height: 0,),
            AppBottomBarItem(
              store: _store,
              name: NOTIFICATIONS,
              icon: notificationsIcon,
              onPressed: (){},
            ),
            AppBottomBarItem(
              store: _store,
              name: PROFILE,
              icon: profileIcon,
              onPressed: (){},
            )
          ],
        );
  }
}