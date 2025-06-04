import 'package:get/get.dart';
import '../models/Product.dart';

class CartController extends GetxController {
  var cartItems = <Product, int>{}.obs; // Map of Product to quantity

  void addToCart(Product product, {int quantity = 1}) {
    if (cartItems.containsKey(product)) {
      cartItems[product] = cartItems[product]! + quantity;
    } else {
      cartItems[product] = quantity;
    }
    cartItems.refresh();
  }

  void removeFromCart(Product product) {
    cartItems.remove(product);
    cartItems.refresh();
  }

  int getItemCount() {
    return cartItems.values.fold(0, (sum, qty) => sum + qty);
  }

  double getTotalPrice() {
    return cartItems.entries.fold(
      0.0,
      (sum, entry) => sum + entry.key.price * entry.value,
    );
  }
}
