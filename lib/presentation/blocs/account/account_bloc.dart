import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../data/models/account/account_model.dart';
import '../../../domain/entities/account/Account.dart';
import '../../../domain/usecases/account/get_cached_account_usecase.dart';

part 'account_event.dart';

part 'account_state.dart';


class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetCachedAccountUseCase _getCachedAccountsUseCase;

  AccountBloc(this._getCachedAccountsUseCase)
      : super(const AccountLoading(data: [])) {
    on<GetAccount>(_onLoadAccount);
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
}