import 'package:get/get.dart';
import 'package:quick_foodies/Models/product_model.dart';
import 'package:get_storage/get_storage.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();
  final box = GetStorage();
  final favouritList = <ProductModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavouriteProducts();
  }

  void toggleFavorite(ProductModel product) {
    if (favouritList.contains(product)) {
      favouritList.remove(product);
    } else {
      favouritList.add(product);
    }
    saveFavouriteProducts();
  }

  void saveFavouriteProducts() {
    List<Map<String, dynamic>> favList = favouritList.map((product) => product.toJson()).toList();
    box.write('favourites', favList);
  }

  void loadFavouriteProducts() {
    List<dynamic> favList = box.read<List<dynamic>>('favourites') ?? [];
    favouritList.assignAll(favList.map((e) => ProductModel.fromMap(e)).toList());
  }
}
