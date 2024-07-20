
import 'package:get/get.dart';

class CartModel {
  final String id;
  final String image;
  final String name;
  final String price;
  final RxInt count;

  CartModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.count,
  });

  double get totalPrice => double.parse(price) * count.value;
  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'],
      image: map['image'],
      name: map['name'],
      price: map['price'],
      count: map['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'price': price,
      'count': count,
    };
  }

  // Override equality operator for proper comparison in lists
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

