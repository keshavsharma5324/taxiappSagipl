import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class NeearbyState extends Equatable {}

class NeearbyInitialState extends NeearbyState {
  @override
  List<Object> get props => [];
}

class NeearbyLoadingState extends NeearbyState {
  @override
  List<Object> get props => [];
}

class GetOtpLoadingState extends NeearbyState {
  @override
  List<Object> get props => [];
}

class NeearbySuccessState<R> extends NeearbyState {
  final R response;
  NeearbySuccessState(this.response);

  @override
  List<Object> get props => [response!];
}

class BookingUpdateVerifyState<R> extends NeearbyState {
  final R response;
  BookingUpdateVerifyState(this.response);

  @override
  List<Object> get props => [response!];
}

class GetNeearbyDataState<R> extends NeearbyState {
  final R response;
  GetNeearbyDataState(this.response);

  @override
  List<Object> get props => [response!];
}

/*class BookingErrorState extends BookingState {
  final String message;
  BookingErrorState(this.message);
  @override
  List<Object> get props => [];
}*/

class NearbyErrorState<R> extends NeearbyState {
  final R response;

  NearbyErrorState(this.response);

  @override
  List<Object> get props => [response!];
}

class PicUpdateSuccessState extends NeearbyState {
  final bool isSuccess;
  PicUpdateSuccessState(this.isSuccess);
  @override
  List<Object> get props => [];
}

class SignOutSuccessState extends NeearbyState {
  final bool isLogout;
  SignOutSuccessState(this.isLogout);
  @override
  List<Object> get props => [];
}
