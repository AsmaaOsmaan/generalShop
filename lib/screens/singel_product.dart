import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalshop/product/proudct.dart';
import 'package:generalshop/screens/login.dart';
import 'package:generalshop/screens/screen_utitlities/screent_utitlity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:generalshop/api/cart_api.dart';

class SingelProduct extends StatefulWidget {
  final product produc;

  SingelProduct( this.produc) ;
  @override
  _SingelProductState createState() => _SingelProductState();
}

class _SingelProductState extends State<SingelProduct> {
  CartApi cartApi=CartApi();
  bool _addToCart=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       title: Text(widget.produc.product_title),
      //  title: Text('product'),

      ),
      body: drawScreen(context),
      floatingActionButton: FloatingActionButton(onPressed: ()async{

        SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
        int user_id=sharedPreferences.getInt('user_id');
        if(user_id==null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        }
   //print(user_id);
else{
  setState(() {

    _addToCart=true;
  });
          await  cartApi.addProductToCart(widget.produc.product_id);
          print('mansourrrrrrrrrrrrr');
          setState(() {

            _addToCart=false;
          });
        }



      },
      child: Icon(Icons.add_shopping_cart),),
    );
  }

  Widget drawScreen(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height*0.45,
           child: drawImageGaliry(context),
          ),
          drawTitel(context),
          drawDetails(context),

        ],
      ),
    );
  }

  Widget drawImageGaliry(BuildContext context) {

return PageView.builder(
  itemCount: widget.produc.Images.length,
  itemBuilder: (context,int postion){
    return Container(
      padding: EdgeInsets.all(8),
      child:  Image(image: NetworkImage(widget.produc.Images[postion]),),
    );

  },
);
  }

  drawTitel(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16,top: 16,right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.produc.product_title,style: Theme.of(context).textTheme.headline.copyWith(

                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: ScreenUtitilities.textColor
                ),),
                SizedBox(height: 16,),
                Text(widget.produc.productCategory.category_name.toString(),style: Theme.of(context).textTheme.display1.copyWith(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: ScreenUtitilities.darkerGrayText

                ))
              ],
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(widget.produc.product_price.toString(),style: Theme.of(context).textTheme.headline.copyWith(
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: ScreenUtitilities.textColor
                )),
                (widget.produc.product_discount>0)?Text(_calculatDiscount(),style: Theme.of(context).textTheme.subhead):Container(),
              ],
            ) ,
          )

        ],
      ),
    );
  }
  drawDetails(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        widget.produc.product_description,style: Theme.of(context).textTheme.display2.copyWith(

          fontFamily: "Quicksand",
          fontWeight: FontWeight.w700,
          fontSize: 18,
          height: 1.75,
          letterSpacing: 1.5,
          color: ScreenUtitilities.darkerGrayText

      ),
      ),
    );
  }

  String _calculatDiscount() {
    double price=widget.produc.product_price;
    double discount=widget.produc.product_discount;
    return (price*discount).toString();
  }
}
