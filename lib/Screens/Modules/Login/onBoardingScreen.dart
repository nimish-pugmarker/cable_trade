import 'package:cable_trade/Utils/myColors.dart';
import 'package:cable_trade/Utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: SizeConfig.screenHeight / 3,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(100), topLeft: Radius.circular(100)),
                    color: MyColors.myBlue
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(SizeConfig.horizontalBlockSize * 15, SizeConfig.verticalBlockSize * 5,
                      SizeConfig.horizontalBlockSize * 15, SizeConfig.verticalBlockSize * 3),
                  child: Column(
                    children: [
                      Text("Buy any type of cables with less MOQ",
                        style: TextStyle(color: Colors.white, fontSize: 22), textAlign: TextAlign.center,),
                      SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                      Text("You can browse & ask for an offer on your require cables from the huge pool of inventory submitted by users",
                        style: TextStyle(color: Colors.white, fontSize: 13), textAlign: TextAlign.center,),
                      Expanded(child: SizedBox(height: SizeConfig.verticalBlockSize * 2,)),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 10,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green,
                                  ),
                                ),
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: (){
                              _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                            },
                            child: Row(
                              children: [
                                Text("Next", style: TextStyle(color: Colors.white),),
                                SizedBox(width: 5,),
                                Icon(Icons.arrow_forward, color: Colors.white,),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            color: Colors.white,
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: SizeConfig.screenHeight / 3,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(100), topLeft: Radius.circular(100)),
                    color: MyColors.myBlue
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(SizeConfig.horizontalBlockSize * 15, SizeConfig.verticalBlockSize * 5,
                      SizeConfig.horizontalBlockSize * 15, SizeConfig.verticalBlockSize * 3),
                  child: Column(
                    children: [
                      Text("Now submitting RFQ & getting quotation is lot easier",
                        style: TextStyle(color: Colors.white, fontSize: 22), textAlign: TextAlign.center,),
                      SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                      Text("You can browse & ask for an offer on your require cables from the huge pool of inventory submitted by users",
                        style: TextStyle(color: Colors.white, fontSize: 13), textAlign: TextAlign.center,),
                      Expanded(child: SizedBox(height: SizeConfig.verticalBlockSize * 2,)),
                      Row(
                        children: [
                          MaterialButton(
                            onPressed: (){
                              _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.arrow_back, color: Colors.white,),
                                SizedBox(width: 5,),
                                Text("Back", style: TextStyle(color: Colors.white),),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  height: 10,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green,
                                  ),
                                ),
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: (){
                              _pageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                            },
                            child: Row(
                              children: [
                                Text("Next", style: TextStyle(color: Colors.white),),
                                SizedBox(width: 5,),
                                Icon(Icons.arrow_forward, color: Colors.white,),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      Stack(
        children: [
          Container(
            height: SizeConfig.screenHeight,
            width: SizeConfig.screenWidth,
            color: Colors.white,
          ),
          Positioned(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: SizeConfig.screenHeight / 3,
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(100), topLeft: Radius.circular(100)),
                    color: MyColors.myBlue
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(SizeConfig.horizontalBlockSize * 15, SizeConfig.verticalBlockSize * 5,
                      SizeConfig.horizontalBlockSize * 15, SizeConfig.verticalBlockSize * 3),
                  child: Column(
                    children: [
                      Text("Create place for your inventory in the digital world",
                        style: TextStyle(color: Colors.white, fontSize: 22), textAlign: TextAlign.center,),
                      SizedBox(height: SizeConfig.verticalBlockSize * 2,),
                      Text("Suppliers can showcase their inventory digitally also industries can upload their unused stock to get requests from interested buyers",
                        style: TextStyle(color: Colors.white, fontSize: 13), textAlign: TextAlign.center,),
                      Expanded(child: SizedBox(height: SizeConfig.verticalBlockSize * 2,)),
                      Row(
                        children: [
                          MaterialButton(
                            onPressed: (){
                              _pageController.previousPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.arrow_back, color: Colors.white,),
                                SizedBox(width: 5,),
                                Text("Back", style: TextStyle(color: currentIndex != 0 ? Colors.white : MyColors.myBlue),),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  height: 10,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          MaterialButton(
                            onPressed: () => Navigator.pushReplacementNamed(context, "/LoginScreen"),
                            color: MyColors.colorCustomTheme,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text("Get Started", style: TextStyle(color: Colors.white, fontSize: 13),),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ];
    return Scaffold(
      body: Container(
        height: SizeConfig.screenHeight,
        width: SizeConfig.screenWidth,
        child: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: pages,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index){
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
