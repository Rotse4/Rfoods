import 'package:get/get.dart';
import '../models/rating.dart';

class RatingController extends GetxController {
  final RxList<Rating> _ratings = <Rating>[].obs;
  
  List<Rating> get ratings => _ratings;
  
  // Get ratings for a specific product
  List<Rating> getRatingsForProduct(int productId) {
    return _ratings.where((rating) => rating.productId == productId.toString()).toList();
  }
  
  // Get average rating for a product
  double getAverageRating(int productId) {
    final productRatings = getRatingsForProduct(productId);
    if (productRatings.isEmpty) return 0.0;
    
    double total = productRatings.fold(0.0, (sum, rating) => sum + rating.rating);
    return total / productRatings.length;
  }
  
  // Get total rating count for a product
  int getRatingCount(int productId) {
    return getRatingsForProduct(productId).length;
  }
  
  // Add a new rating
  void addRating(Rating rating) {
    _ratings.add(rating);
    update();
  }
  
  // Initialize with some dummy data
  @override
  void onInit() {
    super.onInit();
    _initializeDummyRatings();
  }
  
  void _initializeDummyRatings() {
    // Add some dummy ratings for demonstration
    _ratings.addAll([
      Rating(
        id: '1',
        productId: '1',
        userName: 'John Doe',
        userAvator: 'assets/images/user1.png',
        rating: 5.0,
        comment: 'Excellent product! Great quality and fast delivery.',
        createdAt: DateTime.now().subtract(const Duration(days: 2)).toString(),
      ),
      Rating(
        id: '2',
        productId: '1',
        userName: 'Sarah Wilson',
        userAvator: 'assets/images/user2.png',
        rating: 4.0,
        comment: 'Good product but could be better packaged.',
        createdAt: DateTime.now().subtract(const Duration(days: 5)).toString(),
      ),
      Rating(
        id: '3',
        productId: '1',
        userName: 'Mike Johnson',
        userAvator: 'assets/images/user3.png',
        rating: 5.0,
        comment: 'Amazing! Exactly as described. Highly recommended.',
        createdAt: DateTime.now().subtract(const Duration(days: 7)).toString(),
      ),
    ]);
  }
}