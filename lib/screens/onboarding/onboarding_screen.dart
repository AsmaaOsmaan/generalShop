import 'package:flutter/material.dart';
import 'package:generalshop/screens/onboarding/onboarding_model.dart';

class SingleOnBoarding extends StatelessWidget {
 final  OnBoardingModel onBoardingModel;
 SingleOnBoarding(this.onBoardingModel);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height*0.3,
          width: MediaQuery.of(context).size.width*0.95,
          child: Image(image: ExactAssetImage(onBoardingModel.Image),
          fit: BoxFit.cover,),
        ),
        SizedBox(height: 20,),
        Text(onBoardingModel.Title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.only(left: 22,right: 22),
          child: Text(onBoardingModel.Description,textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.blueGrey,height: 1.5),),
        ),

      ],
    );
  }

  
}
