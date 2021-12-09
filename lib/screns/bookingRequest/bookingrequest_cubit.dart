import 'dart:io';

//import 'package:addresslistapp/Address.dart';
//import 'package:addresslistapp/data/api_client.dart';
//import 'package:cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxiapp/base/base/base_state.dart';
import 'package:taxiapp/base/base_repo.dart';


//import 'base_state.dart';

final String token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZDY2YjhmOTMzMWJmMmU2YWY0OTdjOWMzYTUxMzllNGRlOGVmZTQ0YmM3Mzc5Nzc2YTc2OWY3ZDc0MWI3MjUyYTc4NTMzMTBmOTk0Y2FmOTIiLCJpYXQiOjE2MjMwNTk2MDAuNzEzMzMsIm5iZiI6MTYyMzA1OTYwMC43MTMzMzMsImV4cCI6MTY1NDU5NTYwMC43MDY2NzUsInN1YiI6IjEzMCIsInNjb3BlcyI6W119.VxsSMyUQzI3YOotDoSHaR7mnagWyFUgKweA803oeQuSwdgjfgjYJFBHL_0DdHIg9jDXVhOxX-yyhhBxUVYhhR9060VlQpWW16vtHG_v3gbRl7EJAFqJOEYTv1g6U6Zr-xind5g07w-B1j25vZU1ftXtn8M2UDDIEBQdKBbuyQa9KP0mZ3LyOtBJ_ZO26pkgOyfHYINHoHG4NnedEieRaPBvmMtiWQ5JGY9H4M1_N2iRnEk-xTxhhC_sp-AV_JQLB9fDv-gGvWeOD26GuM0Pa4cMjVHYYQOwJPmjiVR_3PviSBMMds9RlvYo4tLcdMvsS_Pf4xP5DSb7wff68dBn9LtW8DMZcopXrmUVFLM56LL7F38F2e-fR2nbmU6PzLZVNgX2EUDaLqWMhOwLm-KiNKCFNZRLucGEVrc2FAw8gxiyL9kJXvb0au4YS6p19kz4fYuZu-6chChmsY11tIjFW5OlabPaNQ4QAGWK52z83ZPT0xx6tUy8aR9ZTX8_tpn7bYqtBxaA-LNqtQjALrH91RvLktBInP_7U3kcuR4yXHJlu3dMR9WPYai_pDTAyLvP77YaGwCH1Co13JePS7R9prhm-YzruPRe9CKj1_OvXYO970X6ymzBUBydvCzRuRNYQAns0EBV-ThLvqQsyLFPdAhWA4xGNCTzCnEgzwg8zRIY";

class BookingRequestCubit extends Cubit<BaseState> {
  BookingRequestCubit({ this.repo,this.accessToken}) : super(InitialState()){
    getAllAddresses(accessToken!);
  }
  final BaseRepo? repo;
  final String? accessToken;

  void getAllAddresses(String accessToken) async {
    // print("AccessToken => $accessToken");
    try {
      emit(LoadingState());
      final result = await repo!.getBookingRequest(accessToken);
      emit(SuccessState<dynamic>(response: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
  void acceptBooking( param,String accessToken) async {
    // print("AccessToken => $accessToken");
    try {
      emit(LoadingState());
      final result = await repo!.acceptBookingRequest(param, accessToken);
      emit(SuccessState<dynamic>(response: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
  void declineBooking( param,String accessToken) async {
    // print("AccessToken => $accessToken");
    try {
      emit(LoadingState());
      final result = await repo!.declineBookingRequest(param,accessToken);
      emit(SuccessState<dynamic>(response: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}

