import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalshop/api/helper_api.dart';
import 'package:generalshop/product/product_category.dart';
import 'package:generalshop/product/proudct.dart';
import 'package:generalshop/screens/home_page.dart';
import 'package:generalshop/screens/onboarding/onboarding.dart';
import 'package:generalshop/screens/screen_utitlities/screent_utitlity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/authentication.dart';
import 'customer/user.dart';
import 'package:generalshop/api/proudct_api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var pref = await SharedPreferences.getInstance();
  bool isSeen = true;
  isSeen = pref.getBool('is_seen');
  Widget homePage = HomePage();
  if (isSeen == null || !isSeen) {
    homePage = Onboarding();
  }

  runApp(MyApp(homePage));
}

class MyApp extends StatelessWidget {
  final Widget homePage;
  MyApp(this.homePage);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'General Shop',
      home: homePage,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
          appBarTheme: AppBarTheme(
            actionsIconTheme: IconThemeData(
              color: ScreenUtitilities.textColor,
            ),
            elevation: 0,
            textTheme: TextTheme(
                title: TextStyle(
                    color: ScreenUtitilities.textColor,
                    fontFamily: "Quicksand",
                    fontSize: 22),
                headline: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: ScreenUtitilities.textColor


                ),
                subhead: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: ScreenUtitilities.textColor),
                display1: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: ScreenUtitilities.darkerGrayText),
                display2: TextStyle(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    height: 1.75,
                    letterSpacing: 1.5,
                    color: ScreenUtitilities.darkerGrayText)),
          ),
          primaryColor: Colors.white,
          backgroundColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          tabBarTheme: TabBarTheme(
              labelColor: ScreenUtitilities.textColor,
              labelStyle: TextStyle(
                fontSize: 22,
                fontFamily: "Quicksand",
              ),
              labelPadding:
                  EdgeInsets.only(right: 16, bottom: 12, left: 16, top: 16),
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: ScreenUtitilities.unselectedColor,
              unselectedLabelStyle: TextStyle(
                fontSize: 22,
                fontFamily: "Quicksand",
              )),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: ScreenUtitilities.mainBlue)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Authentication authentication = Authentication();
  ApiProduct proudctapi = ApiProduct();
  HelperApi helperapi = HelperApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("general shop"),
        ),
        //fetch products
        /*  body:Center(
        //child: InkWell(
         // onTap: ()async{
        //    User user = await authentication.login('earnestine.hamill@example.org', 'password');
           // print('user $user');
          //},
           // child: Text('eslam',style: TextStyle(
             // fontSize: 30,
            //),)),
 child: FutureBuilder(
 future:proudctapi.fetchProducts(1),
//   future:authentication.login('homenick.jovany@example.net','password'),
//
   builder: ( BuildContext context,  AsyncSnapshot<List<product>> snapShot){
     switch(snapShot.connectionState )
       {

       case ConnectionState.none:
        _error('no thing happend!!!');
         break;
       case ConnectionState.waiting:
         _loading();
         break;
       case ConnectionState.active:
        _loading();
         break;
       case ConnectionState.done:
        if (snapShot.hasError){
        return  _error(snapShot.error.toString());

        }
        else{
          if (!snapShot.hasData){
            return _error('no data');
          }
          else{
            return ListView.builder(itemBuilder: (BuildContext context,int position){

              return  _drawproduct(snapShot.data[position]);

            },
              itemCount: snapShot.data.length,
            );
          }

        }

         break;
       }
     return Center();
   },
 ),
      )*/

        //fetchProduct
        /*

        body:Center(
          //child: InkWell(
          // onTap: ()async{
          //    User user = await authentication.login('earnestine.hamill@example.org', 'password');
          // print('user $user');
          //},
          // child: Text('eslam',style: TextStyle(
          // fontSize: 30,
          //),)),
          child: FutureBuilder(
            future:proudctapi.fetchProduct(7),
//   future:authentication.login('homenick.jovany@example.net','password'),
//
            builder: ( BuildContext context,  AsyncSnapshot<product> snapShot){
              switch(snapShot.connectionState )
              {

                case ConnectionState.none:
                  _error('no thing happend!!!');
                  break;
                case ConnectionState.waiting:
                  _loading();
                  break;
                case ConnectionState.active:
                  _loading();
                  break;
                case ConnectionState.done:
                  if (snapShot.hasError){
                    return  _error(snapShot.error.toString());

                  }
                  else{
                    if (!snapShot.hasData){
                      return _error('no data');
                    }
                    else{
                    return  _drawproduct(snapShot.data);
                    }

                  }

                  break;
              }
              return Center();
            },
          ),
        )*/

        //fetch categoriess

        body: Center(
          child: FutureBuilder(
            future: helperapi.FetchCategories(),
            builder: (BuildContext context,
                AsyncSnapshot<List<ProductCategory>> snapShot) {
              switch (snapShot.connectionState) {
                case ConnectionState.none:
                  _error('no thing happend!!!');
                  break;
                case ConnectionState.waiting:
                  _loading();
                  break;
                case ConnectionState.active:
                  _loading();
                  break;
                case ConnectionState.done:
                  if (snapShot.hasError) {
                    return _error(snapShot.error.toString());
                  } else {
                    if (!snapShot.hasData) {
                      return _error('no data');
                    } else {
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int position) {
                          ProductCategory category = snapShot.data[position];
                          if (category.image_direction == 'left') {
                            return _drawLeftCard(category);
                          } else {
                            return _drawRightCard(category);
                          }
                        },
                        itemCount: snapShot.data.length,
                      );
                    }
                  }

                  break;
              }
              return Center();
            },
          ),
        )

