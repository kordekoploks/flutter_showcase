import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../Account.dart';
import 'get_cached_account_usecase.dart';

part 'account_event.dart';
part 'account_state.dart';



class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetCachedAccountUseCase _getCachedUseCase;

  AccountBloc(
  this._getCachedAccountUseCase)
      : super(const AccountLoading(data: [])) {
  on<GetAccount>(_onLoadAccount);


  }
  void _onLoadCategories(
      GetAccount event, Emitter<AccountState> emit) async {
    try {
      emit(const AccountLoading(data: []));
      final cashedResult = await _getCachedAccountUseCase(NoParams());
      cashedResult.fold(
            (failure) =>
        (emit(AccountError(data: state.data, failure: failure))),
            (categories) {
          if (categories.isEmpty) {
            emit(AccountEmpty(
              data: categories,
            ));
          } else {
            emit(AccountLoaded(
              data: categories,
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
}