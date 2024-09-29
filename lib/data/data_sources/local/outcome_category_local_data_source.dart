import 'dart:convert';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/data/data_sources/local/entity/outcome_category_entity.dart';
import 'package:eshop/domain/entities/category/outcome_category.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../objectbox.g.dart';
import '../../models/category/outcome_category_model.dart';
import 'entity/outcome_category_entity.dart';
import 'entity/outcome_sub_category_entity.dart';

abstract class OutcomeCategoryLocalDataSource {
  Future<List<OutcomeCategoryModel>> getCategories();

  Future<void> saveCategory(OutcomeCategoryModel categoryModel);

  Future<void> deleteCategory(OutcomeCategory categoryModel);

  Future<void> saveCategories(List<OutcomeCategoryModel> categoriesToCache);

  Future<void> generateCategories();

  Future<List<OutcomeCategoryModel>> filterCategories(String params);
}

const cachedCategories = 'CACHED_CATEGORIES';

class CategoryLocalDataSourceImpl implements OutcomeCategoryLocalDataSource {
  final Box<OutcomeCategoryEntity> outcomeCategoryBox;
  final Box<OutcomeSubCategoryEntity> outcomeSubCategoryBox;
  final Store store;

  CategoryLocalDataSourceImpl(
      {required this.outcomeCategoryBox,
      required this.outcomeSubCategoryBox,
      required this.store});

  @override
  Future<List<OutcomeCategoryModel>> getCategories() {
    return Future.value(outcomeCategoryBox
        .getAll()
        .map((e) => OutcomeCategoryModel.fromEntity(e))
        .toList());
  }

  @override
  Future<void> saveCategory(OutcomeCategoryModel e) async {
    final categoryEntity = OutcomeCategoryEntity.fromModel(e);

    final newSubCategoryIds = e.outcomeSubCategory.map((sub) => sub.id).toSet();

    final idsToDelete = categoryEntity.subCategories
        .where((sub) => !newSubCategoryIds.contains(sub.id))
        .map((sub) => sub.id)
        .toList();

    await Future.wait([
      outcomeSubCategoryBox.removeManyAsync(idsToDelete),
      outcomeCategoryBox.putAsync(categoryEntity),
    ]);
  }



  @override
  Future<void> deleteCategory(OutcomeCategory categoryModel) {
    return outcomeCategoryBox.removeAsync(int.parse(categoryModel.id));
  }

  @override
  Future<void> saveCategories(List<OutcomeCategoryModel> categoriesToCache) {
    return Future(() => outcomeCategoryBox.putMany(categoriesToCache
        .map((e) => OutcomeCategoryEntity(
            int.parse(e.id), e.name, e.image, e.position, e.desc))
        .toList()));
  }

  @override
  Future<List<OutcomeCategoryModel>> filterCategories(String params) {
    return Future.value(outcomeCategoryBox
        .query(
            OutcomeCategoryEntity_.name.contains(params, caseSensitive: false))
        .build()
        .find()
        .map((e) => OutcomeCategoryModel(
            id: e.id.toString(),
            position: e.position!,
            name: e.name!,
            desc: e.desc!,
            image: e.image!))
        .toList());
  }

  @override
  Future<void> generateCategories() async {
    final jsonData =
        json.decode(categoryInitializeData) as Map<String, dynamic>;
    final List<dynamic> data = jsonData['data'];

    for (var category in data) {
      final outcomeCategoryEntity = OutcomeCategoryEntity(
          int.parse(category["_id"]),
          category["name"],
          category["image"],
          category["position"],
          category["desc"]);
      outcomeCategoryBox.put(outcomeCategoryEntity);
    }
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
