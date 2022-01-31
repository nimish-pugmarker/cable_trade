import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cable_trade/Networking/Constants.dart';
import 'package:cable_trade/Utils/MySharedPreferences.dart';
import 'package:cable_trade/Utils/helperMethods.dart';
import 'package:cable_trade/Utils/myColors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;


class ApiProviderNew {
  final String baseUrl = Constants.apiBaseUrl;

  Future<String> login(String userName, String password) async {
    String apiName = "api_login";
    http.Response? response;
    String result= "None";
    Map<String, String> headers = {
    'Content-Type' : 'application/json',
    'Accept' : 'application/json'
    };
    Map<String, dynamic> data = Map<String, dynamic>();
    data["email"] = userName;
    data["password"] = password;
    print(baseUrl);
    try {
      response = await http.post(Uri.parse("$baseUrl$apiName"), headers: headers, body: jsonEncode(data)).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      String status = await HelperMethods.showErrorMessage(response,);
      print(status);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;

    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;

    }


    return result;
  }

  Future<String> authenticate() async {
    String apiName = "api_validate_token";
    http.Response? response;
    String result= "None";

    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken",
      'Content-Type' : 'application/json',
      'Accept' : 'application/json'
    };
    try {
      response = await http.post(Uri.parse("$baseUrl$apiName"), headers: header).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }
    return result;
  }

  Future<String> register(Map<String, dynamic> data) async {
    String apiName = "api_register";
    http.Response? response;
    String result= "None";

    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken",
      'Content-Type' : 'application/json',
      'Accept' : 'application/json'
    };
    
    try {
      response = await http.post(Uri.parse("$baseUrl$apiName"), headers: header, body: jsonEncode(data)).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      print(response.body);
      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }
    return result;
  }

  Future<String> getRfqDetails() async {
    String apiName = "rfq/resources?resource";

    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken",
      'Content-Type' : 'application/json',
      'Accept' : 'application/json'
    };
    try {
      response = await http.get(Uri.parse("$baseUrl$apiName"), headers: header).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      // print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> getRfqList() async {
    String apiName = "rfq?per_page=100";

    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken",
      'Content-Type' : 'application/json',
      'Accept' : 'application/json'
    };

    try {
      response = await http.get(Uri.parse("$baseUrl$apiName"), headers: header,).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      // print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> getDocumentsList(int currentPage, bool isSearch,
      String? query, String clientId, String type, String filter) async {
    late String apiName;
    if(query == null) query = "";
    if(!isSearch) {
      if (currentPage == 1) {
        apiName = "documents/docInnerSearch/$clientId?type=$type&filter=$filter";
      } else {
        apiName = "documents/docInnerSearch/$clientId?type=$type&filter=$filter&page=$currentPage";
      }
    }else{
      if (currentPage == 1) {
        apiName = "documents/docInnerSearch/$clientId?type=$type&search=$query";
      } else {
        apiName = "documents/docInnerSearch/$clientId?type=$type&search=$query&page=$currentPage";
      }
    }
    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    print("$baseUrl$apiName");
    try {
      response = await http.get(Uri.parse("$baseUrl$apiName"), headers: header).timeout(const Duration(seconds: 7));
      print(response.statusCode);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> getDocumentTypes(String clientId, String type)async{
    late http.Response response;
    String apiName = "documents/create?client_id=$clientId&type=$type";
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try{
      response = await http.get(Uri.parse("$baseUrl$apiName"), headers: header);
      print(response.statusCode);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<http.Response> deleteDocument(int id)async{
    late http.Response response;
    String apiName = "documents/$id";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try{
      response = await http.delete(Uri.parse("$baseUrl$apiName"), headers: header);
      print(response.statusCode);
    }on SocketException {
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }

    return response;
  }

  Future<String> addDocument(Map<String, dynamic> document) async {
    String apiName = "documents";
    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try {
      response = await http.post(Uri.parse("$baseUrl$apiName"), headers: header, body: document).timeout(const Duration(seconds: 10));
      print(response.statusCode);
      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> editDocument(Map<String, dynamic> document) async {
    String apiName = "documents/${document["document_id"]}";
    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try {
      response = await http.patch(Uri.parse("$baseUrl$apiName"), headers: header, body: document).timeout(const Duration(seconds: 10));
      print(response.statusCode);
      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> getClientsListing(int currentPage, String? filter, Map<String,dynamic>? sorting) async {
    late String apiName;
    late Uri uri;
    if(sorting!.isEmpty) {
      apiName = "clients?status=$filter";
      uri = Uri.parse("$baseUrl$apiName");
    }
    else{
      sorting["status"] = filter;
      uri = Uri.http("collabiro.pugmarker.org", "/api/pm_api/clients", sorting);
      print(uri);
      // return "SocketException";
    }

    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try {
      response = await http.get(uri, headers: header).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      // print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> getClientDetails(String clientId) async {
    String apiName = "clients/$clientId";

    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try {
      response = await http.get(Uri.parse("$baseUrl$apiName"), headers: header).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      // print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> getDataForAddClient() async {
    late String apiName;
    apiName = "clients/create";

    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try {
      print("$baseUrl$apiName");
      response = await http.get(Uri.parse("$baseUrl$apiName"), headers: header).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      // print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> addClientStep1(Map<String, dynamic> data) async {
    late String apiName;
    apiName = "clients";

    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try {
      print("$baseUrl$apiName");
      response = await http.post(Uri.parse("$baseUrl$apiName"), headers: header, body: data).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      // print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> updateClientStep1(Map<String, dynamic> data) async {
    late String apiName;
    apiName = "clients/${data["clientId"]}";

    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try {
      print("$baseUrl$apiName");
      response = await http.post(Uri.parse("$baseUrl$apiName"), headers: header, body: data).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      // print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> addClientStep2(Map<String, dynamic> data) async {
    late String apiName;
    apiName = "clients/${data["clientId"]}";
    print(apiName);
    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try {
      print("$baseUrl$apiName");
      response = await http.post(Uri.parse("$baseUrl$apiName"), headers: header, body: data).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> updateClientStep2(Map<String, dynamic> data) async {
    late String apiName;
    apiName = "clients/${data["clientId"]}";
    print(apiName);
    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try {
      print("$baseUrl$apiName");
      response = await http.patch(Uri.parse("$baseUrl$apiName"), headers: header, body: data).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> addExtraGstin(Map<String, dynamic> data) async {
    late String apiName;
    apiName = "clients/${data["clientId"]}";
    print(apiName);
    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try {
      print("$baseUrl$apiName");
      response = await http.post(Uri.parse("$baseUrl$apiName"), headers: header, body: data).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      // print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> updateExtraGstin(Map<String, dynamic> data) async {
    late String apiName;
    apiName = "clients/${data["clientId"]}";
    print(apiName);
    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try {
      print("$baseUrl$apiName");
      response = await http.post(Uri.parse("$baseUrl$apiName"), headers: header, body: data).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      // print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> addDirector(Map<String, dynamic> data) async {
    late String apiName;
    apiName = "clients/${data["clientId"]}";
    print(apiName);
    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try {
      print("$baseUrl$apiName");
      response = await http.post(Uri.parse("$baseUrl$apiName"), headers: header, body: data).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> deleteEntry(String id) async {
    late String apiName;
    apiName = "clients/$id";
    print(apiName);
    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    try {
      print("$baseUrl$apiName");
      response = await http.delete(Uri.parse("$baseUrl$apiName"), headers: header,).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }

  Future<String> changeStatus(String id, String status) async {
    late String apiName;
    apiName = "clients/changeStatus/$id";
    print(apiName);
    http.Response? response;
    String result = "None";
    String apiToken = await MySharedPreferences().getApiToken();
    Map<String, String> header = {
      "Authorization" : "Bearer $apiToken"
    };
    Map<String, String> data = {
      "user_status" : status
    };
    try {
      print("$baseUrl$apiName");
      response = await http.post(Uri.parse("$baseUrl$apiName"), headers: header, body: data).timeout(const Duration(seconds: 7));
      print(response.statusCode);
      print(response.body);

      String status = await HelperMethods.showErrorMessage(response);
      if(status == "Success") result = response.body;

    } on SocketException {
      result = "SocketException";
      Fluttertoast.showToast(
        msg: "No Internet Connection. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    } on TimeoutException{
      result = "TimeoutException";
      Fluttertoast.showToast(
        msg: "Something went wrong. Please try later!",
        backgroundColor: MyColors.colorCustomTheme,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return result;
    }

    return result;
  }


}