import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/usecases/product/get_product_usecase.dart';

class FilterCubit extends Cubit<FilterProductParams> {
  final TextEditingController searchController = TextEditingController();

  FilterCubit() : super(const FilterProductParams());

  void update({
    String? keyword,
  }) {
    emit(FilterProductParams(
      keyword: keyword ?? state.keyword,
    ));
  }

  void updateRange(double min, double max) => emit(state.copyWith(
        minPrice: min,
        maxPrice: max,
      ));

  int getFiltersCount() {
    int count = 0;
    count = count + ((state.minPrice != 0 || state.maxPrice != 10000) ? 1 : 0);
    return count;
  }

  void reset() => emit(const FilterProductParams());
}
