
class ApiUtl {
 //static const String MAIN_API_URL = "http://127.0.0.1:8000//api/";
static const String MAIN_API_URL = "http://10.0.2.2:8000/api/";
  static const String Auth_Register = MAIN_API_URL + 'auth/register';
  static const String Auth_Login = MAIN_API_URL + 'auth/login';
  static const String PRODUCTS = MAIN_API_URL + 'products';
static const String CART =  ApiUtl.MAIN_API_URL + 'carts';
  static const String PRODUCT = MAIN_API_URL + 'products';
  static const String COUNTRIES = MAIN_API_URL + 'countries';
  static const String CATEGORIES = MAIN_API_URL + 'categories';
//static const String CATEGORIES = "http://www.metaweather.com/api/location/search/?query=london";
//https://www.metaweather.com/api/location/search/?query=london

  static  String CATEGORY_PRODUCT(int id,int page){
    return MAIN_API_URL + 'categories/'+id .toString()+'/products?page'+page.toString();
  }
  static const String TAGS = MAIN_API_URL + 'tags';

  static String CITIES(int id) {
    return MAIN_API_URL + COUNTRIES + '/' + id.toString() + '/cities';
  }

  static String STATES(int id) {
    return MAIN_API_URL + COUNTRIES + '/' + id.toString() + '/states';
  }
}