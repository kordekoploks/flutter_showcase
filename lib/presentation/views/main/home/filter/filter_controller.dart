import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  final searchController = TextEditingController();
  final filtersCount = 0.obs;

  void onSearchChanged() {
    // Optionally update filtersCount or perform actions on search change
  }

  void clearSearch() {
    searchController.clear();
    onSearchChanged();
  }
}
