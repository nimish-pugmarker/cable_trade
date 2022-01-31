import 'dart:async';
import 'dart:convert';

import 'package:cable_trade/Networking/ApiProviderNew.dart';
import 'package:cable_trade/Networking/Constants.dart';
import 'package:cable_trade/Utils/MySharedPreferences.dart';
import 'package:cable_trade/Utils/myColors.dart';
import 'package:cable_trade/Utils/sizeConfig.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:cable_trade/Utils/helperMethods.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late ProgressDialog pr;
  late String apiToken;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future loginSuccessful(String response)async{
    Map<String,dynamic> data = jsonDecode(response);
    MySharedPreferences().addUserData(jsonEncode(data["user"]));
    MySharedPreferences().addApiToken(data["access_token"]);
    Navigator.pushReplacementNamed(context, "/DashBoardScreen");

  }
  
  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context, type: ProgressDialogType.normal, isDismissible: false,);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: SizeConfig.screenHeight,
            width: double.infinity,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: SizeConfig.verticalBlockSize * 5,),
                      SvgPicture.asset("assets/images/logo.svg",),
                      SizedBox(height: SizeConfig.verticalBlockSize * 5,),
                      const Text("Sign In To Your Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold ),),
                      SizedBox(height: SizeConfig.verticalBlockSize * 5,),
                      TextFormField(
                        controller: userNameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            hintText: "Email Id",
                            labelText: "Email Id"
                        ),
                        validator: (value) => MyValidator.validateEmail(value),
                      ),
                      Text("email: irshad.shaikh@pugmarker.com"),
                      SizedBox(height: SizeConfig.verticalBlockSize * 3,),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            hintText: "Password",
                            labelText: "Password"
                        ),
                        validator: (value) => MyValidator.validatePassword(value),
                      ),
                      Text("password: 12345678"),
                      SizedBox(height: SizeConfig.verticalBlockSize * 5,),
                      MaterialButton(
                        onPressed: ()async{
                          if(_formKey.currentState!.validate()){
                            FocusScope.of(context).unfocus();
                            pr.style(message: "Logging in",child: const CircularProgressIndicator());
                            pr.show();
                            await Future.delayed(Duration(seconds: 1));
                            String data = await ApiProviderNew().login(
                                userNameController.text, passwordController.text);

                            print(data);
                            if(data == "SocketException" || data == "TimeoutException"){
                              if(pr.isShowing()){
                                pr.hide();
                              }
                            }
                            else {
                              if(pr.isShowing()){
                                pr.hide();
                              }
                              loginSuccessful(data);
                            }
                          }
                        },
                        child: const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                        color: MyColors.colorCustomTheme,
                        height: 55,
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minWidth: SizeConfig.screenWidth,
                      ),
                      SizedBox(height: SizeConfig.verticalBlockSize * 3,),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, "/ForgotPasswordScreen"),
                        child: Text("Forgot Password?", style: TextStyle(fontSize: 18, color: MyColors.colorCustomTheme, decoration: TextDecoration.underline),)),
                      Expanded(child: Container(),),
                      Container(height: 2, width: SizeConfig.screenWidth, color: Colors.grey),
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: RichText(
                          text: TextSpan(
                            text: "Don't Have an Account? ",
                              style: TextStyle(color: Colors.black),
                              children: [
                              TextSpan(
                                text: "CREATE ACCOUNT",
                                recognizer: TapGestureRecognizer()..onTap = (){
                                  Navigator.pushNamed(context, "/RegisterScreen");
                                },
                                style: TextStyle(color: MyColors.colorCustomTheme, decoration: TextDecoration.underline)
                              )
                            ]
                          ),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
