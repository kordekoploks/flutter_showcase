import 'dart:convert';

import 'package:eshop/core/error/failures.dart';
import 'package:eshop/domain/usecases/user/edit_usecase.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../../../core/constant/strings.dart';
import '../../../domain/usecases/user/sign_in_usecase.dart';
import '../../../domain/usecases/user/sign_up_usecase.dart';
import '../../models/user/authentication_response_model.dart';

abstract class UserRemoteDataSource {
  Future<AuthenticationResponseModel> signIn(SignInParams params);
  Future<AuthenticationResponseModel> signUp(SignUpParams params);
  Future<AuthenticationResponseModel> edit(EditParams params);
  //copy dan ganti menjadi edit/update pake param signup
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;
  UserRemoteDataSourceImpl({required this.client});
  
  @override
  Future<AuthenticationResponseModel> signIn(SignInParams params) async {
    final response =
        await client.post(Uri.parse('$baseUrl/authentication/local/sign-in'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'identifier': params.username,
              'password': params.password,
            }
            )
        );
    if (response.statusCode == 200) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthenticationResponseModel> signUp(SignUpParams params) async {
    final response =
        await client.post(Uri.parse('$baseUrl/authentication/local/sign-up'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: json.encode({
              'firstName': params.firstName,
              'lastName': params.lastName,
              'phoneNumber': params.phoneNumber,
              'email': params.email,
              'password': params.password,
            }
            )
        );
    if (response.statusCode == 200) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<AuthenticationResponseModel> edit(EditParams params) async {
    final response =
    await client.post(Uri.parse('$baseUrl/authentication/local/edit'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'firstName': params.firstName,
          'lastName': params.lastName,
          'phoneNumber': params.phoneNumber,
          'email': params.email,
          'password': params.password,
        }));
    if (response.statusCode == 200) {
      return authenticationResponseModelFromJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 401) {
      throw CredentialFailure();
    } else {
      throw ServerException("terjadi kesalahan server");
    }
  }
}
//copy ganti signup menjadi edit/update