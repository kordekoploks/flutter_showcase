import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:eshop/core/error/failures.dart';
import 'package:eshop/core/usecases/usecase.dart';
import 'package:eshop/domain/usecases/outcome_category/filter_category_usecase.dart';
import 'package:eshop/domain/usecases/outcome_category/get_cached_category_usecase.dart';
import 'package:eshop/domain/usecases/outcome_category/get_remote_category_usecase.dart';
import 'package:eshop/presentation/blocs/category/category_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/constant_objects.dart';

class MockGetRemoteCategoryUseCase extends Mock
    implements GetRemoteCategoryUseCase {}

class MockGetCachedCategoryUseCase extends Mock
    implements GetCachedCategoryUseCase {}

class MockFilterCategoryUseCase extends Mock implements FilterCategoryUseCase {}

void main() {
  late OutcomeCategoryBloc bloc;
  late MockGetRemoteCategoryUseCase mockGetRemoteCategoryUseCase;
  late MockGetCachedCategoryUseCase mockGetCachedCategoryUseCase;
  late MockFilterCategoryUseCase mockFilterCategoryUseCase;

  setUp(() {
    mockGetRemoteCategoryUseCase = MockGetRemoteCategoryUseCase();
    mockGetCachedCategoryUseCase = MockGetCachedCategoryUseCase();
    mockFilterCategoryUseCase = MockFilterCategoryUseCase();

    bloc = OutcomeCategoryBloc(
      mockGetRemoteCategoryUseCase,
      mockGetCachedCategoryUseCase,
      mockFilterCategoryUseCase,
    );
  });

  test('initialState should be Empty', () {
    /// Assert
    expect(bloc.state, equals(const OutcomeCategoryLoading(categories: [])));
  });

  blocTest<OutcomeCategoryBloc, OutcomeCategoryState>(
    'emits [CategoryLoading, CategoryCacheLoaded, CategoryLoaded] when GetCategories is added',
    build: () {
      when(() => mockGetCachedCategoryUseCase(NoParams()))
          .thenAnswer((_) async => const Right([tCategoryModel]));
      when(() => mockGetRemoteCategoryUseCase(NoParams())).thenAnswer(
          (_) async => const Right([tCategoryModel, tCategoryModel]));
      return bloc;
    },
    act: (bloc) => bloc.add(const GetCategories()),
    expect: () => [
      const OutcomeCategoryLoading(categories: []),
      const CategoryCacheLoaded(categories: []),
      const OutcomeCategoryLoaded(categories: []),
    ],
  );

  blocTest<OutcomeCategoryBloc, OutcomeCategoryState>(
    'emits [CategoryLoading, CategoryCacheLoaded] when FilterCategories is added',
    build: () {
      when(() => mockFilterCategoryUseCase('keyword'))
          .thenAnswer((_) async => const Right([]));
      return bloc;
    },
    act: (bloc) => bloc.add(const FilterCategories('keyword')),
    expect: () => [
      const OutcomeCategoryLoading(categories: []),
      const CategoryCacheLoaded(categories: []),
    ],
  );

  blocTest<OutcomeCategoryBloc, OutcomeCategoryState>(
    'emits [CategoryLoading, CategoryError] when GetCategories encounters an error',
    build: () {
      when(() => mockGetCachedCategoryUseCase(NoParams()))
          .thenAnswer((_) async => const Right([]));
      when(() => mockGetRemoteCategoryUseCase(NoParams()))
          .thenAnswer((_) async => Left(ExceptionFailure()));
      return bloc;
    },
    act: (bloc) => bloc.add(const GetCategories()),
    expect: () => [
      const OutcomeCategoryLoading(categories: []),
      const CategoryCacheLoaded(categories: [tCategoryModel]),
      OutcomeCateogryError(categories: const [tCategoryModel], failure: ExceptionFailure()),
    ],
  );

  blocTest<OutcomeCategoryBloc, OutcomeCategoryState>(
    'emits [CategoryLoading, CategoryError] when FilterCategories encounters an error',
    build: () {
      when(() => mockFilterCategoryUseCase('keyword'))
          .thenAnswer((_) async => Left(ExceptionFailure()));
      return bloc;
    },
    act: (bloc) => bloc.add(const FilterCategories('keyword')),
    expect: () => [
      const OutcomeCategoryLoading(categories: []),
      OutcomeCateogryError(
        categories: const [],
        failure: ExceptionFailure(),
      ),
    ],
  );

  blocTest<OutcomeCategoryBloc, OutcomeCategoryState>(
    'emits [CategoryLoading, CategoryCacheLoaded] when FilterCategories returns an empty list',
    build: () {
      when(() => mockFilterCategoryUseCase('keyword'))
          .thenAnswer((_) async => const Right([]));
      return bloc;
    },
    act: (bloc) => bloc.add(const FilterCategories('keyword')),
    expect: () => [
      const OutcomeCategoryLoading(categories: []),
      const CategoryCacheLoaded(categories: []),
    ],
  );
}
