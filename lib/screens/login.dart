
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generalshop/api/authentication.dart';
import 'package:generalshop/customer/user.dart';
import 'package:generalshop/screens/home_page.dart';
import 'package:generalshop/screens/screen_utitlities/screent_utitlity.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passController=TextEditingController();
  var _formKey=GlobalKey<FormState>();
  bool _loading=false;
  Authentication authentication=Authentication();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 16),
        child: Transform.translate(
          offset: Offset(0,-40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Sign In',style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 16,),
                  Text('Login To Continue Your Account',style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 18,color: ScreenUtitilities.darkerGrayText)),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 24,bottom: 24),
                  child: Loginform()),

              Container(
                margin: EdgeInsets.only(top: 18,bottom: 18),
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  color: ScreenUtitilities.mainBlue,
                  onPressed: (_loading)?null:loginser,

                  child:(_loading)?Center(child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                  ): Text('Login',style: Theme.of(context).textTheme.subhead.copyWith(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold
                  ),)),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Dont not have account?',style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 18,color: ScreenUtitilities.darkerGrayText)),
                  FlatButton(
                    child: Text('Sign Up',style: Theme.of(context).textTheme.title.copyWith(fontSize: 18,fontWeight: FontWeight.bold)),
                    onPressed: (){

                    },
                  )
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget Loginform() {

    return Form(

      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              hintText:'Email',
            hintStyle: TextStyle(fontSize: 24),
            labelStyle: TextStyle(fontSize: 24)),
            style: TextStyle(fontSize: 24),
            validator: (value){
              if(value.isEmpty){
                return 'Email is requierd';              }
              return null;
            }

          ),
          SizedBox(height: 16,),
          TextFormField(

            controller: _passController,
            obscureText: true,
            decoration: InputDecoration(
                hintText:'PassWord',
                hintStyle: TextStyle(fontSize: 24),
                labelStyle: TextStyle(fontSize: 24)

            ),
            style: TextStyle(fontSize: 24),
              validator: (value){
                if(value.isEmpty){
                  return 'PassWord is requierd';              }
                return null;
              }

          )
        ],
      ),
    );
  }

  void loginser() async{

    if(_formKey.currentState.validate()){
      setState(() {
        _loading=true;
      });


      String _email=_emailController.text;
      String _password=_passController.text;
      User user=   await authentication.login(_email, _password);
      if(user.user_id!=null){
        setState(() {
          _loading=false;
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }
      else{
        setState(() {
          _loading=false;
        });
      }

    }




  }
}
