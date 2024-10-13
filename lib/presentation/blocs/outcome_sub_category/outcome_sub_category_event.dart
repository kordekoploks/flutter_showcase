part of 'outcome_sub_category_bloc.dart';

abstract class OutcomeSubCategoryEvent extends Equatable {
  const OutcomeSubCategoryEvent();
}

class GetSubCategories extends OutcomeSubCategoryEvent {
  final OutcomeCategory _data;

  const GetSubCategories(this._data);

  @override
  List<Object> get props => [];
}

class FilterCategories extends OutcomeSubCategoryEvent {
  final String keyword;
  const FilterCategories(this.keyword);

  @override
  List<Object> get props => [];
}


class AddSubCategory extends OutcomeSubCategoryEvent {
  final OutcomeSubCategoryUseCaseParams _params;
  const AddSubCategory(this._params);

  @override
  List<Object> get props => [];
}

class UpdateSubCategory extends OutcomeSubCategoryEvent {
  final OutcomeSubCategoryUseCaseParams _params;
  const UpdateSubCategory(this._params);

  @override
  List<Object> get props => [];
}

class DeleteSubCategory extends OutcomeSubCategoryEvent {
  final OutcomeSubCategory _data;
  const DeleteSubCategory(this._data);

  @override
  List<Object> get props => [];
}




