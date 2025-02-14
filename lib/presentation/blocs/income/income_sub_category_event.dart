part of 'income_sub_category_bloc.dart';

abstract class IncomeSubCategoryEvent extends Equatable {
  const IncomeSubCategoryEvent();
}

class GetSubCategories extends IncomeSubCategoryEvent {
  final IncomeCategory _data;

  const GetSubCategories(this._data);

  @override
  List<Object> get props => [];
}

class FilterCategories extends IncomeSubCategoryEvent {
  final String keyword;
  const FilterCategories(this.keyword);

  @override
  List<Object> get props => [];
}


class AddSubCategory extends IncomeSubCategoryEvent {
  final IncomeSubCategoryUseCaseParams _params;
  const AddSubCategory(this._params);

  @override
  List<Object> get props => [];
}

class UpdateSubCategory extends IncomeSubCategoryEvent {
  final IncomeSubCategoryUseCaseParams _params;
  const UpdateSubCategory(this._params);

  @override
  List<Object> get props => [];
}

class DeleteSubCategory extends IncomeSubCategoryEvent {
  final IncomeSubCategory _data;
  const DeleteSubCategory(this._data);

  @override
  List<Object> get props => [];
}




