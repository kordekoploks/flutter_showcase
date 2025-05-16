import 'package:eshop/presentation/widgets/error_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constant/images.dart';
import '../../../../domain/usecases/product/get_product_usecase.dart';
import '../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../blocs/filter/filter_cubit.dart';
import '../../../blocs/product/product_bloc.dart';
import '../../../widgets/alert_card.dart';
import 'product_card.dart';

class ProductList extends StatelessWidget {
  final ScrollController scrollController;

  const ProductList({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded && state.products.isEmpty) {
          return AlertCard(
            image: kEmpty,
            message: l10n.productNotFound,
          );
        }

        if (state is ProductError && state.products.isEmpty) {
          return ErrorState(
            failure: state.failure,
            onRetry: () {
              final keyword = context.read<FilterCubit>().searchController.text;
              context.read<ProductBloc>().add(
                GetProducts(FilterProductParams(keyword: keyword)),
              );
            },
          );
        }


        final products = state.products;
        final isLoadingMore = state is ProductLoading;

        return RefreshIndicator(
          onRefresh: () async {
            context.read<ProductBloc>().add(const GetProducts(FilterProductParams()));
          },
          child: GridView.builder(
            itemCount: products.length + (isLoadingMore ? 10 : 0),
            controller: scrollController,
            padding: EdgeInsets.only(
              top: 18,
              left: 20,
              right: 20,
              bottom: 80 + MediaQuery.of(context).padding.bottom,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 5,
              mainAxisSpacing: 20,
            ),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (index < products.length) {
                return ProductCard(product: products[index]);
              } else {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade100,
                  highlightColor: Colors.white,
                  child: const ProductCard(),
                );
              }
            },
          ),
        );
      },
    );
  }
}
