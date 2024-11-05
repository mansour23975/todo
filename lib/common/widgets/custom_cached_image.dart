import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../config/app_colors.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage(
      {
      required this.imageUrl,
      this.width,
      this.height,
      this.radius,
      this.boxFit,
      this.errorWidget,
      this.isDisabled = false,
      this.radiusOnlyVertical = false,
      this.placeholderWidget});

  final String imageUrl;
  final double? width, height, radius;
  final bool radiusOnlyVertical, isDisabled;
  final BoxFit? boxFit;
  final Widget? errorWidget, placeholderWidget;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(

      borderRadius: radiusOnlyVertical
          ? BorderRadius.vertical(top: Radius.circular(radius ?? 0))
          : BorderRadius.circular(radius ?? 0),
      child: ColorFiltered(
        colorFilter: isDisabled
            ? const ColorFilter.mode(
                AppColors.black,
                BlendMode.saturation,
              )
            : const ColorFilter.mode(
                Colors.transparent,
                BlendMode.multiply,
              ),
        child: imageUrl.isNotEmpty ? CachedNetworkImage(
          imageUrl: imageUrl,
          fit: boxFit ?? BoxFit.cover,
          width: width,
          height: height,
          errorListener: (error){
            print(error);
          },
          placeholder: (context, _) => placeholderWidget ?? const SizedBox(),//AppProgress(),
          errorWidget: (context, _, __) => Container(
              color: AppColors.backgroundColor,
              child: errorWidget ?? const Icon(Icons.info, color: AppColors.subtitleColor)),
        ) : Container(
            color: AppColors.backgroundColor,
            child: errorWidget ?? const Icon(Icons.info, color: AppColors.subtitleColor)),
      ),
    );
  }
}
