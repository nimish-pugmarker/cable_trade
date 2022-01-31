import 'dart:convert';
import 'dart:io';

import 'package:cable_trade/Utils/MySharedPreferences.dart';
import 'package:cable_trade/Utils/myColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class MyValidator{

  static String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if(value!.isEmpty)
      return "email can not be empty";
    else if (!regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return null;
  }

  static String? validatePassword(String? value) {
    String pattern =
        r'^[a-zA-Z0-9-.@&$*_]+$';
    RegExp regex = RegExp(pattern);
    if(value!.isEmpty)
      return "Password can not be empty";
    else if(value.length < 8)
      return "Password must be minimum 8 characters long";
    else if(value.length > 192)
      return "Password length can not exceed 192 characters";
    else if (!regex.hasMatch(value))
      return 'Only alphabets, numbers and _ @ . # & \$ characters allowed';
    else
      return null;
  }

  static String? validateMobile(String? value) {
    String pattern =
        r'^[0-9]+$';
    RegExp regex = RegExp(pattern);
    if(value!.isEmpty)
      return "Mobile number can not be empty";
    else if(value.length != 10)
      return "Not a valid mobile number";
    else if (!regex.hasMatch(value))
      return 'Only numbers allowed';
    else
      return null;
  }

  static String? validateUserNameField(String? value) {
    String pattern =
        r'^[a-zA-Z0-9._-]+$';
    RegExp regex = RegExp(pattern);
    if(value!.isEmpty)
      return "Username can not be empty";
    else if (!regex.hasMatch(value))
      return 'Only alphabets, numbers and _ . - characters allowed';
    else if (value.length > 25)
      return 'Name length can not exceed 25 characters';
    else
      return null;
  }

  static String? validateNameField(String? value) {
    String pattern =
        r'^[a-zA-Z0-9 ._-]+$';
    RegExp regex = RegExp(pattern);
    if(value!.isEmpty)
      return "Name can not be empty";
    else if (!regex.hasMatch(value))
      return 'Not a valid link address';
    else if (value.length > 55)
      return 'Name length can not exceed 55 characters';
    else
      return null;
  }

  static String? validateSearchNameField(String? value) {
    String pattern =
        r'^[a-zA-Z0-9 ._-]+$';
    RegExp regex = RegExp(pattern);
    if(value!.isEmpty)
      return null;
    else if (!regex.hasMatch(value))
      return 'Only alphabets, numbers, and characters - . _ allowed in Name';
    else if (value.length > 55)
      return 'Name length can not exceed 55 characters';
    else
      return null;
  }

  static String? validateLinkField(String? value) {
    bool isValid = Uri.parse(value!).isAbsolute;

    if(value.isEmpty)
      return "Name can not be empty";
    if(value.contains(" "))
      return "Link can not contain space in address.";
    else if (!isValid)
      return 'Not a valid link address';
    else if (value.length > 55)
      return 'Name length can not exceed 55 characters';
    else
      return null;
  }

  // static String? validateCommentField(String? value) {
  //   // String pattern =
  //   //     r'^[a-zA-Z0-9]+$'
  //   //     r'^[._-@(){}/%:;?&#]+$';
  //   // RegExp regex = RegExp(pattern);
  //   print(value);
  //   if(value!.isEmpty)
  //     return "Name can not be empty";
  //   else if (value.length > 255)
  //     return 'Name length can not exceed 255 characters';
  //   // else if (!regex.hasMatch(value))
  //   //   return 'Only alphabets, numbers, and characters ._-@(){}[]/%:;?&# allowed in Name';
  //   else
  //     return null;
  // }
}


class HelperMethods{
  static late BuildContext myContext;

  void init(BuildContext context){
    myContext = context;
  }


  static String? getOutDate(dynamic document){
    List<dynamic> history = document["doc_history"];
    dynamic data = history.elementAt(history.indexWhere((element) => element["event"] == "Added Document"));

    return formatDate(data["updated_at"]);

  }

  static String? formatDate(String dateTime){
    late String date;
    DateTime time = DateTime.parse(dateTime);
    date = DateFormat("dd/MM/yyyy").format(time);

    return date;
  }

  static String getDate(DateTime dateTime){
    late String date;
    date = DateFormat("dd/MM/yyyy").format(dateTime);

    return date;
  }

  static String? formatTime(String dateTime){
    late String date;
    DateTime time = DateTime.parse(dateTime);
    date = DateFormat("hh:mm a").format(time.toLocal());


    return date;
  }

  static Future<String> showErrorMessage(http.Response response)async{
    String status = "Fail";
    dynamic temp = jsonDecode(response.body);

    switch(response.statusCode){
      case 200:
        status = "Success";
        break;
      case 201:
        status = "Success";
        break;
      case 401:
        Fluttertoast.showToast(
          msg: "${temp["message"]}",
          backgroundColor: MyColors.colorCustomTheme,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      case 403:
        Fluttertoast.showToast(
          msg: "${temp["message"]}",
          backgroundColor: MyColors.colorCustomTheme,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      case 404:
        Fluttertoast.showToast(
          msg: "Api Not Found!",
          backgroundColor: MyColors.colorCustomTheme,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      case 405:
        Fluttertoast.showToast(
          msg: "Method Not Allowed!",
          backgroundColor: MyColors.colorCustomTheme,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      case 422:
        Fluttertoast.showToast(
          msg: "Something went wrong at server",
          backgroundColor: MyColors.colorCustomTheme,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        // try{
        //   MySharedPreferences().addErrorData(response.body);
        // }catch(error){
        //   print("unprocess: $error");
        // }

        break;
      case 500:
        Fluttertoast.showToast(
          msg: "Server error. Please try later!",
          backgroundColor: MyColors.colorCustomTheme,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        break;
      default:
        Fluttertoast.showToast(
          msg: "Something went wrong. Please try later!",
          backgroundColor: MyColors.colorCustomTheme,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
        break;

    }

    return status;

  }

}