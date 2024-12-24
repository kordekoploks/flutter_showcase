import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? _message;

  Failure([this._message]);

  String get message => _message ?? '';

  @override
  List<Object> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  ServerFailure([String? message]) : super(message);
}

class CacheFailure extends Failure {
  CacheFailure([String? message]) : super(message);
}

class NetworkFailure extends Failure {
  NetworkFailure([String? message]) : super(message);
}

class ExceptionFailure extends Failure {
  ExceptionFailure([String? message]) : super(message);
}

class CredentialFailure extends Failure {
  CredentialFailure([String? message]) : super(message);
}

class AuthenticationFailure extends Failure {
  AuthenticationFailure([String? message]) : super(message);
}
