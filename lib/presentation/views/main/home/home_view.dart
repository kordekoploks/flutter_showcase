import 'package:eshop/presentation/views/main/home/product_list.dart';
import 'package:eshop/presentation/views/main/home/search_filter_product.dart';
import 'package:eshop/presentation/views/main/home/user_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/product/product_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);

    context.read<ProductBloc>().stream.listen((state) {
      if (state is ProductLoaded || state is ProductError) {
        _isFetchingMore = false;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll > maxScroll * 0.7 && !_isFetchingMore) {
      final productBloc = context.read<ProductBloc>();
      if (productBloc.state is ProductLoaded) {
        _isFetchingMore = true;
        productBloc.add(const GetMoreProducts());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final paddingTop = MediaQuery.of(context).padding.top + 10;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: paddingTop),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: UserHeader(),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 12, left: 20, right: 20),
            child: SearchFilterProduct(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ProductList(scrollController: _scrollController),
            ),
          ),
        ],
      ),
    );
  }
}
