import 'package:generalshop/execptions/execptions.dart';

class ProductTag{
int tag_id;
String tag_name;
ProductTag(this.tag_id, this.tag_name);

ProductTag.fromjson(Map<String,dynamic>jsonObject){
  assert(jsonObject['tag_id']!=null,'tag Id Is Null');
  assert(jsonObject['tag_name']!=null,'tag Name Is Null');
  if (jsonObject['tag_id']==null){
    throw PropertyIsRequiered('Tag Id');
  }

  if (jsonObject['tag_name']==null){
    throw PropertyIsRequiered('Tag Name');
  }
  this.tag_id=jsonObject['tag_id'];
  this.tag_name=jsonObject['tag_name'];

}

}