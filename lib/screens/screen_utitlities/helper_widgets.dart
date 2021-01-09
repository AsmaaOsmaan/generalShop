import 'package:flutter/material.dart';
class HelperWidgets{
   Widget error(String error){
    return Container(
      child: Center(
        child: Text(error,style: TextStyle(color: Colors.red),),
      ),
    );
  }


 Widget  loading(){
    return Container(
      color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        )
    );
  }
}