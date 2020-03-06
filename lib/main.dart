import 'package:app_social/domain/services/AuthenticationService.dart';
import 'package:app_social/ui/pages/identification_page.dart';
import 'package:app_social/ui/widgets/AppRaisedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'config/InjectableConfig.dart' as Configuration;
import 'ui/widgets/AppWidgets.dart';

void main() {
  Configuration.configureInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var authenticationService = GetIt.instance<AuthenticationService>();

    return MaterialApp(
        title: 'Social App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.blueGrey[900],
          accentColor: Colors.blueGrey[400],
        ),
        home: StreamBuilder<FirebaseUser>(
            stream: authenticationService.authStream,
            builder:
                (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
              return snapshot.hasData ? Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${snapshot.data.email}'),
                      AppRaisedButton(
                        text: 'DECONNEXION',
                        color: Colors.blueGrey[900],
                        elevation: 0.0,
                        onPressed: () => authenticationService.logout(),
                      )
                    ],
                  )
                ),
              ) : IdenificationPage();
            }));
  }
}
