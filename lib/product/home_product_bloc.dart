import 'dart:async';
import 'package:generalshop/api/proudct_api.dart';
import 'package:generalshop/contracts/contract.dart';
import 'package:generalshop/product/proudct.dart';
class HomeProductBloc implements Disposable{
  List<product>products;
  ApiProduct productApi;
   final StreamController <List<product>>_productController=StreamController<List<product>>.broadcast();
   final  StreamController <int>_categoryController=StreamController<int>.broadcast();
    Stream <List<product>> get productsStream=>_productController.stream;
    StreamSink <int> get fetchProduct=>_categoryController.sink;
  Stream <int> get category=>_categoryController.stream;
  @override
  void dispose() {
    _productController.close();
    _categoryController.close();

  }
int categoryID;
    HomeProductBloc(){
      productApi=ApiProduct();
      this.products=[];
      _productController.add(products);
      _categoryController.add( this.categoryID);
      _categoryController.stream.listen(fetchCategoriesFromAPI);
    }
 Future<void> fetchCategoriesFromAPI(int category)async{
 this.products= await productApi.fetchProductsByCategory(category, 2);
 _productController.add(this.products);
    }
}