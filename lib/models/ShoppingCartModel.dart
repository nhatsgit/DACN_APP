import 'package:ecommerce_app/models/ProductModel.dart';
import 'package:ecommerce_app/models/ShopModel.dart';
import 'package:ecommerce_app/utils/MyCaculator.dart';

class ShoppingCartModel {
  final int shoppingCartId;
  final int shopId;
  final List<CartItemModel> cartItems;
  final ShopModel shop;

  ShoppingCartModel({
    required this.shoppingCartId,
    required this.shopId,
    required this.cartItems,
    required this.shop,
  });

  factory ShoppingCartModel.fromJson(Map<String, dynamic> json) {
    return ShoppingCartModel(
      shoppingCartId: json['shoppingCartId'],
      shopId: json['shopId'],
      cartItems: (json['cartItems'] as List)
          .map((item) => CartItemModel.fromJson(item))
          .toList(),
      shop: ShopModel.fromJson(json['shop']),
    );
  }
  double getTotalPrice() {
    return cartItems.fold(
      0,
      (total, cartItem) =>
          total +
          (MyCaculator.calculateDiscountedPrice(cartItem.product.giaBan,
                  cartItem.product.phanTramGiam.toDouble()) *
              cartItem.quantity),
    );
  }
}

class CartItemModel {
  final int cartItemId;
  final int quantity;
  final ProductModel product;

  CartItemModel({
    required this.cartItemId,
    required this.quantity,
    required this.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      cartItemId: json['cartItemId'],
      quantity: json['quantity'],
      product: ProductModel.fromJson(json['product']),
    );
  }
}
