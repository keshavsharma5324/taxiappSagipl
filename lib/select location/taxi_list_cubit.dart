//import 'package:booking_package/models/response/master_response.dart';
//import 'package:cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxiapp/Model/master_response.dart';
import 'package:taxiapp/base/base/base_state.dart';
import 'package:taxiapp/utils/shared_preference_utils.dart';
//import '../../base/base_state.dart';
import '../../repo/booking_repo.dart';
//import 'package:booking_package/utils/shared_preference_utils.dart';


class TaxiListCubit extends Cubit<BaseState> {

  final BookingRepo? repo;
  TaxiListCubit({this.repo}) : super(InitialState());

  void getTaxiList() async {
    try {
      emit(LoadingState());
      var accessToken = await SharedPreferenceUtils().getAccessToken();
      final result = await repo!.getTaxiList(accessToken);
      emit(SuccessState<MasterResponse>(response: result));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }
}
