import 'package:generalshop/execptions/execptions.dart';

class ProductCategory{
  int category_id;
  String category_name;
  String image_direction;
  String image_url;
  ProductCategory(this.category_id, this.category_name,this.image_direction,this.image_url);
  ProductCategory.fromjson(Map<String,dynamic>jsonObject){
    assert(jsonObject['category_id']!=null,'Category Id Is Null');
    assert(jsonObject['category_name']!=null,'Category Name Is Null');
    assert(jsonObject['image_direction']!=null,'Image Direction Is Null');
    assert(jsonObject['image_url']!=null,'Image URL Is Null');
    if (jsonObject['category_id']==null){
      throw PropertyIsRequiered('Category Id');
    }
    if (jsonObject['category_name']==null){
      throw PropertyIsRequiered('Category Name');
    }
    if (jsonObject['image_direction']==null){
      throw PropertyIsRequiered('Image Direction');
    }
    if (jsonObject['image_url']==null){
      throw PropertyIsRequiered('Image URL');
    }
    this.category_id=jsonObject['category_id'];
    this.category_name=jsonObject['category_name'];
    this.image_direction=jsonObject['image_direction'];
    this.image_url=jsonObject['image_url'];
}



}