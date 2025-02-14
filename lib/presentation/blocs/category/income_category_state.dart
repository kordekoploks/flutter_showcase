part of 'income_category_bloc.dart';

abstract class IncomeCategoryState extends Equatable {
  final List<IncomeCategory> data;

  //todo make abstarct class for income category state(biar bisa jadi turunan)

  //todo make something similiar like outcome category

  const IncomeCategoryState({required this.data});
}

class CategoryInitial extends IncomeCategoryState {
  const CategoryInitial({required super.data});

  @override
  List<Object> get props => [];
}

class IncomeCategoryLoading extends IncomeCategoryState {
  const IncomeCategoryLoading({required super.data});

  @override
  List<Object> get props => [];
}

class CategoryCacheLoaded extends IncomeCategoryState {
  const CategoryCacheLoaded({required super.data});

  @override
  List<Object> get props => [];
}

class IncomeCategoryEmpty extends IncomeCategoryState {
  const IncomeCategoryEmpty({required super.data});

  @override
  List<Object> get props => [];
}

class IncomeCategoryAdded extends IncomeCategoryState {
  final IncomeCategory dataAdded;

  const IncomeCategoryAdded({required this.dataAdded, required super.data});

  @override
  List<Object> get props => [];
}

class IncomeCategoryDeleted extends IncomeCategoryState {
  final IncomeCategory dataDeleted;

  const IncomeCategoryDeleted(
      {required this.dataDeleted, required super.data});

  @override
  List<Object> get props => [];
}

class IncomeCategoryLoaded extends IncomeCategoryState {
  const IncomeCategoryLoaded({required super.data});

  @override
  List<Object> get props => [];
}

class IncomeCategoryUpdating extends IncomeCategoryState {
  final IncomeCategory dataUpdating;

  const IncomeCategoryUpdating(
      {required this.dataUpdating, required super.data});

  @override
  List<Object> get props => [];
}

class IncomeCategoryUpdated extends IncomeCategoryState {
  final IncomeCategory dataUpdated;

  const IncomeCategoryUpdated(
      {required this.dataUpdated, required super.data});

  @override
  List<Object> get props => [];
}

class IncomeCateogryError extends IncomeCategoryState {
  final Failure failure;

  const IncomeCateogryError({required super.data, required this.failure});

  @override
  List<Object> get props => [];
}
