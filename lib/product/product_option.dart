class ProductOptions{
  String optionName;
  List<String>options;
  ProductOptions(this.optionName, this.options);

///////////  to edit
  ProductOptions.fromjson(Map<String,dynamic>jsonObject){
    this.optionName=jsonObject['optionName'];
    this.options=jsonObject['options'];





  }


}