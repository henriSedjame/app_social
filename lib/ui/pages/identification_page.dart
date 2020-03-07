import 'package:app_social/data/models/Credentials.dart';
import 'package:app_social/data/models/User.dart';
import 'package:app_social/domain/services/AuthenticationService.dart';
import 'package:app_social/domain/services/UserService.dart';
import 'package:app_social/ui/forms/Formulaire.dart';
import 'package:app_social/ui/utils/ToasterUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get_it/get_it.dart';
import '../widgets/AppWidgets.dart';

class IdenificationPage extends StatefulWidget {
  IdenificationPage({Key key}) : super(key: key);

  @override
  _IdenificationPageState createState() => _IdenificationPageState();
}

class _IdenificationPageState extends State<IdenificationPage> {

  final double minHeight = 600.0;
  PageController _pageController = PageController();
  GlobalKey<FormBuilderState> _loginFormKey = GlobalKey();
  GlobalKey<FormBuilderState> _registerFormKey = GlobalKey();
  AuthenticationService _authenticationService;
  UserService _userService;

  @override
  void initState() {
    super.initState();
    this._authenticationService = GetIt.instance<AuthenticationService>();
    this._userService = GetIt.instance<UserService>();
  }

  @override
  Widget build(BuildContext context) {
    var ctxHeight = MediaQuery.of(context).size.height;
    var ctxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowGlow();
          return true;
        },
        child: SingleChildScrollView(
          child: Container(
            width: ctxWidth,
            height: ctxHeight >= minHeight ? ctxHeight : minHeight,
            color: primaryColor,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  AppPadding(
                      bottom: 5.0,
                      child: Image(
                        image: appLogoImage,
                        width: 120.0,
                      )),
                  AppPadding(
                    bottom: 25.0,
                    child: AppLogBar(
                      menu1: 'CONNEXON',
                      menu2: 'INSCRIPTION',
                      pageController: _pageController,
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        children: <Widget>[
                          AppPadding(
                            child: loginForm(),
                            top: 0.0,
                            left: 10.0,
                            right: 10.0,
                          ),
                          AppPadding(
                            child: registerForm(),
                            top: 0.0,
                            left: 10.0,
                            right: 10.0,
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return SingleChildScrollView(
      child: Formulaire(formKey: _loginFormKey, formFields: [
        AppPadding(top: 5.0, left: 10.0, right: 10.0, child: emailFormField),
        AppPadding(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: 25.0,
            child: passwordFormField)
      ], actionButtons: [
        AppRaisedButton(
          onPressed: () => login(context),
          text: 'CONNEXION',
          elevation: 7.0,
          color: darkGrey,
        )
      ]),
    );
  }

  Widget registerForm() {
    return SingleChildScrollView(
      child: Formulaire(formKey: _registerFormKey, formFields: [
        AppPadding(top: 5.0, left: 10.0, right: 10.0, child: nomFormField),
        AppPadding(top: 5.0, left: 10.0, right: 10.0, child: prenomFormField),
        AppPadding(top: 5.0, left: 10.0, right: 10.0, child: emailFormField),
        AppPadding(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: 25.0,
            child: passwordFormField)
      ], actionButtons: [
        AppRaisedButton(
          onPressed: register,
          text: 'CREER LE COMPTE',
          elevation: 7.0,
          color: darkGrey,
        )
      ]),
    );
  }

  Future<void> login(BuildContext context) async {
    var loginFormState = _loginFormKey.currentState;
    if (loginFormState.saveAndValidate()) {
      Map<String, dynamic> value = loginFormState.value;
      var credentials = Credentials.fromJson(value);
      await this._authenticationService.login(email: credentials.email, password: credentials.password)
        .catchError((error) => ToasterUtils.showErrorMessage(context, error.message));
    }
  }

  Future<void> register() async {
    var registerFormState = _registerFormKey.currentState;
    if (registerFormState.saveAndValidate()) {
      var value = registerFormState.value;
      await this._userService.save(User.fromJson(value), Credentials.fromJson(value).password);
    }
  }
}
