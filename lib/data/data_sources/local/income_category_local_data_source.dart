import 'dart:convert';


import '../../../domain/entities/category/income_category.dart';

import '../../../objectbox.g.dart';
import '../../models/category/income_category_model.dart';
import 'entity/income_category_entity.dart';
import 'entity/income_sub_category_entity.dart';

abstract class IncomeCategoryLocalDataSource {
  Future<List<IncomeCategoryModel>> getCategories();

  Future<void> saveCategory(IncomeCategoryModel categoryModel);

  Future<void> deleteCategory(IncomeCategory categoryModel);

  Future<void> saveCategories(List<IncomeCategoryModel> categoriesToCache);

  Future<void> generateCategories();

  Future<List<IncomeCategoryModel>> filterCategories(String params);
}

const cachedCategories = 'CACHED_CATEGORIES';

class IncomeCategoryLocalDataSourceImpl implements IncomeCategoryLocalDataSource {
  final Box<IncomeCategoryEntity> incomeCategoryBox;
  final Box<IncomeSubCategoryEntity> incomeSubCategoryBox;
  final Store store;

  IncomeCategoryLocalDataSourceImpl(
      {required this.incomeCategoryBox,
        required this.incomeSubCategoryBox,
        required this.store});

  @override
  Future<List<IncomeCategoryModel>> getCategories() {
    return Future.value(incomeCategoryBox
        .getAll()
        .map((e) => IncomeCategoryModel.fromEntity(e))
        .toList());
  }

  @override
  Future<void> saveCategory(IncomeCategoryModel e) async {
    final categoryEntity = IncomeCategoryEntity.fromModel(e);

    final newSubCategoryIds = e.incomeSubCategory.map((sub) => sub.id).toSet();

    final idsToDelete = categoryEntity.subCategories
        .where((sub) => !newSubCategoryIds.contains(sub.id))
        .map((sub) => sub.id)
        .toList();

    await Future.wait([
      incomeSubCategoryBox.removeManyAsync(idsToDelete),
      incomeCategoryBox.putAsync(categoryEntity),
    ]);
  }


  @override
  Future<void> deleteCategory(IncomeCategory categoryModel) {
    return incomeCategoryBox.removeAsync(int.parse(categoryModel.id));
  }

  @override
  Future<void> saveCategories(List<IncomeCategoryModel> categoriesToCache) {
    return Future(() => incomeCategoryBox.putMany(categoriesToCache
        .map((e) => IncomeCategoryEntity(
        int.parse(e.id), e.name, e.image, e.position, e.desc, e.icon,))
        .toList()));
  }

  @override
  Future<List<IncomeCategoryModel>> filterCategories(String params) {
    return Future.value(incomeCategoryBox
        .query(
        IncomeCategoryEntity_.name.contains(params, caseSensitive: false))
        .build()
        .find()
        .map((e) => IncomeCategoryModel(
        id: e.id.toString(),
        position: e.position!,
        name: e.name!,
        desc: e.desc!,
        image: e.image!,
        icon: e.icon!))
        .toList());
  }

  @override
  Future<void> generateCategories() async {
    final jsonData =
    json.decode(categoryInitializeData) as Map<String, dynamic>;
    final List<dynamic> data = jsonData['data'];

    for (var category in data) {
      final incomeCategoryEntity = IncomeCategoryEntity(
          int.parse(category["_id"]),
          category["name"],
          category["image"],
          category["position"],
          category["desc"],
          category["icon"]);
      incomeCategoryBox.put(incomeCategoryEntity);
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
