part of 'income_bloc.dart';

abstract class IncomeEvent extends Equatable {
  const IncomeEvent();
}

class AddIncome extends IncomeEvent {
  final IncomeModel _incomeModel;
  const AddIncome(this._incomeModel);

  @override
  List<Object> get props => [];
}
class IncomeLoading extends IncomeState {
  const IncomeLoading({required super.data});

  @override
  List<Object> get props => [];
}

class IncomeError extends IncomeState {
  final Failure failure;

  const IncomeError({required super.data, required this.failure});

  @override
  List<Object> get props => [];
}

