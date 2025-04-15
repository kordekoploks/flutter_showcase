import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/constant/images.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/router/app_router.dart';
import '../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../blocs/product/product_controller.dart';
import '../../../blocs/user/user_controller.dart';
import '../../../widgets/alert_card.dart';
import '../../../widgets/input_button.dart';
import '../../../widgets/product_card.dart';
import 'filter/filter_controller.dart';

class HomeViewGetx extends StatefulWidget {
  const HomeViewGetx({Key? key}) : super(key: key);

  @override
  State<HomeViewGetx> createState() => _HomeViewGetxState();
}

class _HomeViewGetxState extends State<HomeViewGetx> {
  late final ProductController productController;
  late final FilterController filterController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    productController = Get.find<ProductController>();
    filterController = Get.put(FilterController());

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (currentScroll > maxScroll * 0.7) {
        productController.loadMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
    final userController = Get.find<UserController>();

    return Obx(() {
      final user = userController.user.value;
      if (user != null) {
        return Row(
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(AppRouter.userProfile),
              child: Text("${user.firstName} ${user.lastName}", style: const TextStyle(fontSize: 26)),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () => Get.toNamed(AppRouter.userProfile),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: user.image != null
                    ? CachedNetworkImageProvider(user.image!)
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
              Text(AppLocalizations.of(context)!.listOfProduct, style: const TextStyle(fontSize: 22)),
            ],
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRouter.signIn),
            child: const CircleAvatar(radius: 24, backgroundImage: AssetImage(kUserAvatar)),
          ),
        ],
      );
    });
  }

  Widget _buildSearchAndFilterRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(() {
            return TextField(
              controller: filterController.searchController,
              onChanged: (_) => filterController.onSearchChanged(),
              onSubmitted: (val) => productController.fetchProducts(keyword: val),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: filterController.searchController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => filterController.clearSearch(),
                )
                    : null,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(26)),
                hintText: AppLocalizations.of(context)!.searchOfProduct,
                fillColor: Colors.grey.shade100,
                filled: true,
              ),
            );
          }),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 55,
          child: Obx(() {
            final count = filterController.filtersCount.value;
            return Badge(
              alignment: AlignmentDirectional.topEnd,
              label: Text('$count', style: const TextStyle(color: Colors.black87)),
              isLabelVisible: count != 0,
              backgroundColor: Theme.of(context).primaryColor,
              child: InputButton(
                color: Colors.black87,
                onClick: () => Get.toNamed(AppRouter.filter),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return Obx(() {
      if (productController.error.value != null && productController.products.isEmpty) {
        return _buildErrorState(context, productController.error.value!);
      }

      if (productController.products.isEmpty) {
        return AlertCard(
          image: kEmpty,
          message: AppLocalizations.of(context)!.productNotFound,
        );
      }

      return RefreshIndicator(
        onRefresh: productController.refreshProducts,
        child: GridView.builder(
          controller: _scrollController,
          itemCount: productController.products.length +
              (productController.isLoadingMore.value ? 10 : 0),
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
            if (index < productController.products.length) {
              return ProductCard(product: productController.products[index]);
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
    });
  }

  Widget _buildErrorState(BuildContext context, Failure failure) {
    String message;
    String image;

    if (failure is NetworkFailure) {
      message = AppLocalizations.of(context)!.networkFailurenTryAgain;
      image = kNoConnection;
    } else if (failure is ServerFailure) {
      message = AppLocalizations.of(context)!.internalServerError;
      image = 'assets/status_image/internal-server-error.png';
    } else if (failure is CacheFailure) {
      message = AppLocalizations.of(context)!.noConnection;
      image = 'assets/status_image/no-connection.png';
    } else {
      message = AppLocalizations.of(context)!.productNotFound;
      image = kEmpty;
    }

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
              final keyword = filterController.searchController.text;
              productController.fetchProducts(keyword: keyword);
            },
          ),
        ],
      ),
    );
  }
}

