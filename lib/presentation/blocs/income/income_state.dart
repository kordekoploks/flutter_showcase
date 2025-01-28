part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  final List<Income> data;
  const IncomeState({required this.data});
}


class IncomeAdded extends IncomeState {
  final Income dataAdded;

  const IncomeAdded({required this.dataAdded, required super.data});

  @override
  List<Object> get props => [];
}
