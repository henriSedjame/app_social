import 'dart:io';

import 'package:app_social/data/repositories/FileStorage.dart';
import 'package:app_social/ui/stores/AppGlobalStore.dart';
import 'package:app_social/ui/utils/UIUtils.dart';
import 'package:app_social/ui/widgets/AppColors.dart';
import 'package:app_social/ui/widgets/AppPadding.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import '../../extensions/StringExtension.dart';
import '../widgets/AppWidgets.dart';

enum ImageType { PROFILE, COVER }

class ChangeImageView extends StatefulWidget {
  String imageUrl;
  ImageType type;

  ChangeImageView({@required this.imageUrl, @required this.type, Key key})
      : super(key: key);

  @override
  _ChangeImageViewState createState() => _ChangeImageViewState();
}

class _ChangeImageViewState extends State<ChangeImageView> {
  File _imageFile;
  AppGlobalStore _store;
  FileStorage _fileStorage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this._store ??= GetIt.instance<AppGlobalStore>();
    this._fileStorage ??= GetIt.instance<FileStorage>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AppPadding(
        top: 10.0,
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              AppPadding(
                child: Text(
                  'MODIFICATION DE LA PHOTO DE ${widget.type == ImageType.PROFILE ? 'PROFIL' : 'COUVERTURE'}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
                  textAlign: TextAlign.center,
                ),
              ),

              AppPadding(
                  top: 10.0,
                  bottom: 0.0,
                  right: 10.0,
                  left: 10.0,
                  child: Container(
                      width: 200.0,
                      color: Colors.white,
                      child: image(context))),
              AppDivider(
                color: ternaryColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  AppPadding(
                    top: 0.0,
                    child: IconButton(
                      onPressed: () => takePicture(ImageSource.camera, context),
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
              AppDivider(
                color: ternaryColor,
              ),
              AppRaisedButton(
                text: 'SAUVEGARDER',
                onPressed: readyTosend ? () => saveImage(context) : null,
                color: blueLight,
              )
            ],
          ),
        ),
      ),
    );
  }

  bool get readyTosend => this._imageFile != null;

  Future<void> takePicture(ImageSource source, BuildContext context) async {
    UIUtils.hideKeyBoard(context);
    var pickImage = await ImagePicker.pickImage(
        source: source, maxHeight: 500, maxWidth: 500);

    setState(() {
      this._imageFile = pickImage;
    });
  }

  Widget image(BuildContext context) {

    if (this._imageFile?.path?.isNotBlank ?? false)
      return Image.file(
        this._imageFile,
        fit: BoxFit.cover,
      );

    if (widget.imageUrl.isNotBlank)
      return Image(
        image: CachedNetworkImageProvider(widget.imageUrl),
        fit: BoxFit.cover,
      );

    return Column(
      children: <Widget>[
        Icon(Icons.photo,
            size: MediaQuery.of(context).size.width * 0.4, color: blueLight),
        AppPadding(
          top: 0.0,
          bottom: 25.0,
          child: Text(
            'Veuillez sélectionner ou prendre une photo.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Future<void> saveImage(BuildContext context){

    var userId = this._store.currentUser.id;
    return (widget.type == ImageType.PROFILE
            ? this._fileStorage.storeUserProfileImage(this._imageFile, userId)
            : this._fileStorage.storeUserCoverImage(this._imageFile, userId))
        .then((value) {
          this._store.updateImageUrl(value);
          Navigator.pop(context);
        });
  }
}
