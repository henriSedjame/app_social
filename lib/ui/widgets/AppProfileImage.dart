
import 'package:app_social/ui/widgets/AppImages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../extensions/StringExtension.dart';

class AppProfileImage extends InkWell{

  AppProfileImage({double size: 20.0, @required String src, @required VoidCallback onTap}): super(
    onTap: onTap,
    child: CircleAvatar(
      radius: size,
      backgroundImage: src.isNotBlank ? CachedNetworkImageProvider(src) : appLogoImage,
      backgroundColor: Colors.white,
    )
  );
}