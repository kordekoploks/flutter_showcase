import 'package:dartz/dartz.dart';
import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/data/models/user/edit_response_model.dart';
import 'package:eshop/domain/usecases/user/edit_full_name_usecase.dart';

import '../../../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../domain/entities/user/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_sources/local/user_local_data_source.dart';
import '../data_sources/remote/user_remote_data_source.dart';
import '../models/user/authentication_response_model.dart';

typedef _DataSourceChooser = Future<AuthenticationResponseModel> Function();
typedef _DataEditSourceChooser = Future<EditUserResponseModel> Function();

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  }
  );

  @override
  Future<Either<Failure, User>> signIn(params) async {
    return await _authenticate(() {
      return remoteDataSource.signIn(params);
    }
    );
  }

  @override
  Future<Either<Failure, User>> signUp(params) async {
    return await _authenticate(() {
      return remoteDataSource.signUp(params);
    }
    );
  }

  @override
  Future<Either<Failure, User>> edit(params) async {
    return await _authenticate(() {
      return remoteDataSource.edit(params);
    }
    );
  }
  //copy dan buat tapi ganti jadi edit/update

  @override
  Future<Either<Failure, User>> editFullName(params) async {
    return await _updateUserLocal(() {
      return remoteDataSource.editFullName(params);
    }
    );
  }

  @override
  Future<Either<Failure, User>> getCachedUser() async {
    try {
      final user = await localDataSource.getUser();
      return Right(user);
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, NoParams>> signOut() async {
    try {
      await localDataSource.clearCache();
      return Right(NoParams());
    } on CacheFailure {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, User>> _authenticate(
      _DataSourceChooser getDataSource,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await getDataSource();
        localDataSource.saveToken(remoteResponse.token);
        localDataSource.saveUser(remoteResponse.user);
        return Right(remoteResponse.user);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  Future<Either<Failure, User>> _updateUserLocal(
      _DataEditSourceChooser getDataSource,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteResponse = await getDataSource();
        localDataSource.saveUser(remoteResponse.user);
        return Right(remoteResponse.user);
      } on Failure catch (failure) {
        return Left(failure);
      }
    } else {
      return Left(NetworkFailure());
    }
  }
  }

