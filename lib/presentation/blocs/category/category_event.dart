part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class GetCategories extends CategoryEvent {
  const GetCategories();

  @override
  List<Object> get props => [];
}

class FilterCategories extends CategoryEvent {
  final String keyword;
  const FilterCategories(this.keyword);

  @override
  List<Object> get props => [];
}


class AddCategory extends CategoryEvent {
  final CategoryModel _categoryModel;
  const AddCategory(this._categoryModel);

  @override
  List<Object> get props => [];
}

class UpdateCategory extends CategoryEvent {
  final CategoryModel _categoryModel;
  const UpdateCategory(this._categoryModel);

  @override
  List<Object> get props => [];
}

class DeleteCategory extends CategoryEvent {
  final CategoryModel _categoryModel;
  const DeleteCategory(this._categoryModel);

  @override
  List<Object> get props => [];
}
