import 'package:generalshop/api/api_util.dart';
import 'package:generalshop/execptions/execptions.dart';
import 'package:generalshop/product/product_category.dart';
import 'package:generalshop/product/product_tag.dart';
import 'package:generalshop/uitilty/country.dart';
import 'package:generalshop/uitilty/country_city.dart';
import 'package:generalshop/uitilty/country_state.dart';
import 'dart:convert';
import 'package:http/http.dart'as http;

class HelperApi{
  //Map<String,String>headers={'Accept':'application/json'};
  Map<String, String> headers = {'accept': 'application/json',};
  /////////////
  Future<List<ProductCategory>>FetchCategories()async{
  //  print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    String URL=ApiUtl.CATEGORIES;
   print('URL${URL}');
 //   print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');

    List<ProductCategory>proudcTCategory=[];
  //  print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa33');

  //  htttp.Response response= await htttp.get(URL,headers: headers);
    http.Response response = await http.get(URL, headers: headers);
   // print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa44');
    print(response.statusCode);

    switch (response.statusCode){

      case 200:
        var body=jsonDecode(response.body);

        for(var item in body['data']){
      //   print(body['data']);

      //   print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');

          proudcTCategory.add(ProductCategory.fromjson(item));
        }
        return proudcTCategory;
        break;
      case 404:
        throw ResourceNotFound('categories');
        break;

      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:

        return null;
        break;
    }

/*
    if(response.statusCode==200){
      var body=jsonDecode(response.body);
      for(var item in body['data']){
        print(body['data']);
        proudcTCategory.add(ProductCategory.fromjson(item));
      }
      return proudcTCategory;
    }
    return null;
*/
  }
  ////////////

  Future<List<ProductTag>>  FetchTages(int page)async{
    String URL=ApiUtl.TAGS+'?page='+page.toString();
    List<ProductTag>tags=[];
    http.Response response= await http.get(URL,headers: headers);
    switch (response.statusCode){
      case 200:
      var body=jsonDecode(response.body);
      for(var item in body['data']){
        print(body['data']);
        tags.add(ProductTag.fromjson(item));
      }
      return tags;
      break;
      case 404:
        throw ResourceNotFound('tages');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      default:
        return null;
        break;
    }


  }

  ///////////////////
  Future<List<Country>>FetchCountries(int page)async{
    String URL=ApiUtl.COUNTRIES+'?page='+page.toString();
  }

  Future<List<CountryState>> FetchStates(Country country,int page)async{
  //  String URL=ApiUtl.STATES(country.country_id)+'?page='+page.toString();

  }

  Future<List<CountryCity>>FetchCities(Country country,int page)async{
    //String URL=ApiUtl.CITIES(country.country_id)+'?page='+page.toString();
  }


}