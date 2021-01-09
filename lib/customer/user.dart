import 'package:generalshop/execptions/execptions.dart';

class User{
  String first_name,last_name,email,api_token;
  int user_id;
  User(this.first_name, this.last_name, this.email,[this.api_token,this.user_id]);
  User.fromJason(Map <String,dynamic>jsonObject){
    assert( jsonObject['user_id'] !=null,'User Id Is Null');
    assert( jsonObject['first_name'] !=null,'First Name  Is Null');
    assert( jsonObject['last_name'] !=null,'Last Name  Is Null');
    assert( jsonObject['email'] !=null,' Email Is Null');
    assert( jsonObject['api_token'] !=null,' Api Token Is Null');
    if (jsonObject['user_id']==null){
      throw PropertyIsRequiered('User Id');
    }
    if (jsonObject['first_name']==null){
      throw PropertyIsRequiered('First Name');
    }
    if (jsonObject['last_name']==null){
      throw PropertyIsRequiered('Last Name');
    }

    if (jsonObject['email']==null){
      throw PropertyIsRequiered('Email');
    }
    if (jsonObject['api_token']==null){
      throw PropertyIsRequiered('Api Token');
    }
      this.user_id=jsonObject['user_id'];
      this.first_name=jsonObject['first_name'];
      this.last_name=jsonObject['last_name'];
      this.email=jsonObject['email'];
      this.api_token=jsonObject['api_token'];

  }
}