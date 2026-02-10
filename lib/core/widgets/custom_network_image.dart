import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wassela_task_app/core/helpers/app_constants.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imgUrl;
  final double? imageWidth, imageHeight, borderRadius;
  final BoxFit? fit;
  final BlendMode? colorBlendMode;
  final Color? color;
  const CustomNetworkImage({
    super.key,
    required this.imgUrl,
    this.imageWidth,
    this.imageHeight,
    this.borderRadius,
    this.fit,
    this.colorBlendMode,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        colorBlendMode: colorBlendMode,
        color: color,
        imageUrl: imgUrl,
        width: imageWidth,
        height: imageHeight,
        fit: fit,
        placeholder: (context, url) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 10.w),
              color: Colors.white,
              // color: ColorsManager.mainColor,
            ),
            child: Center(child: Image.asset(AssetsConstants.fullLogo)),
          );
        },
        // progressIndicatorBuilder: (context, url, loadingProgress) {
        //   return Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Center(
        //       child: CircularProgressIndicator(
        //         color: ColorsManager.mainColor,
        //         value: loadingProgress.progress,
        //       ),
        //     ),
        //   );
        // },
        errorWidget: (BuildContext context, String url, Object? error) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius ?? 10.w),
              color: Colors.transparent,
            ),
            child: Center(child: Image.asset(AssetsConstants.fullLogo)),
          );
        },
      ),
    );
  }
}


