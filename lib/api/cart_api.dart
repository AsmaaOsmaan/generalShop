import 'dart:convert';

import 'package:generalshop/cart/cart.dart';
import 'package:generalshop/execptions/execptions.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_util.dart';
 class CartApi{

   Map<String,String>headers={
     'Accept':'application/json',

   };


   Future<Cart> fetchCart()async{
     String ApiCart=ApiUtl.CART;
     http.Response response= await http.get(ApiCart,headers: headers);
     switch(response.statusCode){
       case 404:
         print('asmaaaaa');
         print (response.statusCode);
         throw ResourceNotFound('Cart');
       case 301:
       case 302:
       case 303:
         throw RedirectionFound();
       case 200:

         var body=jsonDecode(response.body);
       

         return Cart.fromjson(body);
       default:
         return null;
     }
 }
 Future<bool>addProductToCart(int ProductID)async{
     SharedPreferences sharedPreferences= await SharedPreferences.getInstance();
   String  apiToken= sharedPreferences.get('api_token');
   print('mansor${apiToken}');
   Map<String,String>authheaders={
     'Accept':'application/json',
     'Authorization': 'Bearer ${apiToken}'
   };

   String ApiCart=ApiUtl.CART;
   Map<String,dynamic>body={
     'product_id':ProductID.toString(),
     'qty':1.toString(),
   };
   http.Response response= await http.post(ApiCart,headers: authheaders,body: body);
print("response.statusCode ${response.statusCode}");
   switch(response.statusCode){


     case 200:
     case 201:

       return true;
       break;
     default:
       throw ResourceNotFound('Cart');
   }
 }



 }