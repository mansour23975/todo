import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_flutter_app/common/helper/no_glow_scroll_behavior.dart';
import '../catalog/navigation/navigation_service.dart';
import '../common/config/app_colors.dart';
import '../out-buildings/dependency_injector.dart';
import 'app_routes.dart';
import 'my_app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp();

  static const String googleApiKey = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen,
      onGenerateInitialRoutes: (_) => [
        RouteGenerator.onGenerateRoute(
          RouteSettings(
            name: _,
          ),
        ),
      ],
      onGenerateRoute: RouteGenerator.onGenerateRoute,
      onUnknownRoute: RouteGenerator.onUnknownRoute,
      navigatorKey: getIt<NavigationService>().navigationKey,
      builder: EasyLoading.init(builder: (context, child) {
        return ScrollConfiguration(
          behavior: NoGlowScrollBehavior(),
          child: Theme(
            data: ThemeData(
                useMaterial3: false,
                primaryColor: AppColors.primaryColor,
                canvasColor: Colors.transparent,
                splashColor: Colors.transparent,
                indicatorColor: AppColors.primaryColor,
                bottomSheetTheme: BottomSheetThemeData(
                  dragHandleColor: AppColors.primaryColor,
                ),
                progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.primaryColor),
                scrollbarTheme: const ScrollbarThemeData().copyWith(thumbColor: MaterialStateProperty.all(Colors.transparent)),
                highlightColor: Colors.transparent,
                colorScheme: ColorScheme.fromSwatch(accentColor: AppColors.primaryColor),
                fontFamily: "Glory",
                appBarTheme: AppBarTheme(
                    elevation: 0.4,
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    titleTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textColor,
                      fontFamily: "Glory",
                    ),
                    iconTheme: const IconThemeData(
                      color: AppColors.primaryColor,
                    ))),
            child: child!,
          ),
        );
      }),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
