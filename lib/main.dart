import 'dart:io';

import 'package:cable_trade/Screens/Modules/HomeScreens/addRfqScreen.dart';
import 'package:cable_trade/Screens/Modules/HomeScreens/dashBoardScreen.dart';
import 'package:cable_trade/Screens/Modules/Login/forgotPasswordScreen.dart';
import 'package:cable_trade/Screens/Modules/Login/loginScreen.dart';
import 'package:cable_trade/Screens/Modules/Login/onBoardingScreen.dart';
import 'package:cable_trade/Screens/Modules/Login/registerScreen.dart';
import 'package:cable_trade/Screens/Modules/Login/splashScreen.dart';
import 'package:cable_trade/Utils/myColors.dart';
import 'package:flutter/material.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyColors().init(context);

    return MaterialApp(
      title: 'Cable Trade',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MyColors.colorCustomTheme,
      ),
      onGenerateRoute: (RouteSettings settings){
        // if(settings.name == InwardOutwardScreen.routeName){
        //   final dynamic data = settings.arguments;
        //   print(data);
        //   return MaterialPageRoute(
        //       builder: (context){
        //         return InwardOutwardScreen(
        //           client: data,
        //         );
        //       }
        //   );
        // }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      initialRoute: "/",
      routes: {
        "/" : (context) => const SplashScreen(),
        "/LoginScreen" : (context) => const LoginScreen(),
        "/OnBoardingScreen" : (context) => const OnBoardingScreen(),
        "/DashBoardScreen" : (context) => const DashBoardScreen(),
        "/ForgotPasswordScreen" : (context) => const ForgotPasswordScreen(),
        "/RegisterScreen" : (context) => const RegisterScreen(),
        "/AddRfqScreen" : (context) => const AddRfqScreen(),
      },
    );
  }
}

