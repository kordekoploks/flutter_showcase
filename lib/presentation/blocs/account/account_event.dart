part of 'account_bloc.dart';


abstract class AccountEvent extends Equatable {
  const AccountEvent();
}

class GetAccount extends AccountEvent {
  const GetAccount();

  @override
  List<Object> get props => [];
}

class FilterCategories extends AccountEvent {
  final String keyword;
  const FilterCategories(this.keyword);

  @override
  List<Object> get props => [];
}

class AddAccount extends AccountEvent {
  final AccountModel _accountModel;
  const AddAccount(this._accountModel);

  @override
  List<Object> get props => [];
}

class UpdateAccount extends AccountEvent {
  final AccountModel _accountModel;
  const UpdateAccount(this._accountModel);

  @override
  List<Object> get props => [];
}

class DeleteAccount extends AccountEvent {
  final Account _accountModel;
  const DeleteAccount(this._accountModel);

  @override
  List<Object> get props => [];
}


