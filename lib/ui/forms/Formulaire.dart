import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../widgets/AppWidgets.dart';

class Formulaire extends StatefulWidget {
  final GlobalKey<FormBuilderState> formKey;
  final List<Widget> formFields;
  final List<Widget> actionButtons;

  Formulaire({@required this.formKey, @required this.formFields, @required this.actionButtons, Key key})
      : super(key: key);

  @override
  _FormulaireState createState() => _FormulaireState();
}

class _FormulaireState extends State<Formulaire> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          elevation: 7.0,
          child: Column(
            children: <Widget>[
              FormBuilder(
                  key: widget.formKey,
                  initialValue: {},
                  autovalidate: true,
                  child: Column(children: widget.formFields)),
              AppPadding(
                top: 0.0,
                bottom: 10.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.actionButtons,
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20.0,)
      ],
    );
  }
}
