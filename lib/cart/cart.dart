import 'package:generalshop/product/proudct.dart';

class CartItem{


  product products ;
  double qty;
  CartItem(this.products,this.qty);
  CartItem.fromjson(Map<String,dynamic>jsonObject){
    this.products=jsonObject['product'];
    this.products=product.fromjson(jsonObject['product']);
    
    this.qty=jsonObject['qty'];
  }
}
class Cart{
  int id;
  double total;
  List<CartItem> cartItem;
  Cart(this.id,this.cartItem,this.total);

  Cart.fromjson(Map<String,dynamic>jsonObject){
   cartItem=[];
    var items=jsonObject['cart_items'];
    for(var item in items){
      cartItem.add(CartItem.fromjson(jsonObject['item']));
      this.total=jsonObject['total'];
      this.id=jsonObject['id'];


    }

  }
}