import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/router/app_router.dart';
import '../../../../domain/usecases/product/get_product_usecase.dart';
import '../../../../l10n/gen_l10n/app_localizations.dart';
import '../../../blocs/filter/filter_cubit.dart';
import '../../../blocs/product/product_bloc.dart';
import '../../../widgets/input_button.dart';

class SearchFilterProduct extends StatelessWidget {
  const SearchFilterProduct();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final filterCubit = context.read<FilterCubit>();

    return Row(
      children: [
        Expanded(
          child: BlocBuilder<FilterCubit, FilterProductParams>(
            builder: (context, state) {
              return TextField(
                controller: filterCubit.searchController,
                onSubmitted: (val) {
                  context.read<ProductBloc>().add(GetProducts(FilterProductParams(keyword: val)));
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: filterCubit.searchController.text.isNotEmpty
                      ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => filterCubit.reset(),
                  )
                      : null,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(26)),
                  hintText: l10n.searchOfProduct,
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
              final filterCount = context.select((FilterCubit cubit) => cubit.getFiltersCount());
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
}
