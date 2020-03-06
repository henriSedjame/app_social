
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


final nomFormField = FormBuilderTextField(
  attribute: 'nom',
  decoration: InputDecoration(
    hintText: 'Entrez votre nom',
  ),
  validators: [
    FormBuilderValidators.required(errorText: 'Veuillez renseigner votre nom.')
  ],
);

final prenomFormField = FormBuilderTextField(
  attribute: 'prenom',
  decoration: InputDecoration(
    hintText: 'Entrez votre prénom',
  ),
  validators: [
    FormBuilderValidators.required(errorText: 'Veuillez renseigner votre prénom.')
  ],
);

final emailFormField = FormBuilderTextField(
  attribute: 'email',
  decoration: InputDecoration(
    hintText: 'Entrez votre email',
  ),
  validators: [
    FormBuilderValidators.required(errorText: 'Veuillez renseigner votre adresse mail.'),
    FormBuilderValidators.email(errorText: 'Veuillez renseigner une adresse mail valide.')
  ],
);

final passwordFormField = FormBuilderTextField(
  attribute: 'password',
  maxLines: 1,
  obscureText: true,
  decoration: InputDecoration(
    hintText: 'Entrez votre mot de passe',
  ),
  validators: [
    FormBuilderValidators.required(errorText: 'Veuillez renseigner votre adresse mail.'),
    FormBuilderValidators.minLength(8, errorText: 'Le mot de passe doit contenir au moins 8 caractères.')
  ],
);