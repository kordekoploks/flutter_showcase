import 'package:equatable/equatable.dart';

class Setting extends Equatable {
  final bool darkMode;

  const Setting({
    this.darkMode = false,
  });

  @override
  List<Object> get props => [
    darkMode
  ];
}