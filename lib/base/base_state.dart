import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class BaseState extends Equatable {}

class InitialState extends BaseState {
  @override
  List<Object> get props => [];
}

class LoadingState extends BaseState {
  @override
  List<Object> get props => [];
}

class GettingDataState extends BaseState {
  @override
  List<Object> get props => [];
}

class SuccessState<R> extends BaseState {
  R? response;

  SuccessState({@required this.response});

  @override
  List<Object> get props => [response!];
}

class UserDataSuccessState<R> extends BaseState {
  final R? response;
  UserDataSuccessState({@required this.response});

  @override
  List<Object> get props => [response!];
}

/*class ErrorState extends BaseState {
  String message;

  ErrorState({@required this.message});

  @override
  List<Object> get props => [message];
}*/

class AuthErrorState<R> extends BaseState {
  final R? response;

  AuthErrorState({@required this.response});

  @override
  List<Object> get props => [response!];
}

class SignOutSuccessState extends BaseState {
  final bool isLogout;
  SignOutSuccessState(this.isLogout);
  @override
  List<Object> get props => [];
}
class ErrorState<R> extends BaseState {
  final R response;

  ErrorState(this.response);

  @override
  List<Object> get props => [response!];
}
