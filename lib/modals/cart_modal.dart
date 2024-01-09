import 'package:food_delivery_app/modals/products_modal.dart';

class CartModal {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModal? product;

  CartModal(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.quantity,
      this.isExist,
      this.time,
      this.product});

  CartModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    product = ProductModal.fromJson(json['product']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "img": img,
      "quantity": quantity,
      "isExist": isExist,
      "time": time,
      "product":product!.toJson()
    };
  }
}
