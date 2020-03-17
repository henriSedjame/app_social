import 'package:app_social/data/models/User.dart';
import 'package:app_social/ui/forms/Formulaire.dart';
import 'package:app_social/ui/stores/AppGlobalStore.dart';
import 'package:app_social/ui/utils/UIUtils.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../widgets/AppWidgets.dart';
import 'package:flutter/material.dart';

class UpdateUserInfoView extends StatefulWidget {
  String _userId;

  UpdateUserInfoView(this._userId, {Key key}) : super(key: key);

  @override
  _UpdateUserInfoViewState createState() => _UpdateUserInfoViewState();
}

class _UpdateUserInfoViewState extends State<UpdateUserInfoView> {
  GlobalKey<FormBuilderState> _updateFormKey = GlobalKey();
  AppGlobalStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    this._store = GetIt.instance<AppGlobalStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      var user = this._store.currentUser;

      return SingleChildScrollView(
        child: AppPadding(
          top: 0.0,
          left: 5.0,
          right: 5.0,
          child: updateForm(user),
        ),
      );
    });
  }

  Widget updateForm(User user) {
    return InkWell(
      onTap: () => UIUtils.hideKeyBoard(context),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 25.0),
        margin: EdgeInsets.only(bottom: 25.0),
        child: Column(
          children: <Widget>[
            AppPadding(
              child: Text(
                'MISE A JOUR DES INFOS PERSONNELLES',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
            ),
            AppDivider(
              width: MediaQuery.of(context).size.width * 0.8,
              paddingTop: 15.0,
            ),
            AppPadding(
              top: 0.0,
              left: 10.0,
              right: 10.0,
              child: Formulaire(
                formKey: _updateFormKey,
                initialValue: user?.toJson() ?? {},
                formFields: <Widget>[
                  AppPadding(
                      top: 5.0, left: 10.0, right: 10.0, child: nomFormField),
                  AppPadding(
                      top: 5.0,
                      left: 10.0,
                      right: 10.0,
                      child: prenomFormField),
                  AppPadding(
                      top: 5.0,
                      left: 10.0,
                      right: 10.0,
                      bottom: 15.0,
                      child: descriptionFormField)
                ],
                actionButtons: <Widget>[
                  AppRaisedButton(
                    onPressed: updateUser,
                    text: 'SAUVEGARDER',
                    elevation: 7.0,
                    color: darkGrey,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateUser() async {
    var updateFormState = this._updateFormKey.currentState;

    if (updateFormState.saveAndValidate()) {
      var value = updateFormState.value;

      var user = User.fromJson(value);

      await this._store.updateUser(user);
    } else
      return null;
  }
}
