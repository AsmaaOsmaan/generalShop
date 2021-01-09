import 'package:generalshop/execptions/execptions.dart';

class Reviewers{
  String first_name,last_name,formatted_name,email;

  Reviewers(this.first_name, this.last_name, this.formatted_name, this.email);
  Reviewers.fromjson(Map<String,dynamic>jsonObject){
    assert( jsonObject['first_name'] !=null,'First Name Is Null');
    assert( jsonObject['last_name'] !=null,'Last Name Is Null');
    assert( jsonObject['formatted_name'] !=null,'Formatted Name Is Null');
    assert( jsonObject['email'] !=null,'Email Is Null');

    if (jsonObject['first_name']==null){
      throw PropertyIsRequiered('First Name');
    }

    if (jsonObject['last_name']==null){
      throw PropertyIsRequiered('Last Name');
    }
    if (jsonObject['formatted_name']==null){
      throw PropertyIsRequiered('Formatted Name');
    }
    if (jsonObject['email']==null){
      throw PropertyIsRequiered('Email');
    }

    this.first_name=jsonObject['first_name'];
    this.last_name=jsonObject['last_name'];
    this.formatted_name=jsonObject['formatted_name'];
    this.email=jsonObject['email'];


  }
}