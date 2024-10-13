import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class BaseStateList<T> extends Equatable {
  final List<T> data;

  const BaseStateList({required this.data});
}

class StateInitial<T> extends BaseStateList<T> {
  const StateInitial({required super.data});

  @override
  List<Object> get props => [];
}

class StateLoading<T> extends BaseStateList<T> {
  const StateLoading({required super.data});

  @override
  List<Object> get props => [];
}

class StateCacheLoaded<T> extends BaseStateList<T> {
  const StateCacheLoaded({required super.data});

  @override
  List<Object> get props => [];
}

class StateEmpty<T> extends BaseStateList<T> {
  const StateEmpty({required super.data});

  @override
  List<Object> get props => [];
}

class StateAdded<T> extends BaseStateList<T> {
  final T dataAdded;

  const StateAdded({required this.dataAdded, required super.data});

  @override
  List<T> get props => [dataAdded];
}

class StateDeleted<T> extends BaseStateList<T> {
  final T dataDeleted;

  const StateDeleted({required this.dataDeleted, required super.data});

  @override
  List<T> get props => [dataDeleted];
}

class StateLoaded<T> extends BaseStateList<T> {
  const StateLoaded({required super.data});

  @override
  List<Object> get props => [];
}

class StateUpdating<T> extends BaseStateList<T> {
  final T dataUpdating;

  const StateUpdating({required this.dataUpdating, required super.data});

  @override
  List<T> get props => [dataUpdating];
}

class StateUpdated<T> extends BaseStateList<T> {
  final T dataUpdated;

  const StateUpdated({required this.dataUpdated, required super.data});

  @override
  List<T> get props => [dataUpdated];
}

class StateError<T> extends BaseStateList<T> {
  final Failure failure;

  const StateError({required super.data, required this.failure});

  @override
  List<Object> get props => [failure];
}
