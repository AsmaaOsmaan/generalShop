import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:generalshop/customer/user.dart';
import 'package:generalshop/execptions/execptions.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'api_util.dart';
import 'dart:convert';

class Authentication {
  Future<User> register(String first_name, String last_name, String email,
      String password) async {
    Map<String, String> headers = {'Accept': 'Application/json'};

    Map<String, String> body = {
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password
    };
    print('befor');
    http.Response response =
        await http.post(ApiUtl.Auth_Register, headers: headers, body: body);
    print('okkk');
    switch (response.statusCode) {
      case 201:
        var body = jsonDecode(response.body);
        var data = body['data'];
        print(data);
        return User.fromJason(data);
        break;
      case 402:
        throw UnProccedEntity();
        break;
      default:
        return null;
        break;
    }
  }

  Future<User> login(String email, String password) async {
    // String url = 'http://shop.com/api/auth/login';
    String url = 'http://10.0.2.2:8000/api/' + 'auth/login';

    Map<String, String> headers = {'Accept': 'Application/json'};

    Map<String, String> body = {'email': email, 'password': password};

    http.Response response = await http.post(url, headers: headers, body: body);
    print('after');
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var body = jsonDecode(response.body);
        var data = body['data'];

        print(data);
        User user=User.fromJason(data);
        saveUser(user.user_id,user.api_token);
        print('Token : ${user.api_token}');
        print(response);
        print("apic_token${user.api_token}");
        return user;

        break;
      case 404:
        throw ResourceNotFound('user');
        break;
      case 301:
      case 302:
      case 303:
        throw RedirectionFound();
        break;
      case 401:
        throw LoginFaild();
        break;
      default:
        return null;
        break;
    }
  }


  Future<void>saveUser(int userID,String apiToken)async{
    SharedPreferences preferences=   await SharedPreferences.getInstance();

    preferences.setInt('user_id', userID);
    preferences.setString('api_token', apiToken);


  }
}
