import 'dart:convert';

import 'package:cable_trade/Networking/ApiProviderNew.dart';
import 'package:cable_trade/Utils/myColors.dart';
import 'package:cable_trade/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';

class AddRfqScreen extends StatefulWidget {
  const AddRfqScreen({Key? key}) : super(key: key);

  @override
  _AddRfqScreenState createState() => _AddRfqScreenState();
}

class _AddRfqScreenState extends State<AddRfqScreen> {
  TextEditingController deliveryCity = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController requiredByDate = TextEditingController();
  TextEditingController expiresOnDate = TextEditingController();
  String partiallyAccepted = "No";
  String partiallyAllowed = "No";
  String cityCode = "0";
  Map<String, dynamic> sendData = Map();

  TextEditingController brandNameController = TextEditingController();
  TextEditingController cableCategoryController = TextEditingController();
  TextEditingController manufactureController = TextEditingController();
  TextEditingController cableTypeController = TextEditingController();
  TextEditingController shieldTypeController = TextEditingController();
  TextEditingController armorTypeController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController totalQuantityController = TextEditingController();
  TextEditingController lengthPerDrumController = TextEditingController();


  PageController _pageController = PageController(initialPage: 0);
  late Future<bool> _future;
  List<dynamic> cities = [];
  List<dynamic> brands = [];
  List<dynamic> cableCategory = [];
  List<dynamic> cableType = [];
  List<dynamic> shields = [];
  List<dynamic> armors = [];
  Map<String, dynamic> shieldType = Map();
  Map<String, dynamic> armorType = Map();

