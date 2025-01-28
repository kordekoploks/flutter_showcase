part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  final List<Account> data;
  const AccountState({required this.data});
}

class AccountLoading extends AccountState {
  const AccountLoading({required super.data});

  @override
  List<Object> get props => [];
}

class AccountCacheLoaded extends AccountState {
  const AccountCacheLoaded({required super.data});

  @override
  List<Object> get props => [];
}


class AccountEmpty extends AccountState {
  const AccountEmpty({required super.data});

  @override
  List<Object> get props => [];
}

class AccountAdded extends AccountState {
  final Account dataAdded;

  const AccountAdded({required this.dataAdded, required super.data});

  @override
  List<Object> get props => [];
}

class AccountDeleted extends AccountState {
  final Account dataDeleted;

  const AccountDeleted(
      {required this.dataDeleted, required super.data});

  @override
  List<Object> get props => [];
}

class AccountLoaded extends AccountState {
  const AccountLoaded({required super.data});

  @override
  List<Object> get props => [];
}

class AccountUpdating extends AccountState {
  final Account dataUpdating;

  const AccountUpdating(
      {required this.dataUpdating, required super.data});

  @override
  List<Object> get props => [];
}

class AccountUpdated extends AccountState {
  final Account dataUpdated;

  const AccountUpdated(
      {required this.dataUpdated, required super.data});

  @override
  List<Object> get props => [];
}

class AccountError extends AccountState {
  final Failure failure;

  const AccountError({required super.data, required this.failure});

  @override
  List<Object> get props => [];
}