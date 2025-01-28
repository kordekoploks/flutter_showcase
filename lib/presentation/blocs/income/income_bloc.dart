import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../data/models/income/income_model.dart';
import '../../../domain/entities/income/income.dart';
import '../../../domain/usecases/income/save_income_usecase.dart';


part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  final SaveIncomeUseCase _saveIncomeUseCase;

  IncomeBloc(
    this._saveIncomeUseCase,
  ) : super(const IncomeLoading(data: [])) {
    on<AddIncome>(_onAddIncome);
  }


  void _onAddIncome(AddIncome event, Emitter<IncomeState> emit) async {
    try {
      emit(IncomeLoading(data: state.data));
      final cashedResult = await _saveIncomeUseCase(event._incomeModel);
      cashedResult.fold(
        (failure) => emit(IncomeError(
          data: state.data,
          failure: failure,
        )),
        (newData) {
          // Add the newly created subcategory to the existing list
          final updatedData = List<Income>.from(state.data)..add(newData);

          emit(IncomeAdded(dataAdded: newData, data: updatedData));
        },
      );
    } catch (e) {
      emit(IncomeError(
        data: state.data,
        failure: ExceptionFailure(),
      ));
    }
  }

}
