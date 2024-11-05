import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import '../common/common.dart';
class DevToolsWrapper extends StatelessWidget {
  final Widget appEntryPoint;
  ///CONSTRUCTOR
  const DevToolsWrapper(this.appEntryPoint, {Key? key,}) : super(key: key,);

  @override
  Widget build(BuildContext context,) {
    return  /*DevicePreview(
      enabled: false,
      tools: const [
        DeviceSection(),
      ],
      builder: (buildContext,) => DevicePreview.appBuilder(buildContext, Phoenix(
        child:*/ EasyLocalization(
            supportedLocales: const [Locale('en', 'US'), Locale('ar', 'SA')],
            path: 'assets/translations',
            //fallbackLocale: SharedData.shared.langType.local,
            //startLocale: SharedData.shared.langType.local,
            useFallbackTranslations: true,
            child: appEntryPoint
       // ),
     // ),),
      // ),
    );
  }
}