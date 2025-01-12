part of 'category_bloc.dart';

abstract class OutcomeCategoryEvent extends Equatable {
  const OutcomeCategoryEvent();
}

class GetCategories extends OutcomeCategoryEvent {
  const GetCategories();

  @override
  List<Object> get props => [];
}

class FilterCategories extends OutcomeCategoryEvent {
  final String keyword;
  const FilterCategories(this.keyword);

  @override
  List<Object> get props => [];
}

class AddCategory extends OutcomeCategoryEvent {
  final OutcomeCategoryModel _categoryModel;
  const AddCategory(this._categoryModel);

  @override
  List<Object> get props => [];
}

class UpdateCategory extends OutcomeCategoryEvent {
  final OutcomeCategoryModel _categoryModel;
  const UpdateCategory(this._categoryModel);

  @override
  List<Object> get props => [];
}

class DeleteCategory extends OutcomeCategoryEvent {
  final OutcomeCategory _categoryModel;
  const DeleteCategory(this._categoryModel);

  @override
  List<Object> get props => [];
}


