import 'dart:io';

import 'package:app_social/data/models/Post.dart';
import 'package:app_social/domain/services/PostService.dart';
import 'package:app_social/ui/forms/Formulaire.dart';
import 'package:app_social/ui/utils/ToasterUtils.dart';
import 'package:app_social/ui/widgets/AppColors.dart';
import 'package:app_social/ui/widgets/AppPadding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/AppWidgets.dart';
import '../../extensions/StringExtension.dart';

class CreatePostView extends StatefulWidget {
  String _userId;

  CreatePostView(this._userId, {Key key}) : super(key: key);

  @override
  _CreatePostViewState createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  File _imageFile;
  GlobalKey<FormBuilderState> _postFormKey = GlobalKey();
  PostService _postService;
  bool posting = false;
  bool readyTosend = false;

  @override
  void initState() {
    super.initState();

    this._postService = GetIt.instance<PostService>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AppPadding(
        top: 0.0,
        left: 15.0,
        right: 15.0,
        child: posting ? loading() : postForm(context),
      ),
    );
  }

  AppPadding loading() {
    return AppPadding(
      top: 50.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SpinKitSquareCircle(
              color: blueLight,
            ),
            AppPadding(
                top: 20.0, bottom: 25.0, child: Text('Envoi en cours ... '))
          ],
        ),
      ),
    );
  }

  InkWell postForm(BuildContext context) {
    return InkWell(
      onTap: () => hideKeyBoard(context),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Formulaire(
              formKey: _postFormKey,
              formFields: <Widget>[
                AppPadding(
                    left: 10.0,
                    right: 10.0,
                    child: postContentFormField(onChanged: (value) {
                      setState(() {
                        if (value.toString().isNotBlank) {
                          this.readyTosend = true;
                        } else {
                          this.readyTosend = this._imageFile != null;
                        }
                      });
                    })),
                AppPadding(
                    top: 10.0,
                    bottom: 0.0,
                    right: 10.0,
                    left: 10.0,
                    child: (this._imageFile != null)
                        ? Container(
                            width: 200.0,
                            height: 200.0,
                            color: Colors.white,
                            child: Image.file(this._imageFile))
                        : Text('Ajouter une photo'))
              ],
              actionButtons: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        AppPadding(
                          top: 0.0,
                          child: IconButton(
                            onPressed: () =>
                                takePicture(ImageSource.camera, context),
                            icon: cameraIcon,
                          ),
                        ),
                        AppPadding(
                          top: 0.0,
                          child: IconButton(
                            onPressed: () =>
                                takePicture(ImageSource.gallery, context),
                            icon: photoLibraryIcon,
                          ),
                        )
                      ],
                    ),
                    AppRaisedButton(
                      onPressed:
                          this.readyTosend ? () => sendPost(context) : null,
                      color: blueLight,
                      text: 'ENVOYER',
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void hideKeyBoard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());

  Future<void> takePicture(ImageSource source, BuildContext context) async {
    this.hideKeyBoard(context);
    var pickImage = await ImagePicker.pickImage(
        source: source, maxHeight: 500, maxWidth: 500);

    setState(() {
      this._imageFile = pickImage;
      this.readyTosend = this._imageFile != null;
    });
  }

  void sendPost(BuildContext context) {
    var postFormState = this._postFormKey.currentState;

    if (postFormState?.saveAndValidate() ?? false) {
      postFormState.reset();
      setState(() {
        this.posting = true;
      });

      Map<String, dynamic> value = postFormState.value;
      String postContent = Post.fromJson(value)?.content;
      this
          ._postService
          .save(postContent, this._imageFile, widget._userId)
          .then((value) {
        setState(() {
          this._imageFile = null;
          this.posting = false;
          Navigator.of(context).pop();
        });
      }).catchError((error) {
        ToasterUtils.showErrorMessage(context, 'Une erreur s\'est produite');
        setState(() {
          this.posting = false;
        });
      });
    }
  }
}
