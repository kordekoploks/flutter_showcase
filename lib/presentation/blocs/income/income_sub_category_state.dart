part of 'income_sub_category_bloc.dart';

abstract class IncomeSubCategoryState extends Equatable {

  final List<IncomeSubCategory> data;
  const IncomeSubCategoryState({required this.data});
}

class IncomeSubCategoryInitial extends IncomeSubCategoryState {
  const IncomeSubCategoryInitial({required super.data});
  @override
  List<Object> get props => [];
}

class IncomeSubCategoryLoading extends IncomeSubCategoryState {
  const IncomeSubCategoryLoading({required super.data});
  @override
  List<Object> get props => [];
}


class IncomeSubCategoryLoaded extends IncomeSubCategoryState {
  const IncomeSubCategoryLoaded({required super.data});
  @override
  List<Object> get props => [];
}

class IncomeSubCategoryAdded extends IncomeSubCategoryState {
  final IncomeSubCategory dataAdded;
  const IncomeSubCategoryAdded({required this.dataAdded, required super.data});
  @override
  List<Object> get props => [];
}

class IncomeSubCategoryUpdated extends IncomeSubCategoryState {
  final IncomeSubCategory dataUpdated;
  const IncomeSubCategoryUpdated({required this.dataUpdated, required super.data});
  @override
  List<Object> get props => [];
}

class IncomeSubCategoryEmpty extends IncomeSubCategoryState {
  const IncomeSubCategoryEmpty({required super.data});
  @override
  List<Object> get props => [];
}


class IncomeSubCategoryDeleted extends IncomeSubCategoryState {
  final IncomeSubCategory dataDeleted;
  const IncomeSubCategoryDeleted({required this.dataDeleted, required super.data});
  @override
  List<Object> get props => [];
}



class IncomeSubCategoryError extends IncomeSubCategoryState {
  final Failure failure;
  const IncomeSubCategoryError({required super.data, required this.failure});
  @override
  List<Object> get props => [];
}
