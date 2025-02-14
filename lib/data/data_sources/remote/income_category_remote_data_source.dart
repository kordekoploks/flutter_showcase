import 'package:eshop/core/error/failures.dart';
import 'package:http/http.dart' as http;

import '../../../core/constant/strings.dart';
import '../../models/category/income_category_model.dart';

abstract class IncomeCategoryRemoteDataSource {
  Future<List<IncomeCategoryModel>> getCategories();
}

class IncomeCategoryRemoteDataSourceImpl implements IncomeCategoryRemoteDataSource {
  final http.Client client;
  IncomeCategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<IncomeCategoryModel>> getCategories() =>
      _getCategoryFromUrl('$baseUrl/categories');

  Future<List<IncomeCategoryModel>> _getCategoryFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return categoryModelListFromRemoteJson(response.body);
    } else {
      throw ServerFailure();
    }
  }
}
