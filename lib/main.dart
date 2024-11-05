import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_flutter_app/catalog/domain/models/user_info.dart';
import 'package:todo_flutter_app/common/common.dart';
import 'package:todo_flutter_app/common/helper/shared_preferences_helper.dart';
import '../../out-buildings/dependency_injector.dart' as di;
import 'app/my_app.dart';
import 'catalog/enums/easyLoading_helper.dart';
import 'catalog/enums/env_config.dart';
import 'out-buildings/development_tools_wrapper.dart';
var environmentType = EnvironmentType.testing;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await initializeApp();
  runApp(
    const DevToolsWrapper(
      MyApp(),
    ),
  );
}

Future<void> initializeApp() async {
  await EasyLocalization.ensureInitialized();

  if (PrefsKeys.init == false) {
    await di.init();
    PrefsKeys.init = true;
  }
  ///custom loading dialog
  await EasyLoadingHelper.shared.init();



  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.white, // status bar color
      statusBarBrightness: Brightness.dark
  ));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  var currentUser = await SharedPref().read(PrefsKeys.userTAG);
  SharedData.shared.user = currentUser == null ? null : UserInfoAuth.fromJson(currentUser);


  SharedData.shared.token = await SharedPref().read(PrefsKeys.tokenTAG);
}
