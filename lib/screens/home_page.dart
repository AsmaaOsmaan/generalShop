import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalshop/product/home_product_bloc.dart';
import 'package:generalshop/product/product_category.dart';
import 'package:generalshop/product/proudct.dart';
import 'package:generalshop/screens/screen_utitlities/screent_utitlity.dart';
import 'package:generalshop/api/helper_api.dart';
import 'package:generalshop/screens/screen_utitlities/helper_widgets.dart';
import 'package:generalshop/screens/singel_product.dart';

import 'cart_screen.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  TabController tabController;
  PageController _pageController;
  HelperApi helperapi=HelperApi();
  HomeProductBloc homeProductBloc=HomeProductBloc();
  HelperWidgets helperWidgets=HelperWidgets();
  int currentIndex=0;
  int dotsCurrentIndex=1;
  List <ProductCategory>productCategories;
  ValueNotifier<int>dotsIndex=ValueNotifier(1);
  @override
  Widget build(BuildContext context) {
    @override
    void initState(){
      super.initState();
      //homeProductBloc=HomeProductBloc();
      _pageController=PageController(
        initialPage: 1,
        viewportFraction: 0.75,
      );
    }

    @override
    void dispose(){
      super.dispose();
      tabController.dispose();

    }

    return  Scaffold(
     // appBar: AppBar(title: Text('Products'),),
    body: Container(
        child: FutureBuilder(
          future:helperapi.FetchCategories(),

          builder: ( BuildContext context,  AsyncSnapshot<List<ProductCategory>> snapShot){
          //  print('snapshot ${snapShot}');
            switch(snapShot.connectionState )
            {
              case ConnectionState.none:
                helperWidgets.error('no thing happend!!!');
                break;
              case ConnectionState.waiting:
                helperWidgets. loading();
                break;
              case ConnectionState.active:
                helperWidgets. loading();
                break;
              case ConnectionState.done:
                if (snapShot.hasError){
                  return  helperWidgets.error(snapShot.error.toString());
                }
                else{
                  if (!snapShot.hasData){
                    return helperWidgets.error('no data foundddd');
                  }
                  else{
                 this.productCategories  = snapShot.data;
                 homeProductBloc.fetchProduct.add(this.productCategories[0].category_id);

                 return _Screen(snapShot.data);
                  }
                }
                break;
            }
            return Center();
          },
        ),
      ),
    );
  }


  Widget _Screen(List<ProductCategory>categories){
    tabController =TabController(
      initialIndex: 0,
      length: categories.length,
      vsync:  this,
    );
    return   Scaffold(

      appBar: AppBar(

        centerTitle: true,
        title: Text('Home ',),
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(icon: Icon(Icons.search), onPressed: (){}),
          )
        ],
        bottom: TabBar(
          indicatorColor: ScreenUtitilities.mainBlue,
          indicatorWeight: 3,
          controller: tabController,
          isScrollable: true,
          tabs:_tabs(categories),
          onTap: (int index){
            homeProductBloc.fetchProduct.add(this.productCategories[index].category_id);
    }
        ),
      ),
      drawer: Drawer(
        child:ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(child: Text("Home"),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            ),
            ListTile(
              title: Text("Cart"),
              leading: Icon(Icons.card_travel),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));
              },
            )
          ],
        ) ,
      ) ,
      body: Container(
child: StreamBuilder(
  stream:homeProductBloc.productsStream
   , builder: (BuildContext context,AsyncSnapshot <List<product>>snapshot){
    switch(snapshot.connectionState){
      case ConnectionState.none:
        helperWidgets.error('no thing happend!!!');
        break;
      case ConnectionState.waiting:

      helperWidgets. loading();
        break;
      case ConnectionState.done:
      case ConnectionState.active:
        if(snapshot.hasError){
          return  helperWidgets.error(snapshot.error.toString());
        }
        else{
          if(!snapshot.hasData){
            return  helperWidgets.error('No data returned!!!');
          }


          else{

         return   _drawProducts(snapshot.data,context);
          }
        }
        break;}
        return Container();
}),
      ),
    );
  }

  List<product>_randomTopProuct(List<product> products){
    List<int>indexes=[];
    List<product> newProduct=[];
    Random random=Random();
    int counter=5;
    do{
      int rnd=random.nextInt(products.length);
      if(!indexes.contains(rnd)){
        indexes.add(rnd);
        counter--;
      }
    }
    while(counter!=0);
    for(int index in indexes){
      newProduct.add(products[index]);
    }
   return newProduct;
  }
  Widget _drawProducts(List<product>products,BuildContext context){
    List<product>topProucts=_randomTopProuct( products);
    return Container(
     // height: 300,
    // width: 300,
      padding: EdgeInsets.only(top: 25),
      child: Column(
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height*0.25,
              child: PageView.builder(

                onPageChanged: (int index){
                 dotsIndex.value=index;
                },
                controller: _pageController,
             scrollDirection: Axis.horizontal,
                  itemCount: topProucts.length
                  ,itemBuilder: (context,postion){
                return

                   InkWell(
                     onTap: (){
                       goToSingelProduct(topProucts[postion], context);
                     },
                     child: Card(
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                       clipBehavior: Clip.hardEdge,
                       margin: EdgeInsets.only(left: 3,right: 3),
                      child: Container(
                        child: Image(

                          loadingBuilder: (context,image,ImageChunkEvent loadigProgress){
                            if(loadigProgress==null){
                              return image;
                            }
                            return Center(child:  CircularProgressIndicator(),);
                          },
                          fit: BoxFit.cover,
                          image: NetworkImage(topProucts[postion].featuredImage()),
                        ),
                      ),
                  ),
                   );
                 ;
              }),
            ),

          Container(
            child:Row(
       //   children:
        //  _drawdots(topProucts.length,context),

          )

          ),
          ValueListenableBuilder(
            valueListenable: dotsIndex,
            builder: (context,value,_){
              return Container(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _drawdots(topProucts.length,context),
                ),
              );
          },
          ),

          Flexible(
            child: Container(
              
              child: Padding(padding:EdgeInsets.only(top: 24,left: 8,right: 8) ,
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing:18 ,
                    childAspectRatio: 0.5,
                  ),

                    itemBuilder:(context,position){
                      return  InkWell(
                        onTap: (){
                        goToSingelProduct(products[position], context);
                        },
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                                height: 150,
                                child: Image(
                                    loadingBuilder: (context,image,ImageChunkEvent loadigProgress){
                                      if(loadigProgress==null){
                                        return image;
                                      }
                                      return Center(child:  CircularProgressIndicator(),);
                                    },


                                    image: NetworkImage(products[position].featuredImage()))),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(products[position].product_title,textAlign: TextAlign.center),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(products[position].product_price.toString(),textAlign: TextAlign.center,),
                            ),
                          ],
                        ),
                      );

                    }
                ),
              ),),
          ),
        ],
      ),
    );
  }
  List<Widget>_drawdots(int que,BuildContext context){
    List<Widget>widget=[];
    for (int i=0;i<que;i++)
      widget.add(Container(
        decoration: BoxDecoration(borderRadius:BorderRadiusDirectional.circular(5),
          color: (i==dotsCurrentIndex)?ScreenUtitilities.mainBlue:ScreenUtitilities.lightGray,),
        width: 10,
        height: 10,
        margin:(i==que-1)? EdgeInsets.only(right: 0): EdgeInsets.only(right: 20),
      ),) ;
    return widget;
  }
 List<Tab> _tabs(List<ProductCategory>categorise){
    List<Tab> tabs=[];
for(ProductCategory category in categorise){
  tabs.add(Tab(
    text: category.category_name,
  ),);

}
    return tabs;
  }


  void goToSingelProduct(product pro,BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return SingelProduct(pro);
    }));

  }
}
