import 'dart:convert';

import 'package:cable_trade/Networking/ApiProviderNew.dart';
import 'package:cable_trade/Utils/MySharedPreferences.dart';
import 'package:cable_trade/Utils/helperMethods.dart';
import 'package:cable_trade/Utils/myColors.dart';
import 'package:cable_trade/Utils/sizeConfig.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late ProgressDialog pr;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  String _value = "Select your interest";
  bool termsConditions = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context, type: ProgressDialogType.normal, isDismissible: false,);

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                SvgPicture.asset("assets/images/logo.svg", height: SizeConfig.verticalBlockSize * 5,),
                SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                const Text("Create Your Account", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold ),),
                const Text("All fields are mandatory", style: TextStyle(fontSize: 16,),),
                SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: firstNameController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      hintText: "First Name",
                                      labelText: "First Name"
                                  ),
                                  validator: (value) => MyValidator.validateNameField(value),
                                ),
                              ),
                              SizedBox(width: 15,),
                              Expanded(
                                child: TextFormField(
                                  controller: lastNameController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      hintText: "Last Name",
                                      labelText: "Last Name"
                                  ),
                                  validator: (value) => MyValidator.validateNameField(value),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                hintText: "Email ID",
                                labelText: "Email ID"
                            ),
                            validator: (value) => MyValidator.validateEmail(value),
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          Row(
                            children: [
                              SizedBox(
                                width: SizeConfig.screenWidth / 4,
                                child: TextFormField(
                                  controller: countryCodeController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      hintText: "Code",
                                      labelText: "Code"
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty)
                                      return "Country code can not be empty";
                                    if(value.length > 6)
                                      return "Country code can not be more than 6 digits";

                                  },
                                ),
                              ),
                              SizedBox(width: 15,),
                              Expanded(
                                child: TextFormField(
                                  controller: mobileController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      hintText: "Mobile number",
                                      labelText: "Mobile number"
                                  ),
                                  validator: (value) => MyValidator.validateMobile(value),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  isExpanded: true,
                                  borderRadius: BorderRadius.circular(15),
                                  value: _value,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Select your interest"),
                                      value: "Select your interest",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Buy"),
                                      value: "Buy",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Sell"),
                                      value: "Sell",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("Both"),
                                      value: "Both",
                                    ),
                                  ],
                                  onChanged: (value){
                                    print(value);
                                    setState(() {
                                      _value = value.toString();
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                hintText: "Password",
                                labelText: "Password"
                            ),
                            validator: (value) => MyValidator.validatePassword(value),
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          TextFormField(
                            controller: rePasswordController,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                hintText: "Re-enter Password",
                                labelText: "Re-enter Password"
                            ),
                            validator: (value){
                              if(value!.isEmpty)
                                return "Please re-enter your password";
                              if(value.toString() != passwordController.text)
                                return "Passwords do not match";
                            },
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          CheckboxListTile(
                            value: termsConditions,
                            controlAffinity: ListTileControlAffinity.leading,
                            title: RichText(
                              text: TextSpan(
                                text: "I agree to all the ",
                                  style: TextStyle(color: Colors.black,),
                                  children: [
                                  TextSpan(
                                    text: "Terms & Privacy policy",
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, decoration: TextDecoration.underline)
                                  )
                                ]
                              ),
                            ),
                            onChanged: (value){
                              setState(() {
                                termsConditions = value!;
                              });
                            }),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          MaterialButton(
                            onPressed: ()async{
                              if(termsConditions) {
                                if (_formKey.currentState!.validate()) {
                                  if(_value == "Select your interest"){
                                    Fluttertoast.showToast(
                                        msg: "Please select your interest",
                                        backgroundColor: MyColors.colorCustomTheme,
                                        textColor: Colors.white,
                                        toastLength: Toast.LENGTH_LONG
                                    );
                                  }else {
                                    FocusScope.of(context).unfocus();
                                    pr.style(message: "Please wait",
                                        child: const CircularProgressIndicator());
                                    pr.show();
                                    Map<String, dynamic> data = Map();
                                    data["first_name"] =
                                        firstNameController.text;
                                    data["last_name"] = lastNameController.text;
                                    data["email"] = emailController.text;
                                    data["country_code"] =
                                        countryCodeController.text;
                                    data["mobile_number"] =
                                        mobileController.text;
                                    data["password"] = passwordController.text;
                                    data["password_confirmation"] = passwordController.text;
                                    data["intrest"] = _value;
                                    print(data);
                                    await Future.delayed(Duration(seconds: 1));
                                    String result = await ApiProviderNew().register(data);
                                    if(result == "SocketException" || result == "TimeoutException"){
                                      if(pr.isShowing()){
                                        pr.hide();
                                      }
                                    }
                                    else {
                                      if(pr.isShowing()){
                                        pr.hide();
                                      }
                                      Map<String,dynamic> temp = jsonDecode(result);
                                      MySharedPreferences().addUserData(jsonEncode(temp["user"]));
                                      MySharedPreferences().addApiToken(temp["access_token"]);
                                      Navigator.pushReplacementNamed(context, "/DashBoardScreen");
                                    }
                                  }
                                }
                              }else
                                Fluttertoast.showToast(
                                  msg: "Please agree to Terms & Privacy policy",
                                  backgroundColor: MyColors.colorCustomTheme,
                                  textColor: Colors.white,
                                  toastLength: Toast.LENGTH_LONG
                                );
                            },
                            child: const Text("CREATE ACCOUNT", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                            color: MyColors.colorCustomTheme,
                            height: 55,
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            minWidth: SizeConfig.screenWidth,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
                Container(height: 2, width: SizeConfig.screenWidth, color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: RichText(
                    text: TextSpan(
                        text: "Already Have an Account? ",
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: "SIGN IN",
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.pop(context);
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
    );
  }
}
