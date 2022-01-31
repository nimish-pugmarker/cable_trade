import 'package:cable_trade/Screens/Modules/HomeScreens/rfqListScreen.dart';
import 'package:cable_trade/Utils/myColors.dart';
import 'package:cable_trade/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with SingleTickerProviderStateMixin{
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime currentBackPressTime  = DateTime.now();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> onAppExit() {
    DateTime now = DateTime.now();
    print(now.difference(currentBackPressTime));
    print(now.difference(currentBackPressTime) > const Duration(seconds: 1));
    if (now.difference(currentBackPressTime) > const Duration(seconds: 1)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Tap again to exit the app",
          toastLength: Toast.LENGTH_SHORT);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onAppExit,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Cable Trades", style: TextStyle(color: MyColors.colorCustomTheme),),
          elevation: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Text("Buy Cables", style: TextStyle(color: Colors.black),),
              ),
              Tab(
                child: Text("RFQs", style: TextStyle(color: Colors.black),),
              ),
              Tab(
                child: Text("My Inventory", style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        ),
        body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          child: TabBarView(
            controller: _tabController,
            children: [
              Container(
                child: Center(child: Text("Tab 1"),),
              ),
              RfqListScreen(),
              Container(
                child: Center(child: Text("Tab 3"),),
              ),
            ],
          ),
        ),
      )
    );
  }
}
