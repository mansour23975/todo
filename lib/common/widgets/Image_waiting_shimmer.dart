import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../common.dart';

class ImageWaitingShimmer extends StatelessWidget {
  const ImageWaitingShimmer({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBaseColor,
      highlightColor: AppColors.shimmerHighlightedColor,
      child: Container(
        height: height,
        decoration: const BoxDecoration(color: AppColors.white),
      ),
    );
  }
}