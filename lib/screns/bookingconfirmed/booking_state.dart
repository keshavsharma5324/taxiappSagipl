import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class BookingState extends Equatable {}

class BookingInitialState extends BookingState {
  @override
  List<Object> get props => [];
}

class BookingLoadingState extends BookingState {
  @override
  List<Object> get props => [];
}

class GetOtpLoadingState extends BookingState {
  @override
  List<Object> get props => [];
}

class BookingSuccessState<R> extends BookingState {
  final R response;
  BookingSuccessState(this.response);

  @override
  List<Object> get props => [response!];
}

class BookingUpdateVerifyState<R> extends BookingState {
  final R response;
  BookingUpdateVerifyState(this.response);

  @override
  List<Object> get props => [response!];
}

class GetBookingDataState<R> extends BookingState {
  final R response;
  GetBookingDataState(this.response);

  @override
  List<Object> get props => [response!];
}

/*class BookingErrorState extends BookingState {
  final String message;
  BookingErrorState(this.message);
  @override
  List<Object> get props => [];
}*/

class BookingErrorState<R> extends BookingState {
  final R response;

  BookingErrorState(this.response);

  @override
  List<Object> get props => [response!];
}

class PicUpdateSuccessState extends BookingState {
  final bool isSuccess;
  PicUpdateSuccessState(this.isSuccess);
  @override
  List<Object> get props => [];
}

class SignOutSuccessState extends BookingState {
  final bool isLogout;
  SignOutSuccessState(this.isLogout);
  @override
  List<Object> get props => [];
}
