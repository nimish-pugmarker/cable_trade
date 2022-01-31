import 'dart:async';
import 'dart:convert';

import 'package:cable_trade/Networking/ApiProviderNew.dart';
import 'package:cable_trade/Networking/Constants.dart';
import 'package:cable_trade/Utils/MySharedPreferences.dart';
import 'package:cable_trade/Utils/myColors.dart';
import 'package:cable_trade/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late String apiToken;
  String fcmToken = "";

  @override
  void initState() {
    super.initState();
    checkAuthentication();
  }

  Future<void> checkAuthentication() async {

    Future.delayed(const Duration(seconds: 2), ()async{
      apiToken = await MySharedPreferences().getApiToken();
      print("apiToken: $apiToken abc");
      if (apiToken == "") {
        Navigator.pushReplacementNamed(context, "/OnBoardingScreen");
      } else {
        String result = await ApiProviderNew().authenticate();
        if(result == "SocketException" || result == "TimeoutException"){
          Navigator.pushReplacementNamed(context, "/LoginScreen");
        }
        else{
          dynamic data = jsonDecode(result);
          print(data);
          Navigator.pushReplacementNamed(context, "/DashBoardScreen");
        }
      }

    });
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/splashBackground.png"), fit: BoxFit.fill),
        ),
        child: Center(
          child: SvgPicture.asset(
            "assets/images/logo.svg",
            width: SizeConfig.screenWidth,
            height: SizeConfig.verticalBlockSize * 13,),
        ),
      ),
    );
  }
}
