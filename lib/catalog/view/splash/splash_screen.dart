import 'package:flutter/material.dart';
import 'package:todo_flutter_app/common/common.dart';
import '../../../app/app_routes.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = 'SplashScreen';
  static const baseRoute = '/';

  const SplashScreen();

  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 1), () {
      router();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  router() async {
    if(!SharedData.shared.isGuest()){
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen,(route) => false);
    }
    else {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginScreen, (route) => false,);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text("ToDo Loading ...", style: TextStyle(color: AppColors.primaryColor, fontSize: 22,fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
