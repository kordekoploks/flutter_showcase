import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../data/models/account/account_model.dart';
import '../../../domain/entities/account/account.dart';
import '../../../domain/usecases/account/add_account_usecase.dart';
import '../../../domain/usecases/account/delete_account_usecase.dart';
import '../../../domain/usecases/account/get_cached_account_usecase.dart';
import '../../../domain/usecases/account/update_account_usecase.dart';

part 'account_event.dart';

part 'account_state.dart';


class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetCachedAccountUseCase _getCachedAccountsUseCase;
  final AddAccountUseCase _addAccountUseCase;
  final UpdateAccountUseCase _updateAccountUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;

  AccountBloc(
      this._getCachedAccountsUseCase,
      this._addAccountUseCase,
      this._updateAccountUseCase,
      this._deleteAccountUseCase)
      : super(const AccountLoading(data: [])) {
    on<GetAccount>(_onLoadAccount);
    on<AddAccount>(_onAddAccount);
    on<UpdateAccount>(_onUpdateAccount);
    on<DeleteAccount>(_onDeleteAccount);
  }

  void _onLoadAccount(GetAccount event, Emitter<AccountState> emit) async {
    try {
      emit(const AccountLoading(data: []));
      final cashedResult = await _getCachedAccountsUseCase(NoParams());
      cashedResult.fold(
            (failure) =>
        (emit(AccountError(data: state.data, failure: failure))),
            (accounts) {
          if (accounts.isEmpty) {
            emit(AccountEmpty(
              data: accounts,
            ));
          } else {
            emit(AccountLoaded(
              data: accounts,
            ));
          }
        },
      );
    } catch (e) {
      EasyLoading.showError(e.toString());
      emit(AccountError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }
  void _onAddAccount(
      AddAccount event, Emitter<AccountState> emit) async {
  try {
  emit(AccountLoading(data: state.data));
  final cashedResult = await _addAccountUseCase(event._accountModel);
  cashedResult.fold(
  (failure) => emit(AccountError(
  data: state.data,
  failure: failure,
  )
  ),
  (newData) {
  // Add the newly created subcategory to the existing list
  final updatedData = List<Account>.from(state.data)
  ..add(newData);

  emit(AccountAdded(dataAdded: newData, data: updatedData));
  },
  );
  } catch (e) {
  emit(AccountError(
  data: state.data,
  failure: ExceptionFailure(),
  )
  );
  }
  }

void _onUpdateAccount(
    UpdateAccount event, Emitter<AccountState> emit) async {
  try {
    emit(AccountUpdating(
        dataUpdating: event._accountModel, data: state.data));
    final updatedResult = await _updateAccountUseCase(event._accountModel);

    updatedResult.fold(
            (failure) => emit(AccountError(
          data: state.data,
          failure: failure,
        )), (updatedAccount) {
      final index = state.data
          .indexWhere((account) => account.id == updatedAccount.id);

      // If found, update the list with the new data
      if (index != -1) {
        final updatedData = List<Account>.from(state.data);
        updatedData[index] = updatedAccount;

        // Emit the updated state
        emit(AccountUpdated(
          dataUpdated: updatedAccount,
          data: updatedData,
        ));
      } else {
        // If not found, just emit the updated state without modifying the list
        emit(AccountUpdated(
          dataUpdated: updatedAccount,
          data: state.data,
        ));
      }
      ;
    });
  } catch (e) {
    emit(AccountError(
      data: state.data,
      failure: ExceptionFailure(),
    ));
  }
}

void _onDeleteAccount(
    DeleteAccount event, Emitter<AccountState> emit) async {
  try {
    emit(AccountLoading(data: state.data));
    final cashedResult = await _deleteAccountUseCase(event._accountModel);
    cashedResult.fold(
            (failure) => emit(AccountError(
          data: state.data,
          failure: failure,
        )), (account) {
      final updatedData = List<Account>.from(state.data)
        ..removeWhere((account) => account.id == event._accountModel.id);

      emit(AccountDeleted(
        dataDeleted: account,
        data: updatedData,
      ));
      if(updatedData.isEmpty){
        emit(AccountEmpty(
            data: updatedData
        ));
      }
    });
  } catch (e) {
    emit(AccountError(
      data: state.data,
      failure: ExceptionFailure(),
    ));
  }
}

}