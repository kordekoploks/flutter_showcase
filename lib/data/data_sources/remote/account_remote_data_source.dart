import 'package:eshop/core/error/failures.dart';
import 'package:http/http.dart' as http;

import '../../../../data/models/account/account_model.dart';
import '../../../core/constant/strings.dart';


abstract class AccountRemoteDataSource {
  Future<List<AccountModel>> getAccount();
}

abstract class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final http.Client client;
  AccountRemoteDataSourceImpl({required this.client});

  @override
  Future<List<AccountModel>> getCategories() =>
      _getAccountFromUrl('$baseUrl/categories');

  Future<List<AccountModel>> _getAccountFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return accountModelListFromRemoteJson(response.body);
    } else {
      throw ServerFailure();
    }
  }
}
