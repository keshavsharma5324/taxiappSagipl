import 'dart:ui';

//import 'package:booking_package/models/response/ride_bean.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:customer/utils/app_colors.dart';
//import 'package:customer/utils/constants.dart';
import 'package:taxiapp/Model/response/ride_bean.dart';
import '../../app_colors.dart';
import '../../constants.dart';
import '../custom_views/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'my_text.dart';

class BookingConfirmedDialog extends StatefulWidget {
  final RideBean? data;
  final Function? onClickCancel;

  BookingConfirmedDialog({this.data, this.onClickCancel});

  @override
  _BookingConfirmedDialogState createState() => _BookingConfirmedDialogState();
}

class _BookingConfirmedDialogState extends State<BookingConfirmedDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                margin: EdgeInsets.symmetric(horizontal: 15),
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 25, left: 20, right: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            // NavigationService().popUntil();
                          },
                          child: SvgPicture.asset(
                            '${Constants.baseAssetPathBooking}back_icon.svg',
                            color: AppColors.themeGreenColor,
                            width: 16,
                            height: 16,
                          ),
                        ),
                        SizedBox(height: 15),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.themeRedColor,
                                      shape: BoxShape.circle,
                                    ),
                                    height: 7,
                                    width: 7,
                                  ),
                                  Expanded(
                                      child: Container(
                                    color: Color(0XFF2D6159),
                                    width: 1,
                                  )),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 13),
                                    height: 7,
                                    width: 7,
                                    color: AppColors.themeGreenColor,
                                  )
                                ],
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyText(
                                        text:
                                            widget.data!.locationPickup!.address.toString(),
                                        maxLines: 1,
                                        color: AppColors.themeGreenColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                    SizedBox(height: 5),
                                    Divider(
                                      thickness: 1.0,
                                      color: AppColors.themeGreenColor,
                                      height: 1.5,
                                    ),
                                    SizedBox(height: 20),
                                    MyText(
                                        text: widget.data!.locationDrop!.address.toString(),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                        color: AppColors.themeGreenColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500),
                                    SizedBox(height: 5),
                                    Divider(
                                      thickness: 1.0,
                                      color: AppColors.themeGreenColor,
                                      height: 1.5,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                      child: Container(
                        margin: EdgeInsets.only(right: 20),
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 10.0,
                              ),
                            ],
                            color: Colors.white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.location_searching_rounded,
                            size: 28,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onTap: () {}),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0))),
                      margin: EdgeInsets.zero,
                      elevation: 10,
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 15, bottom: 25, left: 20, right: 20),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  visible: (widget.data!.rideStatus ==
                                          Constants.notificationTypeAccepted ||
                                      widget.data!.rideStatus ==
                                          Constants
                                              .notificationTypeDriverArrived),
                                  child: InkWell(
                                    onTap: () {
                                      launch(
                                          'tel://${widget.data!.driver!.ext}${widget.data!.driver!.phoneNumber}');
                                    },
                                    child: Image.asset(
                                      '${Constants.baseAssetPathBookingPng}call.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ),
                                ClipOval(
                                  child: Container(
                                    width: 60.0,
                                    height: 60.0,
                                    alignment: Alignment.center,
                                    decoration: new BoxDecoration(
                                      color: AppColors.themeGreenColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      '${Constants.baseUrlImage}${widget.data!.driver!.picUrl}',
                                      width: 60.0,
                                      height: 60.0,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: (widget.data!.rideStatus ==
                                          Constants.notificationTypeAccepted ||
                                      widget.data!.rideStatus ==
                                          Constants
                                              .notificationTypeDriverArrived),
                                  child: InkWell(
                                    onTap: () {
                                      launch(
                                          'sms://${widget.data!.driver!.ext}${widget.data!.driver!.phoneNumber}');
                                    },
                                    child: Image.asset(
                                      '${Constants.baseAssetPathBookingPng}msg.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            MyText(
                                text: widget.data!.rideStatus ==
                                        Constants.notificationTypeAccepted
                                    ? 'Booking Confirmed'
                                    : widget.data!.rideStatus ==
                                            Constants
                                                .notificationTypeDriverArrived
                                        ? 'Driver Arrived'
                                        : widget.data!.rideStatus ==
                                                Constants
                                                    .notificationTypeRideStarted
                                            ? 'Ride Started'
                                            : widget.data!.rideStatus ==
                                                    Constants
                                                        .notificationTypeRideCompleted
                                                ? 'Ride Completed'
                                                : '',
                                color: AppColors.themeGreenColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0),
                            SizedBox(height: 15),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MyText(
                                          textAlign: TextAlign.center,
                                          maxLines: 4,
                                          text: widget.data!.driver!.name.toString(),
                                          color: AppColors.themeGreenColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16.0),
                                      MyText(
                                          textAlign: TextAlign.center,
                                          text: widget.data!.rideStatus ==
                                                  Constants
                                                      .notificationTypeAccepted
                                              ? '${widget.data!.driverCurrentLocationToSourceTime} to reach\n${double.parse(widget.data!.driverCurrentLocationToSourceDistance.toString()).toStringAsFixed(2)} Miles'
                                              : '${widget.data!.time} to reach\n${double.parse(widget.data!.distance.toString()).toStringAsFixed(2)} Miles',
                                          color: AppColors.hintColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0),
                                    ],
                                  )),
                                  Column(
                                    children: [
                                      Expanded(
                                          child: Container(
                                              width: 1,
                                              color:
                                                  AppColors.themeGreenColor)),
                                    ],
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                              '${Constants.baseAssetPathBooking}car_small.svg'),
                                          SizedBox(width: 5),
                                          MyText(
                                              text: widget.data!.taxiName.toString(),
                                              color: AppColors.hintColor,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 16.0),
                                        ],
                                      ),
                                      MyText(
                                          text: widget.data!.taxiRegistration.toString(),
                                          color: AppColors.themeGreenColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14.0),
                                    ],
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(height: 30),
                            Visibility(
                                visible: widget.data!.rideStatus ==
                                    Constants.notificationTypeAccepted,
                                child: CustomButton(
                                  label: 'Cancel Ride',
                                  onClick: () {
                                    widget!.onClickCancel!(widget.data!.rideId);
                                  },
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ]),
      ),
    );
  }
}
