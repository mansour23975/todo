import 'dart:ui';

import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class BottomSheetHelper {
  static showModalSheet(BuildContext context, Widget parent, [bool applyConstrain = false]) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: AppColors.white,
      barrierColor: AppColors.primaryColor.withOpacity(0.6),
      elevation: 0,
      barrierLabel: "comments",
      isScrollControlled: true,
      constraints: applyConstrain
          ? BoxConstraints(minHeight: MediaQuery.sizeOf(context).height * 0.3, maxHeight: MediaQuery.sizeOf(context).height * 0.8)
          : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0, tileMode: TileMode.clamp),
          child: parent,
        );
      },
    ).whenComplete(() {});
  }
}
