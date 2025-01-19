import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../data/models/account/account_model.dart';
import '../../../domain/entities/account/account.dart';
import '../../../domain/usecases/account/add_account_usecase.dart';
import '../../../domain/usecases/account/get_cached_account_usecase.dart';

part 'account_event.dart';

part 'account_state.dart';


class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetCachedAccountUseCase _getCachedAccountsUseCase;
  final AddAccountUseCase _addAccountUseCase;

  AccountBloc(
      this._getCachedAccountsUseCase,
      this._addAccountUseCase)
      : super(const AccountLoading(data: [])) {
    on<GetAccount>(_onLoadAccount);
    on<AddAccount>(_onAddAccount);
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
}