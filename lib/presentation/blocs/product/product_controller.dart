import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../core/error/failures.dart';
import '../../../domain/entities/product/product.dart';
import '../../../domain/usecases/product/get_product_usecase.dart';

class ProductController extends GetxController {
  final GetProductUseCase _getProductUseCase;

  var products = <Product>[].obs;
  var isLoadingMore = false.obs;
  var error = Rxn<Failure>();
  var page = 1;


  ProductController(this._getProductUseCase);


  void fetchProducts({String? keyword}) {
    if (isLoadingMore.value) return; // Avoid multiple requests at once

    isLoadingMore.value = true;
    // Simulate a network call
    Future.delayed(Duration(seconds: 2), () {
      try {
        // Replace with actual product fetch logic
        List<Product> fetchedProducts = []; // Fetch the products here
        if (fetchedProducts.isNotEmpty) {
          products.addAll(fetchedProducts);
        }
      } catch (e) {
        error.value = NetworkFailure(); // Example failure handling
      } finally {
        isLoadingMore.value = false;
      }
    });
  }

  // Refresh the products list (e.g., for pull-to-refresh)
  Future<void> refreshProducts() async {
    try {
      products.clear(); // Clear existing products
      page = 1;
      fetchProducts(); // Re-fetch the products
    } catch (e) {
      error.value = NetworkFailure(); // Example failure handling
    }
  }

  // Load more products for pagination
  void loadMoreProducts() {
    if (!isLoadingMore.value) {
      page++;
      fetchProducts(); // Fetch next page of products
    }
  }
}
