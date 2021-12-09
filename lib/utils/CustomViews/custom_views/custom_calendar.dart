//Schedule ride Bottom sheet for book an instructor......
//import 'package:booking_package/custom_views/custom_button.dart';
//import 'package:booking_package/custom_views/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
//import 'package:customer/utils/app_colors.dart';
import 'package:taxiapp/utils/CustomViews/custom_views/custom_button.dart';
import 'package:taxiapp/utils/CustomViews/custom_views/my_text.dart';

import '../../app_colors.dart';

class ScheduleRideInstructor extends StatefulWidget {
  final Function? onSubmitClick;

  ScheduleRideInstructor({this.onSubmitClick});

  @override
  _ScheduleRideInstructorState createState() => _ScheduleRideInstructorState();
}

class _ScheduleRideInstructorState extends State<ScheduleRideInstructor> {
  DateTime? selectedDateTime;
  DateTime? currentDateTime;

  @override
  void initState() {
    super.initState();

    selectedDateTime = DateTime.now().add(Duration(minutes: 30)).trimMilliseconds;
    currentDateTime = DateTime.now().add(Duration(minutes: 30)).trimMilliseconds;
  }

  @override
  Widget build(BuildContext context) {
    return scheduleRideInstructorSheet(context);
  }

  Widget scheduleRideInstructorSheet(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: 'Schedule a ride',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.themeGreenColor,
                ),
                MyText(
                  text: DateFormat("dd MMM, hh:mm aa").format(selectedDateTime!),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.themeGreenColor,
                )
              ],
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).copyWith().size.height / 3,
                child: _showCupertinoDatePicker()),
            SizedBox(height: 15),
            CustomButton(
                label: 'Confirm',
                onClick: () {
                  print(
                      "selectedDate => ${DateTime.now().trimMilliseconds} :: $currentDateTime :: ${selectedDateTime!.trimMilliseconds} :: ${selectedDateTime!.trimMilliseconds.compareTo(currentDateTime!.trimMilliseconds)}");
                  if (selectedDateTime!.trimMilliseconds
                          .compareTo(currentDateTime!.trimMilliseconds) >
                      0) {
                    widget!.onSubmitClick!({
                      "pickup_date_time": DateFormat("yyyy-MM-dd HH:mm:ss")
                          .format(selectedDateTime!.trimMilliseconds),
                      "is_schedule": true
                    });
                  } else {
                    Fluttertoast.showToast(
                        msg: "Please select valid date",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER);
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget _showCupertinoDatePicker() {
    return CupertinoDatePicker(
      minimumDate: DateTime.now().add(Duration(minutes: 30)),
      initialDateTime: DateTime.now().add(Duration(minutes: 30)),
      maximumDate: DateTime.now().add(Duration(days: 7)),
      onDateTimeChanged: (DateTime newDate) {
        selectedDateTime = newDate;
        print('2. onDateTimeChanged : $selectedDateTime');
        print(
            'dateConverted -> ${DateFormat("dd MMM, hh:mm aa").format(selectedDateTime!)}');
        setState(() {});
      },
      minimumYear: 2021,
      maximumYear: 2021,
      mode: CupertinoDatePickerMode.dateAndTime,
    );
  }

  Future<Null> getReviewBookingInstructorDialog() async {
//     String returnVal = await showDialog(
//         context: context,
//         builder: (context)=> ReviewBookingDialog(scheduleDate: DateFormat("dd MMM, hh:mm aa").format(selectedDateTime),),
//         barrierDismissible: false);
//
//     if (returnVal == 'logout') {
// // _dashboardController.logoutUser();
//     }
  }
}

extension DateTimeExtension on DateTime {
  get trimMilliseconds {
    if (this != null)
      return new DateTime(
          this.year, this.month, this.day, this.hour, this.minute, 0, 0);
    else
      return null;
  }
}
