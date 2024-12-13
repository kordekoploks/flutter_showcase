part of 'user_bloc.dart';

// kelas main parent  yang akan jadi acuan pada fitur
@immutable
abstract class UserEvent {}

class SignInUser extends UserEvent {
  final SignInParams params;
  SignInUser(this.params);
}
//turunan event per halaman
class SignUpUser extends UserEvent {
  final SignUpParams params;
  SignUpUser(this.params);
  //copy dan ganti jadi edit/update user
}

//turunan event per halaman
class EditUser extends UserEvent {
  final EditParams params;
  EditUser(this.params);
//copy dan ganti jadi edit/update user
}

class EditFullNameUser extends UserEvent {
  final EditFullNameParams params;
  EditFullNameUser(this.params);
//copy dan ganti jadi edit/update user
}

class SignOutUser extends UserEvent {}

class CheckUser extends UserEvent {}
