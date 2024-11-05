import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../common/config/app_colors.dart';

class EasyLoadingHelper {
  static var shared = EasyLoadingHelper();

  init() {
    EasyLoading.instance
      ..userInteractions = false
      ..dismissOnTap = false
      ..loadingStyle = EasyLoadingStyle.custom //This was missing in earlier code
      ..indicatorWidget = Container(
          width: 90,
          height: 90,
          padding: const EdgeInsets.all(20),
          margin: EdgeInsets.zero,
          child: CircularProgressIndicator.adaptive(
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
            backgroundColor: Platform.isIOS ? AppColors.primaryColor : null,
          ))
      ..backgroundColor = Colors.white
      ..indicatorColor = Colors.white
      ..maskType = EasyLoadingMaskType.custom
      ..maskColor = Colors.black38
      ..textColor = Colors.white
      ..contentPadding = EdgeInsets.zero
      ..radius = 100;
  }
}
