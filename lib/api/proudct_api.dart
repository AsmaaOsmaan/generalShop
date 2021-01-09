import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:generalshop/execptions/execptions.dart';
import 'package:generalshop/main.dart';
 import 'package:http/http.dart'as htttp;
import 'api_util.dart';
import'package:generalshop/product/proudct.dart';
 class ApiProduct{

   Map<String,String>headers={
     'Accept':'application/json'
   };
   Future<List<product>>fetchProducts(int page)async{

 List<product>proudcts=[];
     String URL=ApiUtl.PRODUCTS+'?page='+page.toString();
     htttp.Response response= await htttp.get(URL,headers: headers);
     if(response.statusCode==200){
       var body=jsonDecode(response.body);
       for(var item in body['data']){
  //  print(body['data']);
         proudcts.add(product.fromjson(item));
       }

       return proudcts;
     }
     return null;

   }
////////////////
   Future<product>fetchProduct(int product_id)async{

     String URL=ApiUtl.PRODUCT+'/'+product_id.toString();
     htttp.Response response= await htttp.get(URL,headers: headers);

     if(response.statusCode==200){

       var body=jsonDecode(response.body);
      // print(body['data']);

       return product.fromjson(body['data']);
     }
    
     return null;

   }

///////////////
 //fetchProductByCategories
   Future<List<product>>fetchProductsByCategory(int category,int page)async{

     List<product>proudcts=[];
     String URL=ApiUtl.CATEGORY_PRODUCT(category, page)+'?page='+page.toString();
     htttp.Response response= await htttp.get(URL,headers: headers);
    switch(response.statusCode){
      case 404:
       // print('asmaaaaa');
        print (response.statusCode);
        throw ResourceNotFound('proudcts');
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
      case 200:
       // print('asmaacategory by id ');
        var body=jsonDecode(response.body);
        for(var item in body['data']){
      //   print(body['data']);
          proudcts.add(product.fromjson(item));
        }

        return proudcts;
      default:
        return null;
      }


   }

 }