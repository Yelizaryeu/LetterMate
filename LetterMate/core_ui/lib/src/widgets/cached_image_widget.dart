import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../core_ui.dart';

class AppCachedImageWidget extends StatelessWidget {
  final double height;
  final double width;
  final String imageURL;
  final TextStyle? textStyle;
  final double? borderRadius;
  final BoxFit? fit;

  const AppCachedImageWidget({
    super.key,
    required this.imageURL,
    this.textStyle,
    this.height = 158,
    this.width = 158,
    this.borderRadius,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: CachedNetworkImage(
        memCacheWidth: height.toInt(),
        memCacheHeight: width.toInt(),
        imageUrl: imageURL,
        placeholder: (BuildContext context, String url) => Container(
          height: height,
          width: height,
          color: AppTheme.backgroundColor,
          child: const CupertinoActivityIndicator(),
        ),
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      ),
    );
  }
}
