import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todo_flutter_app/catalog/domain/remote/auth/requests/login_request.dart';
import 'package:todo_flutter_app/catalog/view/profile/view/component/theme_helper.dart';
import 'package:todo_flutter_app/out-buildings/dependency_injector.dart';
import '../../../../app/app_routes.dart';
import '../../../../common/helper/flutter_toast_helper.dart';
import '../bloc/login_bloc.dart';
import 'component/header_widget.dart';


class LoginScreen extends StatefulWidget {
  static const routeName = 'LoginScreen';
  const LoginScreen();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  late LoginBloc _loginBloc;
  LoginRequest? model = LoginRequest();


  @override
  void initState() {
    super.initState();
    _loginBloc = getIt.get<LoginBloc>();

  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: (context, state) {
          if (state is LoginError) {
            EasyLoading.dismiss();
            FlutterToastHelper.showErrorFlutterToast(context: context, message: state.message ?? "");
          }
          else if (state is LoginLoading) {
            EasyLoading.show();
          }
          else if (state is LoginSuccessfully) {
            EasyLoading.dismiss();
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen, (route) => false);
          }

        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _headerHeight,
                child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
              ),
              SafeArea(
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                    child: Column(
                      children: [
                        Text(
                          'Hello',
                          style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold, fontFamily: "Glory",),
                        ),
                        Text(
                          'Signin into your account',
                          style: TextStyle(color: Colors.grey,fontFamily: "Glory",),
                        ),
                        SizedBox(height: 30.0),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  child: TextField(
                                    decoration: ThemeHelper().textInputDecoration('Email', 'Enter your Email'),
                                    onChanged: (String value){
                                      model?.email = value;
                                    },
                                    onSubmitted: (String value){
                                      model?.email = value;
                                    },
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 30.0),
                                Container(
                                  child: TextField(
                                    obscureText: true,
                                    decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
                                    onChanged: (String value){
                                      model?.password = value;
                                    },
                                    onSubmitted: (String value){
                                      model?.password = value;
                                    },
                                  ),
                                  decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                ),
                                SizedBox(height: 15.0),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10,0,10,20),
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      //Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                    },
                                    child: Text( "Forgot your password?", style: TextStyle( color: Colors.grey, fontFamily: "Glory",),
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: ThemeHelper().buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ThemeHelper().buttonStyle(),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                      child: Text('Sign In'.toUpperCase(), style: TextStyle(fontSize: 20,fontFamily: "Glory", fontWeight: FontWeight.bold, color: Colors.white),),
                                    ),
                                    onPressed: (){
                                      _loginBloc.add(LoginByEmail(model: model));
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(10,20,10,20),
                                  //child: Text('Don\'t have an account? Create'),
                                  child: Text.rich(
                                      TextSpan(
                                          children: [
                                            TextSpan(text: "Don\'t have an account? "),
                                            TextSpan(
                                              text: 'Create',
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = (){
                                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                                },
                                              style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor,fontFamily: "Glory",),
                                            ),
                                          ]
                                      )
                                  ),
                                ),
                              ],
                            )
                        ),
                      ],
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








