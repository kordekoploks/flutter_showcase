part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserLogged extends UserState {
  final User user;
  UserLogged(this.user);
  @override
  List<Object> get props => [user];
  //copy dan ganti menjadi edit/update user= user terupdate
}

class UserEdited extends UserState {
  final User user;
  UserEdited(this.user);
  @override
  List<Object> get props => [user];
//copy dan ganti menjadi edit/update user= user terupdate
}

class UserEdit extends UserState {
  final User user;
  UserEdit(this.user);
  @override
  List<Object> get props => [user];
//copy dan ganti menjadi edit/update user= user terupdate
}


class UserEditFail extends UserState {
  final Failure failure;
  UserEditFail(this.failure);
  @override
  List<Object> get props => [failure];
//buat user edit/update, failure ganti update
}


class UserLoggedFail extends UserState {
  final Failure failure;
  UserLoggedFail(this.failure);
  @override
  List<Object> get props => [failure];
  //buat user edit/update, failure ganti update
}

class UserLoggedOut extends UserState {
  @override
  List<Object> get props => [];
}
