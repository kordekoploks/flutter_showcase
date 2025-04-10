import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constant/images.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/router/app_router.dart';
import '../../../../domain/usecases/product/get_product_usecase.dart';
import '../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../blocs/filter/filter_cubit.dart';
import '../../../blocs/product/product_bloc.dart';
import '../../../blocs/user/user_bloc.dart';
import '../../../widgets/alert_card.dart';
import '../../../widgets/input_button.dart';
import '../../../widgets/product_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
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

    if (currentScroll > maxScroll * 0.7) {
      final productBloc = context.read<ProductBloc>();
      if (productBloc.state is ProductLoaded) {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildUserHeader(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12, left: 20, right: 20),
            child: _buildSearchAndFilterRow(context),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _buildProductGrid(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLogged) {
          return Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(AppRouter.userProfile),
                child: Text(
                  "${state.user.firstName} ${state.user.lastName}",
                  style: const TextStyle(fontSize: 26),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(AppRouter.userProfile),
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: state.user.image != null
                      ? CachedNetworkImageProvider(state.user.image!)
                      : const AssetImage(kUserAvatar) as ImageProvider,
                ),
              ),
            ],
          );
        }
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(AppLocalizations.of(context)!.welcome,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 36)),
                Text(AppLocalizations.of(context)!.listOfProduct,
                    style: const TextStyle(fontSize: 22)),
              ],
            ),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(AppRouter.signIn),
              child: const CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(kUserAvatar),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchAndFilterRow(BuildContext context) {
    final filterCubit = context.read<FilterCubit>();
    return Row(
      children: [
        Expanded(
          child: BlocBuilder<FilterCubit, FilterProductParams>(
            builder: (context, state) {
              return TextField(
                controller: filterCubit.searchController,
                onChanged: (_) => setState(() {}),
                onSubmitted: (val) => context.read<ProductBloc>().add(
                  GetProducts(FilterProductParams(keyword: val)),
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: filterCubit.searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      filterCubit.searchController.clear();
                      filterCubit.update(keyword: '');
                    },
                  )
                      : null,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(26)),
                  hintText: AppLocalizations.of(context)!.searchOfProduct,
                  fillColor: Colors.grey.shade100,
                  filled: true,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 55,
          child: BlocBuilder<FilterCubit, FilterProductParams>(
            builder: (context, state) {
              final filterCount = filterCubit.getFiltersCount();
              return Badge(
                alignment: AlignmentDirectional.topEnd,
                label: Text('$filterCount', style: const TextStyle(color: Colors.black87)),
                isLabelVisible: filterCount != 0,
                backgroundColor: Theme.of(context).primaryColor,
                child: InputButton(
                  color: Colors.black87,
                  onClick: () => Navigator.of(context).pushNamed(AppRouter.filter),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  Widget _buildProductGrid(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoaded && state.products.isEmpty) {
          return AlertCard(
            image: kEmpty,
            message: AppLocalizations.of(context)!.productNotFound,
          );
        }

        if (state is ProductError && state.products.isEmpty) {
          return _buildErrorState(context, state);
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<ProductBloc>().add(const GetProducts(FilterProductParams()));
          },
          child: GridView.builder(
            itemCount: state.products.length + (state is ProductLoading ? 10 : 0),
            controller: _scrollController,
            padding: EdgeInsets.only(
              top: 18,
              left: 20,
              right: 20,
              bottom: 80 + MediaQuery.of(context).padding.bottom,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              crossAxisSpacing: 12,
              mainAxisSpacing: 20,
            ),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (index < state.products.length) {
                return ProductCard(product: state.products[index]);
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

  Widget _buildErrorState(BuildContext context, ProductError state) {
    final message = switch (state.failure) {
      NetworkFailure() => AppLocalizations.of(context)!.networkFailurenTryAgain,
      ServerFailure() => AppLocalizations.of(context)!.internalServerError,
      CacheFailure() => AppLocalizations.of(context)!.noConnection,
      _ => AppLocalizations.of(context)!.productNotFound,
    };

    final image = switch (state.failure) {
      NetworkFailure() => kNoConnection,
      ServerFailure() => 'assets/status_image/internal-server-error.png',
      CacheFailure() => 'assets/status_image/no-connection.png',
      _ => kEmpty,
    };

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          const SizedBox(height: 8),
          Text(message, textAlign: TextAlign.center),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              final keyword = context.read<FilterCubit>().searchController.text;
              context.read<ProductBloc>().add(GetProducts(FilterProductParams(keyword: keyword)));
            },
          ),
        ],
      ),
    );
  }
}
