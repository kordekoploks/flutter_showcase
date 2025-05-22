import 'package:bloc_test/bloc_test.dart';
import 'package:eshop/domain/entities/product/pagination_meta_data.dart';
import 'package:eshop/domain/usecases/product/get_product_usecase.dart';
import 'package:eshop/presentation/blocs/product/product_bloc.dart';
import 'package:eshop/presentation/views/main/home/home_view.dart';
import 'package:eshop/presentation/views/main/home/product_list.dart';
import 'package:eshop/presentation/views/main/home/search_filter_product.dart';
import 'package:eshop/presentation/views/main/home/user_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockProductBloc extends Mock implements ProductBloc {}

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    mockProductBloc = MockProductBloc();
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<ProductBloc>.value(
        value: mockProductBloc,
        child: const HomeView(),
      ),
    );
  }

  testWidgets('renders UserHeader, SearchFilterProduct, and ProductList',
          (WidgetTester tester) async {
        when(() => mockProductBloc.state).thenReturn(
          ProductInitial(
            products: const [],
            metaData: PaginationMetaData(limit: 10, pageSize: 1, total: 0),
            params: const FilterProductParams(),
          ),
        );
        when(() => mockProductBloc.stream).thenAnswer((_) => const Stream.empty());

        await tester.pumpWidget(createTestWidget());

        expect(find.byType(UserHeader), findsOneWidget);
        expect(find.byType(SearchFilterProduct), findsOneWidget);
        expect(find.byType(ProductList), findsOneWidget);
      });

  testWidgets('triggers GetMoreProducts on scroll when ProductLoaded',
          (WidgetTester tester) async {
        final state = ProductLoaded(
          products: const [],
          metaData: PaginationMetaData(limit: 10, pageSize: 1, total: 100),
          params: const FilterProductParams(),
        );

        when(() => mockProductBloc.state).thenReturn(state);
        whenListen(
          mockProductBloc,
          Stream<ProductState>.fromIterable([state]),
        );

        await tester.pumpWidget(createTestWidget());
        await tester.pumpAndSettle();

        final scrollable = find.byType(Scrollable);
        final gesture = await tester.startGesture(tester.getCenter(scrollable));
        await gesture.moveBy(const Offset(0, -1000));
        await tester.pump();

        verify(() => mockProductBloc.add(const GetMoreProducts())).called(1);
      });
}
