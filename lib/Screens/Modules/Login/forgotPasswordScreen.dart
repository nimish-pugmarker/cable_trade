import 'package:cable_trade/Utils/helperMethods.dart';
import 'package:cable_trade/Utils/myColors.dart';
import 'package:cable_trade/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  late ProgressDialog pr;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: SizeConfig.verticalBlockSize * 15,),
                    SvgPicture.asset("assets/images/logo.svg",),
                    SizedBox(height: SizeConfig.verticalBlockSize * 5,),
                    const Text("Reset Password", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold ),),
                    SizedBox(height: SizeConfig.verticalBlockSize * 5,),
                    TextFormField(
                      controller: emailController,
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
                    SizedBox(height: SizeConfig.verticalBlockSize * 5,),
                    MaterialButton(
                      onPressed: ()async{

                      },
                      child: const Text("Send Reset Password Link", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                      color: MyColors.colorCustomTheme,
                      height: 55,
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      minWidth: SizeConfig.screenWidth,
                    ),
                    SizedBox(height: SizeConfig.verticalBlockSize * 3,),
                    Expanded(child: Container(),),
                    Container(height: 2, width: SizeConfig.screenWidth, color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child:InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text("BACK TO SIGN IN",
                          style: TextStyle(fontSize: 18, color: MyColors.colorCustomTheme, decoration: TextDecoration.underline),),
                      ),
                    )

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