  Future<void> selectDate1()async{
    DateTime? date = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now());
    requiredByDate.text = DateFormat("yyyy-MM-dd").format(date!);
  }
  Future<void> selectDate2()async{
    DateTime? date = await showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(Duration(days: 365)),
        lastDate: DateTime.now());
    expiresOnDate.text = DateFormat("yyyy-MM-dd").format(date!);

  }


  @override
  void initState() {
    super.initState();
    _future = getDetails();

  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> getDetails()async{
    String result = await ApiProviderNew().getRfqDetails();
    print(result);
    dynamic data = jsonDecode(result);
    cities = data["cities"];
    brands = data["brands"];
    print(brands);
    cableCategory = data["cableTypes"];
    cableType = data["cableTypeNews"];
    shieldType = data["shields"];
    armorType = data["armourings"];
    shieldType.values.forEach((element) {shields.add(element.toString());});
    armorType.values.forEach((element) {armors.add(element.toString());});
    return true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add RFQ"),
      ),
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: FutureBuilder(
          future: _future,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: SizeConfig.verticalBlockSize * 3,),
                          Text("All fields are mandatory"),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: deliveryCity,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Delivery City ",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                              ),
                            ),
                            suggestionsCallback: (pattern){
                              return cities.where((element) => element["name"].toLowerCase().startsWith(pattern.toLowerCase())).toList();
                            },
                            itemBuilder: (context, suggestion){
                              dynamic temp = suggestion as dynamic;
                              return ListTile(
                                title: Text(temp["name"].toString()),
                              );
                            },
                            onSuggestionSelected: (suggestion){
                              dynamic temp = suggestion as dynamic;
                              deliveryCity.text = temp["name"].toString();
                              cityCode = temp["id"].toString();
                            },
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          TextField(
                            controller: pinCode,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Pincode*",
                              hintText: "Pincode*",
                            ),
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          InkWell(
                            onTap: selectDate1,
                            child: TextField(
                              controller: requiredByDate,
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: "Delivery Required By*",
                                hintText: "dd/mm/yyyy",
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          Text("Partial Deleivery Accepted"),
                          GroupButton(
                            isRadio: true,
                            spacing: 10,
                            onSelected: (index, isSelected){
                              print("index : $index");
                              if(index == 0)
                                partiallyAccepted = "Yes";
                              else
                                partiallyAccepted = "No";
                            },
                            buttons: ["Yes", "No"],
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          Text("Is Supplier Allowed to offer Partial RFQ"),
                          GroupButton(
                            isRadio: true,
                            spacing: 10,
                            onSelected: (index, isSelected){
                              print("index : $index");
                              if(index == 0)
                                partiallyAllowed = "Yes";
                              else
                                partiallyAllowed = "No";
                            },
                            buttons: ["Yes", "No"],
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          InkWell(
                            onTap: selectDate2,
                            child: TextField(
                              controller: expiresOnDate,
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: "RFQ Expires On*",
                                hintText: "dd/mm/yyyy",
                              ),
                            ),
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 3,),
                          MaterialButton(
                            onPressed: (){
                              if(deliveryCity.text.isEmpty || pinCode.text.isEmpty || requiredByDate.text.isEmpty
                                  || expiresOnDate.text.isEmpty){
                                Fluttertoast.showToast(msg: "Please fill all the details");
                              }
                              else{
                                sendData["city"] = deliveryCity.text;
                                sendData["delivery_pincode"] = pinCode.text;
                                sendData["delivery_required_by"] = requiredByDate.text;
                                sendData["expiry_date"] = expiresOnDate.text;
                                sendData["allow_partial_delivery"] = partiallyAllowed;
                                sendData["allow_partial_qoute"] = partiallyAccepted;
                                print(sendData);
                                _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);
                              }
                            },
                            color: MyColors.colorCustomTheme,
                            child: Text("Continue", style: TextStyle(color: Colors.white, fontSize: 18),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: brandNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Brand Name ",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                              ),
                            ),
                            suggestionsCallback: (pattern){
                              return brands.where((element) => element["brand_name"].toLowerCase().startsWith(pattern.toLowerCase())).toList();
                            },
                            itemBuilder: (context, suggestion){
                              dynamic temp = suggestion as dynamic;
                              return ListTile(
                                title: Text(temp["brand_name"].toString()),
                              );
                            },
                            onSuggestionSelected: (suggestion){
                              dynamic temp = suggestion as dynamic;
                              brandNameController.text = temp["brand_name"].toString();
                            },
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: cableCategoryController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Cable Category ",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                              ),
                            ),
                            suggestionsCallback: (pattern){
                              return cableCategory.where((element) => element["cable_name"].toLowerCase().startsWith(pattern.toLowerCase())).toList();
                            },
                            itemBuilder: (context, suggestion){
                              dynamic temp = suggestion as dynamic;
                              return ListTile(
                                title: Text(temp["cable_name"].toString()),
                              );
                            },
                            onSuggestionSelected: (suggestion){
                              dynamic temp = suggestion as dynamic;
                              cableCategoryController.text = temp["cable_name"].toString();
                            },
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          TextField(
                            controller: manufactureController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Manufacture Part No",
                              hintText: "Manufacture Part No",
                            ),
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: cableTypeController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Cable Type ",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                              ),
                            ),
                            suggestionsCallback: (pattern){
                              return cableType.where((element) => element["name"].toLowerCase().startsWith(pattern.toLowerCase())).toList();
                            },
                            itemBuilder: (context, suggestion){
                              dynamic temp = suggestion as dynamic;
                              return ListTile(
                                title: Text(temp["name"].toString()),
                              );
                            },
                            onSuggestionSelected: (suggestion){
                              dynamic temp = suggestion as dynamic;
                              cableTypeController.text = temp["name"].toString();
                            },
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: shieldTypeController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Type of Shield",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                              ),
                            ),
                            suggestionsCallback: (pattern){
                              return shields.where((element) => element.toLowerCase().startsWith(pattern.toLowerCase())).toList();
                            },
                            itemBuilder: (context, suggestion){
                              return ListTile(
                                title: Text(suggestion.toString()),
                              );
                            },
                            onSuggestionSelected: (suggestion){
                              shieldTypeController.text = suggestion.toString();
                            },
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: armorTypeController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Type of Armouring",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                              ),
                            ),
                            suggestionsCallback: (pattern){
                              return armors.where((element) => element.toLowerCase().startsWith(pattern.toLowerCase())).toList();
                            },
                            itemBuilder: (context, suggestion){
                              return ListTile(
                                title: Text(suggestion.toString()),
                              );
                            },
                            onSuggestionSelected: (suggestion){
                              armorTypeController.text = suggestion.toString();
                            },
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          TextField(
                            controller: itemDescriptionController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Item Description",
                              hintText: "Item Description",
                            ),
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: totalQuantityController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      hintText: "Total Quantity(mt)",
                                      labelText: "Total Quantity(mt)"
                                  ),

                                ),
                              ),
                              SizedBox(width: 15,),
                              Expanded(
                                child: TextFormField(
                                  controller: lengthPerDrumController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      hintText: "Length Per Drum/Coil(mt)",
                                      labelText: "Length Per Drum/Coil(mt)"
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                          TextField(
                            controller: itemDescriptionController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Brief Application",
                              hintText: "Brief Application",
                            ),
                          ),
                          SizedBox(height: SizeConfig.verticalBlockSize * 3,),

                          MaterialButton(
                            onPressed: (){
                              _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeIn);

                            },
                            color: MyColors.colorCustomTheme,
                            child: Text("Continue", style: TextStyle(color: Colors.white, fontSize: 18),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Text("Page 3"),
                  ),
                ],
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
