import 'Product.dart';

class Items {
  Items({
      this.id, 
      this.cart, 
      this.product, 
      this.quantity, 
      this.subTotal,});

  Items.fromJson(dynamic json) {
    id = json['id'];
    cart = json['cart'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    subTotal = json['sub_total'];
  }
  int id;
  int cart;
  Product product;
  int quantity;
  double subTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['cart'] = cart;
    if (product != null) {
      map['product'] = product.toJson();
    }
    map['quantity'] = quantity;
    map['sub_total'] = subTotal;
    return map;
  }

}