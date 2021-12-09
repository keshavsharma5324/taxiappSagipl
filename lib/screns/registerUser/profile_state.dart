import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ProfileState extends Equatable {}

class ProfileInitialState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class GetOtpLoadingState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileSuccessState<R> extends ProfileState {
  final R response;
  ProfileSuccessState(this.response);

  @override
  List<Object> get props => [response!];
}

class ProfileUpdateVerifyState<R> extends ProfileState {
  final R response;
  ProfileUpdateVerifyState(this.response);

  @override
  List<Object> get props => [response!];
}

class GetProfileDataState<R> extends ProfileState {
  final R response;
  GetProfileDataState(this.response);

  @override
  List<Object> get props => [response!];
}

/*class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState(this.message);
  @override
  List<Object> get props => [];
}*/

class ProfileErrorState<R> extends ProfileState {
  final R response;

  ProfileErrorState(this.response);

  @override
  List<Object> get props => [response!];
}

class PicUpdateSuccessState extends ProfileState {
  final bool isSuccess;
  PicUpdateSuccessState(this.isSuccess);
  @override
  List<Object> get props => [];
}

class SignOutSuccessState extends ProfileState {
  final bool isLogout;
  SignOutSuccessState(this.isLogout);
  @override
  List<Object> get props => [];
}
