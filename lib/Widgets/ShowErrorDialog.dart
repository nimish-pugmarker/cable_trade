import 'package:cable_trade/Utils/MySharedPreferences.dart';
import 'package:cable_trade/Utils/myColors.dart';
import 'package:cable_trade/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class ShowErrorDialog extends StatefulWidget {
  final Map<String, dynamic>? errorData;

  ShowErrorDialog({@required this.errorData});

  @override
  _ShowErrorDialogState createState() => _ShowErrorDialogState();
}

class _ShowErrorDialogState extends State<ShowErrorDialog> {

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
    return AlertDialog(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      title: Text("Data Entry Error", style: TextStyle(color: MyColors.colorCustomTheme, fontSize: 16),),
      content: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(widget.errorData!.length, (index) => Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Error inserting ${widget.errorData!.keys.elementAt(index)}"),
                      SizedBox(height: 5,),
                      Text("Error : ${widget.errorData!.values.elementAt(index)}"),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: (){
            MySharedPreferences().addErrorData("");
            Navigator.pop(context);
          },
          child: const Text("OK", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),),
          color: MyColors.colorCustomTheme,
          height: 35,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          minWidth: SizeConfig.screenWidth / 4,
        ),
      ],
    );
  }
}
