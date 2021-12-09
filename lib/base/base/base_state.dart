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

class SuccessState<R> extends BaseState {
  R? response;

  SuccessState({@required this.response});

  @override
  List<Object> get props => [response!];
}

class ErrorState extends BaseState {
  String? message;

  ErrorState({@required this.message});

  @override
  List<Object> get props => [message!];
}
