import 'dart:convert';

import 'package:eshop/core/error/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../objectbox.g.dart';
import '../../models/category/category_model.dart';
import 'entity/category_entity.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCategories();

  Future<void> saveCategory(CategoryModel categoryModel);

  Future<void> deleteCategory(CategoryModel categoryModel);

  Future<void> saveCategories(List<CategoryModel> categoriesToCache);

  Future<void> generateCategories();
}

const cachedCategories = 'CACHED_CATEGORIES';

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final Box<CategoryEntity> categoryBox;
  final Store store;

  CategoryLocalDataSourceImpl({required this.categoryBox, required this.store});

  @override
  Future<List<CategoryModel>> getCategories() {
    return Future.value(categoryBox
        .getAll()
        .map((e) => CategoryModel(
            id: e.id.toString(),
            position: e.position!,
            name: e.name!,
            desc: e.desc!,
            image: e.image!))
        .toList());
  }

  @override
  Future<void> saveCategory(CategoryModel e) {
    return categoryBox.putAsync(
        CategoryEntity(int.parse(e.id), e.name, e.image, e.position, e.desc));
  }

  @override
  Future<void> deleteCategory(CategoryModel categoryModel) {
    return categoryBox.removeAsync(int.parse(categoryModel.id));
  }

  @override
  Future<void> saveCategories(List<CategoryModel> categoriesToCache) {
    return Future(() => categoryBox.putMany(categoriesToCache
        .map((e) => CategoryEntity(
            int.parse(e.id), e.name, e.image, e.position, e.desc))
        .toList()));
  }

  @override
  Future<void> generateCategories() async {
    final jsonData =
        json.decode(categoryInitializeData) as Map<String, dynamic>;
    final List<dynamic> data = jsonData['data'];

    for (var category in data) {
      final categoryEntity = CategoryEntity(
          int.parse(category["_id"]),
          category["name"],
          category["image"],
          category["position"],
          category["desc"]);
      categoryBox.put(categoryEntity);
    }
    // if (Admin.isAvailable()) {
    //   // Keep a reference until no longer needed or manually closed.
    //   final admin = Admin(store);
    // }
  }
}

const String categoryInitializeData = '''
{
  "data": [
    {
      "_id": "1",
      "position": 1,
      "name": "Makan Dan Minum",
      "desc": "Bahan Makanan",
      "image": "image1.png"
    },
    {
      "_id": "2",
      "position": 2,
      "name": "Bahan Makanan",
      "desc": "Description for Category 2",
      "image": "image2.png"
    },
    {
      "_id": "3",
      "position": 3,
      "name": "Belanja",
      "desc": "Description for Category 3",
      "image": "image3.png"
    },
    {
      "_id": "4",
      "position": 4,
      "name": "Bensin",
      "desc": "Description for Category 4",
      "image": "image3.png"
    },
    {
      "_id": "5",
      "position": 5,
      "name": "Transportasi",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "6",
      "position": 6,
      "name": "Asuransi",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "7",
      "position": 7,
      "name": "Donasi",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "8",
      "position": 8,
      "name": "Edukasi",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "9",
      "position": 9,
      "name": "Hiburan",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "10",
      "position": 10,
      "name": "Investasi",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "11",
      "position":11,
      "name": "Kecantikan",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "12",
      "position": 12,
      "name": "Keluarga dan Teman",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "13",
      "position": 13,
      "name": "Kesehatan",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "13",
      "position": 13,
      "name": "Liburan",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "14",
      "position": 14,
      "name": "Olahraga",
      "desc": "Description for Category 5",
      "image": "image3.png"
    },
    {
      "_id": "15",
      "position": 15,
      "name": "Lainnya",
      "desc": "Description for Category 5",
      "image": "image3.png"
    }
  ]
}
''';
