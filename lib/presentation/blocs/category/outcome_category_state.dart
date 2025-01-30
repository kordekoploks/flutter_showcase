part of 'outcome_category_bloc.dart';

abstract class OutcomeCategoryState extends Equatable {
  final List<OutcomeCategory> data;

  //todo make abstarct class for income category state(biar bisa jadi turunan)

  //todo make something similiar like outcome category

  const OutcomeCategoryState({required this.data});
}

class CategoryInitial extends OutcomeCategoryState {
  const CategoryInitial({required super.data});

  @override
  List<Object> get props => [];
}

class OutcomeCategoryLoading extends OutcomeCategoryState {
  const OutcomeCategoryLoading({required super.data});

  @override
  List<Object> get props => [];
}

class CategoryCacheLoaded extends OutcomeCategoryState {
  const CategoryCacheLoaded({required super.data});

  @override
  List<Object> get props => [];
}

class OutcomeCategoryEmpty extends OutcomeCategoryState {
  const OutcomeCategoryEmpty({required super.data});

  @override
  List<Object> get props => [];
}

class OutcomeCategoryAdded extends OutcomeCategoryState {
  final OutcomeCategory dataAdded;

  const OutcomeCategoryAdded({required this.dataAdded, required super.data});

  @override
  List<Object> get props => [];
}

class OutcomeCategoryDeleted extends OutcomeCategoryState {
  final OutcomeCategory dataDeleted;

  const OutcomeCategoryDeleted(
      {required this.dataDeleted, required super.data});

  @override
  List<Object> get props => [];
}

class OutcomeCategoryLoaded extends OutcomeCategoryState {
  const OutcomeCategoryLoaded({required super.data});

  @override
  List<Object> get props => [];
}

class OutcomeCategoryUpdating extends OutcomeCategoryState {
  final OutcomeCategory dataUpdating;

  const OutcomeCategoryUpdating(
      {required this.dataUpdating, required super.data});

  @override
  List<Object> get props => [];
}

class OutcomeCategoryUpdated extends OutcomeCategoryState {
  final OutcomeCategory dataUpdated;

  const OutcomeCategoryUpdated(
      {required this.dataUpdated, required super.data});

  @override
  List<Object> get props => [];
}

class OutcomeCateogryError extends OutcomeCategoryState {
  final Failure failure;

  const OutcomeCateogryError({required super.data, required this.failure});

  @override
  List<Object> get props => [];
}
