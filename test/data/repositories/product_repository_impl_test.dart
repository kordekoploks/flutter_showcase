import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/exceptions.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/network/network_info.dart';
import 'package:eshop/data/data_sources/local/product_local_data_source.dart';
import 'package:eshop/data/data_sources/remote/product_remote_data_source.dart';
import 'package:eshop/data/repositories/product_repository_impl.dart';
import 'package:eshop/domain/usecases/product/get_product_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../fixtures/constent_objects.dart';

class MockRemoteDataSource extends Mock implements ProductRemoteDataSource {}

class MockLocalDataSource extends Mock implements ProductLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late ProductRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
    // when(() => repository.getProducts()).thenAnswer((_) async => const Right(<Product>[]));
    // print(repository.getProducts());
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      body();
    });
  }

  void runTestsOffline(Function body) {
    group('device is offline', () {
      setUp(() {
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      body();
    });
  }

  group('getConcreted', () {
    test(
      'should check if the device is online',
      () async {
        // arrange
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() =>
                mockRemoteDataSource.getProducts(const FilterProductParams()))
            .thenAnswer((_) async => tProductResponseModel);
        when(() => mockLocalDataSource.cacheProducts(tProductResponseModel))
            .thenAnswer((invocation) => Future<void>.value());
        // act
        // repository.getProducts();
        // assert
        // verify(() => mockNetworkInfo.isConnected);
      },
    );

    runTestsOnline(() {
      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          // arrange
          when(() =>
                  mockRemoteDataSource.getProducts(const FilterProductParams()))
              .thenAnswer((_) async => tProductResponseModel);
          when(() => mockLocalDataSource.cacheProducts(tProductResponseModel))
              .thenAnswer((invocation) => Future<void>.value());
          // act
          final actualResult =
              await repository.getProducts(const FilterProductParams());
          // assert
          actualResult.fold(
            (left) => fail('test failed'),
            (right) {
              verify(() => mockRemoteDataSource
                  .getProducts(const FilterProductParams()));
              expect(right, tProductResponseModel);
            },
          );
        },
      );

      test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
          // arrange
          when(() =>
                  mockRemoteDataSource.getProducts(const FilterProductParams()))
              .thenAnswer((_) async => tProductResponseModel);
          when(() => mockLocalDataSource.cacheProducts(tProductResponseModel))
              .thenAnswer((invocation) => Future<void>.value());
          // act
          await repository.getProducts(const FilterProductParams());
          // // assert
          verify(() =>
              mockRemoteDataSource.getProducts(const FilterProductParams()));
          verify(
              () => mockLocalDataSource.cacheProducts(tProductResponseModel));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(() =>
                  mockRemoteDataSource.getProducts(const FilterProductParams()))
              .thenThrow(ServerException());
          // act
          final result =
              await repository.getProducts(const FilterProductParams());
          // assert
          verify(() =>
              mockRemoteDataSource.getProducts(const FilterProductParams()));
          verifyZeroInteractions(mockLocalDataSource);
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    runTestsOffline(() {
      test(
        'should return last locally cached data when the cached data is present',
        () async {
          // arrange
          when(() => mockLocalDataSource.getLastProducts())
              .thenAnswer((_) async => tProductResponseModel);
          // act
          final result =
              await repository.getProducts(const FilterProductParams());
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastProducts());
          expect(result, equals(Right(tProductResponseModel)));
        },
      );

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          when(() => mockLocalDataSource.getLastProducts())
              .thenThrow(CacheException());
          // act
          final result =
              await repository.getProducts(const FilterProductParams());
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource.getLastProducts());
          expect(result, equals(Left(CacheFailure())));
        },
      );
    });
  });
}