// authentication
/*
         body:Center(
        //child: InkWell(
         // onTap: ()async{
        //    User user = await authentication.login('earnestine.hamill@example.org', 'password');
           // print('user $user');
          //},
           // child: Text('eslam',style: TextStyle(
             // fontSize: 30,
            //),)),
 child: FutureBuilder(
 //future:proudctapi.fetchProducts(1),
  future:authentication.login('hometyyyyyk.jovany@example.net','password'),

   builder: ( BuildContext context,  AsyncSnapshot snapShot){
     switch(snapShot.connectionState )
       {

       case ConnectionState.none:
        _error('no thing happend!!!');
         break;
       case ConnectionState.waiting:
         _loading();
         break;
       case ConnectionState.active:
        _loading();
         break;
       case ConnectionState.done:
        if (snapShot.hasError){
        return  _error(snapShot.error.toString());

        }
        else{
          if (!snapShot.hasData){
            return _error('no data');
          }
          else{
            return ListView.builder(itemBuilder: (BuildContext context,int position){

              return  _drawproduct(snapShot.data[position]);

            },
              itemCount: snapShot.data.length,
            );
          }

        }

         break;
       }
     return Center();
   },
 ),
      )

*/

        );
  }

  _error(String error) {
    return Container(
      child: Center(
        child: Text(error),
      ),
    );
  }

  _loading() {
    return Container(
        child: Center(
      child: CircularProgressIndicator(),
    ));
  }

  _drawproduct(product pro) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
          // child:  Text(pro.product_title),
          /// code of image

          child: Column(
        children: <Widget>[
          Text(pro.product_title),
          (pro.Images.length > 0)
              ? Image(
                  image: NetworkImage(pro.Images[0]),
                )
              : Container(),
        ],
      )),
    );
  }

  ////////////
  _drawproductCategory(ProductCategory productcategory) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Row(
          children: <Widget>[
            Text(productcategory.category_name),
          ],
        ),

        /// code of image
        /*
        child: Column(
          children: <Widget>[
            Text(pro.product_title),
            (product.Images.length>0)?
                Image(image: NetworkImage(product.Images[0]),)
                :Container(),
          ],
        )
            */
      ),
    );
  }

  _drawCard(dynamic item) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Row(
          children: <Widget>[
            Text(item.category_name),
            Flexible(
                child: Image(
              fit: BoxFit.contain,
              image: NetworkImage(item.image_url),
            ))
          ],
        ),

        /// code of image
        /*
        child: Column(
          children: <Widget>[
            Text(pro.product_title),
            (product.Images.length>0)?
                Image(image: NetworkImage(product.Images[0]),)
                :Container(),
          ],
        )
            */
      ),
    );
  }

  _drawLeftCard(dynamic item) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Row(
          children: <Widget>[
            Flexible(
                child: Image(
              fit: BoxFit.contain,
              image: NetworkImage(item.image_url),
            )),
            Text(item.category_name),
          ],
        ),

        /// code of image
        /*
        child: Column(
          children: <Widget>[
            Text(pro.product_title),
            (product.Images.length>0)?
                Image(image: NetworkImage(product.Images[0]),)
                :Container(),
          ],
        )
            */
      ),
    );
  }

  _drawRightCard(dynamic item) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Row(
          children: <Widget>[
            Text(item.category_name),
            Flexible(
                child: Image(
              fit: BoxFit.contain,
              image: NetworkImage(item.image_url),
            ))
          ],
        ),

        /// code of image
        /*
        child: Column(
          children: <Widget>[
            Text(pro.product_title),
            (product.Images.length>0)?
                Image(image: NetworkImage(product.Images[0]),)
                :Container(),
          ],
        )
            */
      ),
    );
  }

  drawproductTags(ProductCategory productcategory) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Text(productcategory.category_name),

        /// code of image
        /*
        child: Column(
          children: <Widget>[
            Text(pro.product_title),
            (product.Images.length>0)?
                Image(image: NetworkImage(product.Images[0]),)
                :Container(),
          ],
        )
            */
      ),
    );
  }
}
