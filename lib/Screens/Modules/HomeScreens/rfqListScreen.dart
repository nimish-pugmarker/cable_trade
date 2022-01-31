import 'dart:convert';

import 'package:cable_trade/Networking/ApiProviderNew.dart';
import 'package:cable_trade/Utils/myColors.dart';
import 'package:cable_trade/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class RfqListScreen extends StatefulWidget {
  const RfqListScreen({Key? key}) : super(key: key);

  @override
  _RfqListScreenState createState() => _RfqListScreenState();
}

class _RfqListScreenState extends State<RfqListScreen> {
  late Future<bool> _future;
  List<dynamic> rfqList = [];

  @override
  void initState() {
    super.initState();
    _future = getRfqs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> getRfqs() async{
    String result = await ApiProviderNew().getRfqList();
    rfqList = jsonDecode(result)["rfqs"]["data"];
    print(rfqList.first["city"]["name"]);
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, "/AddRfqScreen"),
        elevation: 2,
        backgroundColor: MyColors.colorCustomTheme,
        child: Icon(Icons.add),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView(
                children: List.generate(rfqList.length, (index){
                  return Padding(
                    padding: EdgeInsets.all(15),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Row(

                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("RFQ No. RFQ${index+1}"),
                                    Text("Delivery City : City"),
                                    Text("RFQ Expires on: 12/12/1212"),

                                  ],
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Date: 12/21/2121"),
                                    Text("Delivery Pincode: 123232"),
                                    Text("RFQ Status: Active"),

                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Total number of items : 2"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              );
            }
            else
              return Center(child: CircularProgressIndicator(color: MyColors.colorCustomTheme,),);
          },
        ),
      ),
    );
  }
}
