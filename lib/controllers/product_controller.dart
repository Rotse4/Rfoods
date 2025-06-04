import 'package:get/get.dart';
import '../models/Product.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs; // Reactive list of products

  @override
  void onInit() {
    super.onInit();
    products.assignAll(demoProducts); // Initialize with demo products
  }

  void toggleFavorite(int productId) {
    final index = products.indexWhere((product) => product.id == productId);
    if (index != -1) {
      products[index] = Product(
        id: products[index].id,
        images: products[index].images,
        colors: products[index].colors,
        title: products[index].title,
        price: products[index].price,
        description: products[index].description,
        rating: products[index].rating,
        isFavourite: !products[index].isFavourite, // Toggle favorite
        isPopular: products[index].isPopular,
      );
      products.refresh(); // Update UI
    }
  }
}
