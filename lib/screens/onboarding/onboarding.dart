import 'package:flutter/material.dart';
import 'package:generalshop/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_model.dart';
import 'onboarding_screen.dart';
import 'package:generalshop/screens/screen_utitlities/screent_utitlity.dart';

class Onboarding extends StatefulWidget {
  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
   int currentIndex=0;
   double screenWidth;
   double screenHeight;
  PageController _pageController;
  bool lastpage=false;
  List <OnBoardingModel>screens=[
OnBoardingModel(
  Image: "assets/images/onboarding2.jpg",
  Title: "Welcom !",
  Description: "Now We Were Up In Now We Were Up In Now We Were Up In Now We Were Up In ",

),
    OnBoardingModel(
      Image: "assets/images/onboarding1.jpg",
      Title: " Add To Cart",
      Description: " Now We Were Up In Now We Were Up In Now We Were Up In Now We Were Up In",

    )
,
    OnBoardingModel(
      Image: "assets/images/onboarding3.jpg",
      Title: " Enjoy Purchase ",
      Description: " Now We Were Up In Now We Were Up In Now We Were Up In Now We Were Up In ",

    )

  ];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }
  @override
  void initState(){
    super.initState();
    _pageController =PageController(
      initialPage: 0,
    );
  }
  @override
  Widget build(BuildContext context) {
    double _mt=MediaQuery.of(context).size.height*0.2;
     screenWidth=MediaQuery.of(context).size.width;
     screenHeight= MediaQuery.of(context).size.height;

    return Scaffold(

      body: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              padding: EdgeInsets.only(top:_mt),
              height:screenHeight,
              width:screenWidth,
              color: Colors.white,
              child: PageView.builder(
                controller: _pageController
              ,itemCount: screens.length
                  ,itemBuilder: (BuildContext context,int postion){
                return SingleOnBoarding(screens[postion]);
                  },
                // the index is the number of screen
                onPageChanged: (int index){
                  setState((){
                  currentIndex=index;
                  if (index==(screens.length-1)){
                    lastpage=true;
                  }
                  else{
                    lastpage=false;
                  }
                  });
                },
                  ),
            ),
          ),
          Transform.translate(
            offset: Offset(5,-(screenHeight*0.1)),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:
                 _drawdots(screens.length)
               ,
              ),
            ),
          ),

          (lastpage) ?  _showButton():Container()

        ],
      ),
    );
  }
  Widget _showButton(){
return Container(
  child: Transform.translate(
    offset: Offset(0,-(screenHeight*0.05) ),
    child: SizedBox(
      width: screenWidth*0.75,
      height: 33,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: ScreenUtitilities.mainBlue,


        onPressed: ()async{

          var pref =await SharedPreferences.getInstance();
          pref.setBool('is_seen', false);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()),);

        },
        child: Text('START',style: TextStyle(color: Colors.white,fontSize: 20,letterSpacing:5),),
      ),


    ),
  ),
);
  }
  List<Widget>_drawdots(int que){
    List<Widget>widget=[];
    for (int i=0;i<que;i++)
     widget.add(Container(
       decoration: BoxDecoration(borderRadius:BorderRadiusDirectional.circular(5),
         color: (i==currentIndex)?ScreenUtitilities.mainBlue:ScreenUtitilities.lightGray,),
       width: 35,
       height: 4,
       margin:(i==que-1)? EdgeInsets.only(right: 0): EdgeInsets.only(right: 20),
     ),) ;
    return widget;
  }

}
