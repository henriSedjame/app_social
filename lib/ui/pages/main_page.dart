import 'package:app_social/domain/services/AuthenticationService.dart';
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

  AuthenticationService _authenticationService;
  AppGlobalStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authenticationService ??= GetIt.instance<AuthenticationService>();
    _store ??= GetIt.instance<AppGlobalStore>();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_){
        return Scaffold(
          bottomNavigationBar: AppBottomBar(
            items: <Widget>[
              AppBottomBarItem(
                store: _store,
                name: 'home',
                icon: Icon(Icons.home),
                onPressed: (){},
              ),
              AppBottomBarItem(
                store: _store,
                name: 'friends',
                icon: Icon(Icons.group),
                onPressed: (){},
              ),
              Container(width: 0, height: 0,),
              AppBottomBarItem(
                store: _store,
                name: 'notifications',
                icon: Icon(Icons.notifications),
                onPressed: (){},
              ),
              AppBottomBarItem(
                store: _store,
                name: 'account',
                icon: Icon(Icons.account_circle),
                onPressed: (){},
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){},
            backgroundColor: blueLight,
            child: Icon(Icons.border_color),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${widget.userId}'),
                  AppRaisedButton(
                    text: 'DECONNEXION',
                    color: Colors.blueGrey[900],
                    elevation: 0.0,
                    onPressed: () => _authenticationService.logout(),
                  )
                ],
              )
          ),
        );
      },
    );
  }
}