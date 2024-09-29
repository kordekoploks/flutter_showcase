part of 'outcome_sub_category_bloc.dart';

abstract class OutcomeSubCategoryState extends Equatable {

  final List<OutcomeSubCategory> data;
  const OutcomeSubCategoryState({required this.data});
}

class OutcomeSubCategoryInitial extends OutcomeSubCategoryState {
  const OutcomeSubCategoryInitial({required super.data});
  @override
  List<Object> get props => [];
}

class OutcomeSubCategoryLoading extends OutcomeSubCategoryState {
  const OutcomeSubCategoryLoading({required super.data});
  @override
  List<Object> get props => [];
}


class OutcomeSubCategoryLoaded extends OutcomeSubCategoryState {
  const OutcomeSubCategoryLoaded({required super.data});
  @override
  List<Object> get props => [];
}

class OutcomeSubCategoryAdded extends OutcomeSubCategoryState {
  final OutcomeSubCategory dataAdded;
  const OutcomeSubCategoryAdded({required this.dataAdded, required super.data});
  @override
  List<Object> get props => [];
}

class OutcomeSubCategoryUpdated extends OutcomeSubCategoryState {
  final OutcomeSubCategory dataUpdated;
  const OutcomeSubCategoryUpdated({required this.dataUpdated, required super.data});
  @override
  List<Object> get props => [];
}

class OutcomeSubCategoryEmpty extends OutcomeSubCategoryState {
  const OutcomeSubCategoryEmpty({required super.data});
  @override
  List<Object> get props => [];
}


class OutcomeSubCategoryDeleted extends OutcomeSubCategoryState {
  final OutcomeSubCategory dataDeleted;
  const OutcomeSubCategoryDeleted({required this.dataDeleted, required super.data});
  @override
  List<Object> get props => [];
}



class OutcomeSubCategoryError extends OutcomeSubCategoryState {
  final Failure failure;
  const OutcomeSubCategoryError({required super.data, required this.failure});
  @override
  List<Object> get props => [];
}
