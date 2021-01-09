import 'package:generalshop/execptions/execptions.dart';
import 'package:generalshop/review/reviewers.dart';

class ProductReviews{

  int review_id,stars;

  ProductReviews(this.review_id, this.stars, this.review, this.reviewers);

  String review;
  Reviewers reviewers;

  ProductReviews.fromjson(Map<String,dynamic>jsonObject){

    assert( jsonObject['review_id'] !=null,'Review Id Is Null');
    assert( jsonObject['stars'] !=null,'Stars Is Null');
    assert( jsonObject['review'] !=null,'Review Is Null');
    assert( jsonObject['reviewers'] !=null,'Reviewers Is Null');
    if (jsonObject['review_id']==null){
      throw PropertyIsRequiered('Review Id');
    }
    if (jsonObject['stars']==null){
      throw PropertyIsRequiered('Stars');
    }
    if (jsonObject['review']==null){
      throw PropertyIsRequiered('Review');
    }

    if (jsonObject['reviewers']==null){
      throw PropertyIsRequiered('Reviewers');
    }
    this.review_id=jsonObject['review_id'];
    this.stars=jsonObject['stars'];
    this.review=jsonObject['review'];

    this.reviewers=Reviewers.fromjson(jsonObject['reviewers']);


  }



}