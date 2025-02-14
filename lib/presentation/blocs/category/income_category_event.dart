part of 'income_category_bloc.dart';

abstract class IncomeCategoryEvent extends Equatable {
  const IncomeCategoryEvent();
}

class GetIncomeCategories extends IncomeCategoryEvent {
  const GetIncomeCategories();

  @override
  List<Object> get props => [];
}

class FilterCategories extends IncomeCategoryEvent {
  final String keyword;
  const FilterCategories(this.keyword);

  @override
  List<Object> get props => [];
}

class AddCategory extends IncomeCategoryEvent {
  final IncomeCategoryModel _categoryModel;
  const AddCategory(this._categoryModel);

  @override
  List<Object> get props => [];
}

class UpdateCategory extends IncomeCategoryEvent {
  final IncomeCategoryModel _categoryModel;
  const UpdateCategory(this._categoryModel);

  @override
  List<Object> get props => [];
}

class DeleteCategory extends IncomeCategoryEvent {
  final IncomeCategory _categoryModel;
  const DeleteCategory(this._categoryModel);

  @override
  List<Object> get props => [];
}


